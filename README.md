# 🚀 Miu - Social Media Platform  

Miu is a modern and feature-rich **social media platform** built with **Flutter** for the frontend, **Node.js** for the backend, and **MongoDB** as the database. It provides a **clean, modular codebase**, a **responsive design**, and **user-centric features** for an engaging social media experience.  

---

## ✨ Features  

✅ **User Authentication** – Secure registration and login system.  
✅ **Profile Management** – Users can create, update, and manage their profiles, including profile pictures.  
✅ **Post Interactions** – Users can create posts, like, comment, and share them.  
✅ **Friendship System** – Send, accept, or reject friend requests.  
✅ **Search & Filtering** – Find users and content with advanced search options.  
✅ **Image Handling** – Image upload and management using Multer.  
✅ **Real-time Notifications** – Push notifications via OneSignal.  
✅ **Rate Limiting** – Prevent excessive requests for server stability.  
✅ **Security** – Bcrypt.js for password hashing & JWT for authentication.  
✅ **Environment Management** – dotenv for secure environment variable handling.  

---

## 🛠 Tech Stack  

### **Backend (Node.js)**  
- `bcryptjs` – Password hashing  
- `cors` – Cross-origin resource sharing  
- `dotenv` – Environment variable management  
- `express` – Web framework  
- `firebase-admin` – Firebase services integration  
- `fs` – File system handling  
- `jsonwebtoken` – Secure authentication with JWT  
- `mongoose` – MongoDB object modeling  
- `multer` – Image upload handling  
- `onesignal-node` – Push notifications  
- `path` – File path utilities  

### **Frontend (Flutter)**  
- `http` – API communication  
- `http_parser` – HTTP protocol handling  
- `shared_preferences` – Local storage  
- `image_picker` – Image selection & upload  
- `provider` – State management  
- `flutter_dotenv` – Environment variables in Flutter  
- `onesignal_flutter` – Push notifications integration  
- `permission_handler` – Permission requests  
- `connectivity_plus` – Network connectivity handling  

---

## 🚀 Getting Started  

Before running the project, make sure you have the following installed on your machine:  

- **Node.js** and **npm**  
- **Flutter SDK**  
- **MongoDB** (set up and running)  

### **Installation**  

```bash
# Clone the repository
git clone https://github.com/yourusername/miu.git
cd miu

# Backend Setup
cd backend
npm install

# Create .env file and add environment variables
echo "MONGO_URI=your_mongodb_connection_string" >> .env
echo "JWT_SECRET=your_jwt_secret_key" >> .env
echo "ONESIGNAL_APP_ID=your_onesignal_app_id" >> .env
echo "ONESIGNAL_API_KEY=your_onesignal_api_key" >> .env

# Start the backend server
npm start

# Frontend Setup
cd ../frontend
flutter pub get

# Create .env file and add environment variables
echo "BASE_URL=your_backend_api_url" >> .env
echo "AUTH_API=auth_api_endpoint" >> .env
echo "REGISTER_ENDPOINT=your_register_endpoint" >> .env
echo "LOGIN_ENDPOINT=login_endpoint" >> .env
echo "ONE_SIGNAL_ENDPOINT=your_onesignal_endpoint" >> .env
echo "POST_API=post_api_endpoint" >> .env
echo "LIKE_ENDPOINT=your_like_endpoint" >> .env
echo "COMMENT_ENDPOINT=comment_endpoint" >> .env
echo "RETWEET_ENDPOINT=your_retweet_endpoint" >> .env
echo "PROFILE_API=profile_api_endpoint" >> .env
echo "ME_ENDPOINT=your_me_endpoint" >> .env
echo "USER_POSTS_ENDPOINT=user_posts_endpoint" >> .env
echo "FEED_ENDPOINT=your_feed_endpoint" >> .env
echo "FRIEND_API=friend_api_endpoint" >> .env
echo "REQUEST_ENDPOINT=your_request_endpoint" >> .env
echo "ACCEPT_ENDPOINT=accept_endpoint" >> .env
echo "REJECT_ENDPOINT=reject_endpoint" >> .env
echo "REQUESTS_ENDPOINT=requests_endpoint" >> .env
echo "STATUS_ENDPOINT=status_endpoint" >> .env
echo "FRIENDS_ENDPOINT=friends_endpoint" >> .env
echo "USER_ENDPOINT=user_endpoint" >> .env
echo "LIST_ENDPOINT=list_endpoint" >> .env
echo "BASE_IMAGE_URL=base_image_url" >> .env
echo "UPLOAD_PHOTO_ENDPOINT=upload_photo_endpoint" >> .env

# Run the Flutter app
flutter run


## 🙏 And last but not least  

🎉 Special thanks to the Flutter and Node.js communities for their extensive documentation and support.
💡 Inspired by popular social media platforms for feature ideas.
⭐ If you like this project, give it a star!
📩 Have questions? Open an issue or reach out!

