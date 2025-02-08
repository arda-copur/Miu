import 'package:flutter_dotenv/flutter_dotenv.dart';

class Config {
  String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  String get authApi => dotenv.env['AUTH_API'] ?? '';
  String get registerEndpoint => dotenv.env['REGISTER_ENDPOINT'] ?? '';
  String get loginEndpoint => dotenv.env['LOGIN_ENDPOINT'] ?? '';
  String get oneSignalEndpoint => dotenv.env['ONE_SIGNAL_ENDPOINT'] ?? '';
  String get postsApi => dotenv.env['POST_API'] ?? '';
  String get likeEndpoint => dotenv.env['LIKE_ENDPOINT'] ?? '';
  String get commentEndpoint => dotenv.env['COMMENT_ENDPOINT'] ?? '';
  String get retweetEndpoint => dotenv.env['RETWEET_ENDPOINT'] ?? '';
  String get profileApi => dotenv.env['PROFILE_API'] ?? '';
  String get meEndpoint => dotenv.env['ME_ENDPOINT'] ?? '';
  String get userPostsEndpoint => dotenv.env['USER_POSTS_ENDPOINT'] ?? '';
  String get feedEndpoint => dotenv.env['FEED_ENDPOINT'] ?? '';
  String get friendApi => dotenv.env['FRIEND_API'] ?? '';
  String get requestEndpoint => dotenv.env['REQUEST_ENDPOINT'] ?? '';
  String get acceptEndpoint => dotenv.env['ACCEPT_ENDPOINT'] ?? '';
  String get rejectEndpoint => dotenv.env['REJECT_ENDPOINT'] ?? '';
  String get requestsEndpoint => dotenv.env['REQUESTS_ENDPOINT'] ?? '';
  String get statusEndpoint => dotenv.env['STATUS_ENDPOINT'] ?? '';
  String get friendsEndpoint => dotenv.env['FRIENDS_ENDPOINT'] ?? '';
  String get userEndpoint => dotenv.env['USER_ENDPOINT'] ?? '';
  String get listEndpoint => dotenv.env['LIST_ENDPOINT'] ?? '';
  String get baseImageUrl => dotenv.env['BASE_IMAGE_URL'] ?? '';
  String get uploadPhotoEndpoint => dotenv.env['UPLOAD_PHOTO_ENDPOINT'] ?? '';
}
