require('dotenv').config();

const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const path = require('path');


const authRoutes = require('./routes/auth').default;
const postRoutes = require('./routes/posts');
const profileRoutes = require('./routes/profile');
const searchRoutes = require('./routes/search');
const friendRoutes = require('./routes/friend');

const app = express();



app.use(cors());

app.use(express.json());

app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

const mongoUri = process.env.MONGO_URI;


mongoose.connect(mongoUri, { useNewUrlParser: true, useUnifiedTopology: true }) 
 .then(() => console.log('MongoDB bağlantısı başarılı'))
 .catch(err => console.error('MongoDB bağlantı hatası:', err));


app.use('/api/auth', authRoutes);
app.use('/api/posts', postRoutes);
app.use('/api/profile', profileRoutes);
app.use('/api/search', searchRoutes);
app.use('/api/friend', friendRoutes);


const port = process.env.PORT || 5000; 
app.listen(port, () => {
  console.log('Server aktif');
});
