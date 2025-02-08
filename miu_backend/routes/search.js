// routes/search.js
const express = require('express');
const router = express.Router();
const User = require('../models/User');

// Kullanıcı arama
router.get('/:username', async (req, res) => {
  try {
    const users = await User.find({ username: { $regex: req.params.username, $options: 'i' } });
    res.json(users);
  } catch (error) {
    res.status(500).json({ error: 'Arama başarısız!' });
  }
});

module.exports = router;
