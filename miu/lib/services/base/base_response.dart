class BaseResponse<T> {
  final T? data;
  final String? error;
  final String? message;

  BaseResponse({this.data, this.error, this.message});

  bool get isSuccess => error == null;
}
