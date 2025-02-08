require('dotenv').config();
import { Router } from 'express';
const router = Router();
import User, { findOne, findById } from '../models/User';
import { sign } from 'jsonwebtoken';
import { protect } from '../middleware/auth'; 

const jwtSecret = process.env.JWT_SECRET;



router.post('/register', async (req, res) => {

  const { username, email, password } = req.body;

  try {
   
    const user = new User({ username, email, password });

    await user.save();
  
    const token = sign({ id: user._id }, jwtSecret, { expiresIn: '1h' });
    res.json({ token });
  } catch (error) {
    console.error('Kayıt hatası:', error);  
    res.status(400).json({ error: 'Kayıt başarısız!' });
  }
});


router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {

    const user = await findOne({ email });

    if (!user || !(await user.matchPassword(password))) {
      return res.status(400).json({ error: 'Geçersiz kimlik bilgileri!' });
    }

    const token = sign({ id: user._id }, jwtSecret, { expiresIn: '1h' });
    res.json({ token });
  } catch (error) {
    res.status(500).json({ error: 'Giriş başarısız!' });
  }
});


router.get('/me', protect, async (req, res) => {
  try {
    if (!req.user) {
      return res.status(401).json({ error: 'Yetkisiz erişim!' });
    }

    const user = await findById(req.user.id);

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
    console.error('Profil bilgileri hatası:', error);
    res.status(500).json({ error: 'Profil bilgileri alınırken hata oluştu!' });
  }
});



router.put('/update-player-id', protect, async (req, res) => {
  const { oneSignalPlayerId } = req.body;

  try {
    const user = await findById(req.user.id);
    user.oneSignalPlayerId = oneSignalPlayerId;
    await user.save();

    res.json({ message: 'OneSignal Player ID güncellendi!' });
  } catch (error) {
    res.status(500).json({ error: 'Player ID güncellenemedi!' });
  }
});

export default router;
