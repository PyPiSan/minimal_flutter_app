class OtpResponse {
  final bool isUser;
  final bool isOtpSuccess;
  final String name;

  OtpResponse({
    required this.isUser,
    required this.isOtpSuccess,
    required this.name,
  });

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      isUser: json['is_user'] as bool,
      isOtpSuccess: json['is_otp_success'] as bool,
      name: json['name'] as String,
    );
  }
}
