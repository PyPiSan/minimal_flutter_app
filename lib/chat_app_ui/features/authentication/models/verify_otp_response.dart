class VerifyOtpResponse {
  final bool isSuccess;
  final String message;

  VerifyOtpResponse({
    required this.isSuccess,
    required this.message,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      isSuccess: json['is_success'] as bool,
      message: json['message'] as String,
    );
  }
}
