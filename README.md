Miu - Social Media Platform
Miu is a modern and feature-rich social media platform developed with Flutter for the frontend, Node.js for the backend, and MongoDB as the database. It offers a clean, modular codebase, responsive design, and user-centric features to provide an engaging social media experience.

✨ Features
User Authentication: Secure user registration and login system.

Profile Management: Users can create, update, and manage their profiles, including profile pictures.

Post Interactions: Users can create posts, like posts, comment on them, and share them.

Friendship System: Send, accept, or reject friend requests.

Search and Filtering: Advanced search and filtering options to find users or content.

Image Handling: Image upload and management using Multer.

Real-time Notifications: Push notifications between users using One Signal.

Rate Limiting: Prevent excessive requests to ensure server stability.

Security: Enhanced security with Bcryptjs for password hashing and JSON Web Tokens (JWT) for secure authentication.

Environment Management: Use of dotenv for managing environment variables.

🛠 Technologies Used
Backend (Node.js)
bcryptjs

cors

dotenv

express

firebase-admin

fs

jsonwebtoken

mongoose

multer

onesignal-node

path

Frontend (Flutter)
http

http_parser

shared_preferences

image_picker

provider

flutter_dotenv

onesignal_flutter

permission_handler

connectivity_plus

🚀 Getting Started
Prerequisites
Node.js and npm installed on your machine.

Flutter SDK installed on your machine.

MongoDB database set up and running.

Installation
1. Clone the Repository
bash
Copy
git clone https://github.com/yourusername/miu.git
cd miu
2. Backend Setup
Navigate to the backend directory:

bash
Copy
cd backend
Install dependencies:

bash
Copy
npm install
Create a .env file in the backend directory and add your environment variables:

env
Copy
MONGO_URI=your_mongodb_connection_string
JWT_SECRET=your_jwt_secret_key
ONESIGNAL_APP_ID=your_onesignal_app_id
ONESIGNAL_API_KEY=your_onesignal_api_key
Start the server:

bash
Copy
npm start
3. Frontend Setup
Navigate to the frontend directory:

bash
Copy
cd ../frontend
Install dependencies:

bash
Copy
flutter pub get
Create a .env file in the frontend directory and add your environment variables:

env
Copy
BASE_URL=your_backend_api_url
AUTH_API=your_auth_api_endpoint
REGISTER_ENDPOINT=your_register_endpoint
LOGIN_ENDPOINT=your_login_endpoint
ONE_SIGNAL_ENDPOINT=your_onesignal_endpoint
POST_API=your_post_api_endpoint
LIKE_ENDPOINT=your_like_endpoint
COMMENT_ENDPOINT=your_comment_endpoint
RETWEET_ENDPOINT=your_retweet_endpoint
PROFILE_API=your_profile_api_endpoint
ME_ENDPOINT=your_me_endpoint
USER_POSTS_ENDPOINT=your_user_posts_endpoint
FEED_ENDPOINT=your_feed_endpoint
FRIEND_API=your_friend_api_endpoint
REQUEST_ENDPOINT=your_request_endpoint
ACCEPT_ENDPOINT=your_accept_endpoint
REJECT_ENDPOINT=your_reject_endpoint
REQUESTS_ENDPOINT=your_requests_endpoint
STATUS_ENDPOINT=your_status_endpoint
FRIENDS_ENDPOINT=your_friends_endpoint
USER_ENDPOINT=your_user_endpoint
LIST_ENDPOINT=your_list_endpoint
BASE_IMAGE_URL=your_base_image_url
UPLOAD_PHOTO_ENDPOINT=your_upload_photo_endpoint
Run the app:

bash
Copy
flutter run
🤝 Contributing
Contributions are welcome! Please follow these steps:

Fork the repository.

Create a new branch (git checkout -b feature/YourFeatureName).

Commit your changes (git commit -m 'Add some feature').

Push to the branch (git push origin feature/YourFeatureName).

Open a pull request.

🙏 Acknowledgments
Special thanks to the Flutter and Node.js communities for their extensive documentation and support.

Inspiration from popular social media platforms for feature ideas.
