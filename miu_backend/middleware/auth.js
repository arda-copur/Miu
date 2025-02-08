
const jwt = require('jsonwebtoken');

const User = require('../models/User');



const rateLimit = {};

const protect = async (req, res, next) => {

  const ip = req.ip;
  const now = Date.now();

  if (rateLimit[ip]) {
    const timePassed = now - rateLimit[ip].timestamp;
    if (timePassed < 1000) { 
      rateLimit[ip].count++;
      if (rateLimit[ip].count > 10) { 
        return res.status(429).json({ 
          error: 'Çok fazla istek gönderdiniz. Lütfen bekleyin.' 
        });
      }
    } else {
      rateLimit[ip] = { timestamp: now, count: 1 };
    }
  } else {
    rateLimit[ip] = { timestamp: now, count: 1 };
  }
  let token;


  if (req.headers.authorization && req.headers.authorization.startsWith('Bearer')) {
    try {

      token = req.headers.authorization.split(' ')[1];

      const decoded = jwt.verify(token, 'secretkey');

 
        const tokenExp = new Date(decoded.exp * 1000);
        const now = new Date();
        const timeUntilExpiration = tokenExp - now;
    
      if (timeUntilExpiration < 3600000) {
    
        const newToken = jwt.sign(
          { id: decoded.id },
          'secretkey',
          { expiresIn: '24h' }
        );
     
        res.setHeader('New-Token', newToken);
      }

      if (!decoded.id) {
        console.log("JWT'den kullanıcı kimliği alınamadı.");
        return res.status(401).json({ error: 'Yetkisiz erişim!' });
      }


      req.user = await User.findById(decoded.id).select('-password');

      if (!req.user) {
        console.log("Kullanıcı bulunamadı.");
        return res.status(404).json({ error: 'Kullanıcı bulunamadı!' });
      }

  
      next();

    } catch (error) {
      console.error("JWT doğrulama hatası:", error);
      return res.status(401).json({ error: 'Yetkisiz erişim!' });
    }
  } else {

    console.log("Token bulunamadı.");
    return res.status(401).json({ error: 'Yetkisiz, token yok!' });
  }
};


module.exports = { protect };


