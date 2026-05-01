// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class ApiResponse<T> {}

class ApiSuccess<T> extends ApiResponse<T> {
  // Map<String, dynamic> data; //{"userId":1}
  // Map<String, dynamic>? jsonData; //UserModel.fromJson(data)
  // Object? data; //UserModel.fromJson(data)
  final T data;
  ApiSuccess({
    required this.data /* ,required Map<String, dynamic> jsonData */,
  });
}

class ApiFailure<T> extends ApiResponse<T> {
  final String message;
  final int? statusCode;
  ApiFailure({required this.message, required this.statusCode});
}
