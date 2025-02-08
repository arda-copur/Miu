
const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const fs = require('fs');
const User = require('../models/User');
const { protect } = require('../middleware/auth');



const uploadDir = 'uploads';
const profilesDir = 'uploads/profiles';

if (!fs.existsSync(uploadDir)){
    fs.mkdirSync(uploadDir);
}
if (!fs.existsSync(profilesDir)){
    fs.mkdirSync(profilesDir);
}


const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/profiles/');
  },
  filename: (req, file, cb) => {
    const uniqueSuffix = `${Date.now()}-${Math.round(Math.random() * 1E9)}`;
    cb(null, `${req.user.id}-${uniqueSuffix}${path.extname(file.originalname)}`);
  }
});

const fileFilter = (req, file, cb) => {
  if (file.mimetype.startsWith('image/')) {
    cb(null, true);
  } else {
    cb(new Error('Sadece resim dosyaları yüklenebilir!'), false);
  }
};

const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: {
    fileSize: 5 * 1024 * 1024 
  }
});


router.post('/upload-photo', protect, upload.single('photo'), async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ error: 'Lütfen bir resim dosyası seçin!' });
    }

    const imageUrl = `/uploads/profiles/${req.file.filename}`;


    const user = await User.findById(req.user.id);
    if (user.profileImageUrl) {
      const oldPath = path.join(__dirname, '..', user.profileImageUrl);
      if (fs.existsSync(oldPath)) {
        fs.unlinkSync(oldPath);
      }
    }


    await User.findByIdAndUpdate(req.user.id, { profileImageUrl: imageUrl });

    res.json({ 
      message: 'Profil fotoğrafı güncellendi!',
      imageUrl: imageUrl 
    });
  } catch (error) {
    console.error('Profil fotoğrafı yükleme hatası:', error);
    res.status(500).json({ error: 'Profil fotoğrafı yüklenemedi!' });
  }
});


router.get('/:userId', async (req, res) => {
  try {
    const userId = req.params.userId;
    const user = await User.findById(userId);

    if (!user) {
      return res.status(404).json({ error: 'Kullanıcı bulunamadı!' });
    }

    res.json({
      username: user.username,
      email: user.email,
      profileImageUrl: user.profileImageUrl ? `${req.protocol}://${req.get('host')}${user.profileImageUrl}` : null,
      userId: user._id
    });
  } catch (error) {
    res.status(500).json({ error: 'Profil bilgileri alınırken hata oluştu!' });
  }
});

module.exports = router;
