const express = require('express');
const router = express.Router();
const Post = require('../models/Post');
const Friend = require('../models/Friend'); 
const User = require('../models/User');
const { protect } = require('../middleware/auth');
const { sendNotification } = require('../utils/notification');


router.post('/', protect, async (req, res) => {
  const { content } = req.body;

  try {
    const post = new Post({ userId: req.user.id, content });
    await post.save();
    

    const populatedPost = await Post.findById(post._id)
      .populate('userId', 'username profileImageUrl');


    const user = await User.findById(req.user.id);
    const friends = await User.find({ _id: { $in: user.friends } }); 

    const playerIds = friends
      .filter(friend => friend.oneSignalPlayerId) 
      .map(friend => friend.oneSignalPlayerId);


    const message = `${user.username} bir gönderi paylaştı: ${content}`;


    if (playerIds.length > 0) {
      await sendNotification(playerIds, message, { postId: post._id });
    }

    res.json(populatedPost);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Gönderi oluşturulamadı!' });
  }
});



router.put('/like/:id', protect, async (req, res) => {
  try {
    const post = await Post.findById(req.params.id)
      .populate('userId', 'username profileImageUrl');
    
    if (!post.likes.includes(req.user.id)) {
      post.likes.push(req.user.id);
      await post.save();
    }
    res.json(post);
  } catch (error) {
    res.status(500).json({ error: 'Beğeni başarısız!' });
  }
});


router.post('/comment/:id', protect, async (req, res) => {
  const { comment } = req.body;

  try {
    const post = await Post.findById(req.params.id);
    post.comments.push({ userId: req.user.id, text: comment });
    await post.save();

    const updatedPost = await Post.findById(req.params.id)
      .populate('userId', 'username profileImageUrl')
      .populate('comments.userId', 'username profileImageUrl');

    res.json(updatedPost);
  } catch (error) {
    res.status(500).json({ error: 'Yorum yapılamadı!' });
  }
});


router.put('/retweet/:id', protect, async (req, res) => {
  try {
    const post = await Post.findById(req.params.id)
      .populate('userId', 'username profileImageUrl');
    
    if (!post.retweets.includes(req.user.id)) {
      post.retweets.push(req.user.id);
      await post.save();
    }
    res.json(post);
  } catch (error) {
    res.status(500).json({ error: 'Retweet yapılamadı!' });
  }
});


router.get('/', protect, async (req, res) => {
  try {
    const posts = await Post.find()
      .populate('userId', 'username profileImageUrl')
      .populate('comments.userId', 'username profileImageUrl')
      .lean()
      .sort({ createdAt: -1 });

    const postsWithUserInteraction = posts.map(post => ({
      ...post,
      user: {
        id: post.userId._id,
        username: post.userId.username,
        profileImageUrl: post.userId.profileImageUrl
      },
      isLiked: post.likes.includes(req.user.id),
      isRetweeted: post.retweets.includes(req.user.id),
      likeCount: post.likes.length,
      commentCount: post.comments.length,
      retweetCount: post.retweets.length
    }));
    
    res.json(postsWithUserInteraction);
  } catch (error) {
    res.status(500).json({ error: 'Gönderiler alınırken hata oluştu!' });
  }
});


router.get('/feed', protect, async (req, res) => {
  try {
    const friends = await Friend.find({
      $or: [
        { requester: req.user.id, status: 'accepted' },
        { recipient: req.user.id, status: 'accepted' }
      ]
    });

    const friendIds = friends.map(friend => 
      friend.requester.toString() === req.user.id.toString() 
        ? friend.recipient 
        : friend.requester
    );

    friendIds.push(req.user.id);

    const posts = await Post.find({
      $or: [
        { userId: { $in: friendIds } },
        { 'retweets': { $in: friendIds } }
      ]
    })
    .populate('userId', 'username profileImageUrl')
    .populate('comments.userId', 'username profileImageUrl')
    .lean();

    const postsWithUserInteraction = posts.map(post => ({
      ...post,
      user: {
        id: post.userId._id,
        username: post.userId.username,
        profileImageUrl: post.userId.profileImageUrl
      },
      comments: post.comments.map(comment => ({
        ...comment,
        user: {
          id: comment.userId._id,
          username: comment.userId.username,
          profileImageUrl: comment.userId.profileImageUrl
        }
      })),
      isLiked: post.likes.some(id => id.toString() === req.user.id.toString()),
      isRetweeted: post.retweets.some(id => id.toString() === req.user.id.toString()),
      likeCount: post.likes.length,
      commentCount: post.comments.length,
      retweetCount: post.retweets.length
    }));

    res.json(postsWithUserInteraction);
  } catch (error) {
    console.error('Feed hatası:', error);
    res.status(500).json({ error: 'Gönderiler alınırken hata oluştu!' });
  }
});

router.get('/user-posts', protect, async (req, res) => {
  try {
    const posts = await Post.find({
      $or: [
        { userId: req.user.id },
        { retweets: req.user.id }
      ]
    })
    .populate('userId', 'username profileImageUrl')
    .populate('comments.userId', 'username profileImageUrl')
    .lean()
    .sort({ createdAt: -1 });

    if (!posts.length) {
      return res.json([]);
    }

    const postsWithUserInteraction = await Promise.all(posts.map(async post => {
      const retweetUsers = await User.find({
        _id: { $in: post.retweets }
      }).select('username profileImageUrl');

      return {
        ...post,
        user: {
          id: post.userId._id,
          username: post.userId.username,
          profileImageUrl: post.userId.profileImageUrl
        },
        comments: post.comments.map(comment => ({
          ...comment,
          user: {
            id: comment.userId._id,
            username: comment.userId.username,
            profileImageUrl: comment.userId.profileImageUrl
          }
        })),
        retweetedBy: retweetUsers.map(user => user.username),
        isLiked: post.likes.includes(req.user.id),
        isRetweeted: post.retweets.includes(req.user.id),
        likeCount: post.likes.length,
        commentCount: post.comments.length,
        retweetCount: post.retweets.length
      };
    }));

    res.json(postsWithUserInteraction);
  } catch (error) {
    console.error('Kullanıcı postları hatası:', error);
    res.status(500).json({ error: 'Gönderiler alınırken hata oluştu!' });
  }
});


router.get('/user/:userId', protect, async (req, res) => {
  try {
    const posts = await Post.find({
      $or: [
        { userId: req.params.userId },
        { retweets: req.params.userId }
      ]
    })
    .populate('userId', 'username profileImageUrl')
    .populate('comments.userId', 'username profileImageUrl')
    .lean()
    .sort({ createdAt: -1 });

    if (!posts.length) {
      return res.json([]);
    }

    const postsWithUserInteraction = await Promise.all(posts.map(async post => {
      const retweetUsers = await User.find({
        _id: { $in: post.retweets }
      }).select('username profileImageUrl');

      const originalPost = post.originalPostId ? await Post.findById(post.originalPostId).populate('userId', 'username profileImageUrl') : null;

      return {
        ...post,
        userId: {
          _id: post.userId._id,
          username: post.userId.username,
          profileImageUrl: post.userId.profileImageUrl
        },
        comments: post.comments.map(comment => ({
          ...comment,
          user: {
            id: comment.userId._id,
            username: comment.userId.username,
            profileImageUrl: comment.userId.profileImageUrl
          }
        })),
        retweetedBy: retweetUsers.map(user => user.username),
        isLiked: post.likes.includes(req.user.id),
        isRetweeted: post.retweets.includes(req.user.id),
        likeCount: post.likes.length,
        commentCount: post.comments.length,
        retweetCount: post.retweets.length,
        originalPost: originalPost ? {
          _id: originalPost._id,
          content: originalPost.content,
          userId: originalPost.userId
        } : null
      };
    }));

    res.json(postsWithUserInteraction);
  } catch (error) {
    console.error('Kullanıcı postları hatası:', error);
    res.status(500).json({ error: 'Gönderiler alınırken hata oluştu!' });
  }
});

module.exports = router;