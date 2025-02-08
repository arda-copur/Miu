
const express = require('express');
const router = express.Router();
const Friend = require('../models/Friend');
const User = require('../models/User');
const { protect } = require('../middleware/auth');


router.post('/request/:friendId', protect, async (req, res) => {
  try {
    const existingFriend = await Friend.findOne({
      requester: req.user.id,
      recipient: req.params.friendId
    });

    if (existingFriend) {
      return res.status(400).json({ message: 'Zaten arkadaşlık isteği gönderdiniz' });
    }

    const newFriendRequest = new Friend({
      requester: req.user.id,
      recipient: req.params.friendId
    });

    await newFriendRequest.save();
    res.status(200).json({ message: 'Arkadaşlık isteği gönderildi' });
  } catch (error) {
    res.status(500).json({ message: 'Bir hata oluştu' });
  }
});


router.post('/accept/:friendId', protect, async (req, res) => {
  try {
    const friendRequest = await Friend.findOne({
      requester: req.params.friendId,
      recipient: req.user.id,
      status: 'pending'
    });

    if (!friendRequest) {
      return res.status(404).json({ message: 'Arkadaşlık isteği bulunamadı' });
    }

    friendRequest.status = 'accepted';
    await friendRequest.save();
    res.status(200).json({ message: 'Arkadaşlık isteği kabul edildi' });
  } catch (error) {
    res.status(500).json({ message: 'Bir hata oluştu' });
  }
});


router.post('/reject/:friendId', protect, async (req, res) => {
  try {
    const friendRequest = await Friend.findOne({
      requester: req.params.friendId,
      recipient: req.user.id,
      status: 'pending'
    });

    if (!friendRequest) {
      return res.status(404).json({ message: 'Arkadaşlık isteği bulunamadı' });
    }

 
    await Friend.findByIdAndDelete(friendRequest._id);
    
    res.status(200).json({ message: 'Arkadaşlık isteği reddedildi' });
  } catch (error) {
    console.error('Reddetme hatası:', error);
    res.status(500).json({ message: 'Bir hata oluştu' });
  }
});


router.get('/status/:friendId', protect, async (req, res) => {
  try {
    const friendship = await Friend.findOne({
      $or: [
        { requester: req.user.id, recipient: req.params.friendId, status: 'accepted' },
        { requester: req.params.friendId, recipient: req.user.id, status: 'accepted' }
      ]
    });

    if (friendship) {
      return res.status(200).json({ isFriend: true });
    } else {
      return res.status(200).json({ isFriend: false });
    }
  } catch (error) {
    res.status(500).json({ message: 'Bir hata oluştu' });
  }
});

router.get('/requests', protect, async (req, res) => {
  try {
    const requests = await Friend.find({
      recipient: req.user.id,
      status: 'pending'
    })
    .populate('requester', 'username email profileImageUrl') 
    .select('-__v'); 


    const formattedRequests = requests.map(request => ({
      requestId: request._id,
      from: {
        userId: request.requester._id,
        username: request.requester.username,
        email: request.requester.email,
        profileImageUrl: request.requester.profileImageUrl
      },
      status: request.status,
      createdAt: request.createdAt
    }));

    res.status(200).json(formattedRequests);
  } catch (error) {
    console.error('Friend requests error:', error);
    res.status(500).json({ message: 'Bir hata oluştu' });
  }
});



router.get('/friends', protect, async (req, res) => {
  try {
    const friends = await Friend.find({
      $or: [
        { requester: req.user.id, status: 'accepted' },
        { recipient: req.user.id, status: 'accepted' }
      ]
    }).populate('requester recipient', 'username email profileImageUrl');

  
    console.log('Raw friends data:', friends);

    const friendsList = friends.map(friendship => {
      const friend = friendship.requester._id.toString() === req.user.id 
        ? friendship.recipient 
        : friendship.requester;

  
      console.log('Processing friend:', friend);

      return {
        userId: friend._id,
        username: friend.username,  
        email: friend.email,
        profileImageUrl: friend.profileImageUrl  
      };
    });



    res.status(200).json(friendsList);
  } catch (error) {
    console.error('Arkadaş listesi hatası:', error);
    res.status(500).json({ message: 'Arkadaş listesi alınırken bir hata oluştu' });
  }
});



router.get('/list/:userId', protect, async (req, res) => {
  try {
    const friends = await Friend.find({
      $or: [
        { requester: req.params.userId, status: 'accepted' },
        { recipient: req.params.userId, status: 'accepted' }
      ]
    }).populate('requester recipient', 'username email profileImageUrl');

    const friendsList = friends.map(friendship => {
      const friend = friendship.requester._id.toString() === req.params.userId 
        ? friendship.recipient 
        : friendship.requester;

      return {
        userId: friend._id,
        username: friend.username,
        email: friend.email,
        profileImageUrl: friend.profileImageUrl
      };
    });

    res.status(200).json(friendsList);
  } catch (error) {
    console.error('Arkadaş listesi hatası:', error);
    res.status(500).json({ message: 'Arkadaş listesi alınırken bir hata oluştu' });
  }
});
module.exports = router;
