class ChatResponseModel {
  final String response;
  final String followUps;
  ChatResponseModel({
    required this.response,
    required this.followUps,
  });
  factory ChatResponseModel.fromJson(Map<String, dynamic> json) {
    return ChatResponseModel(
      response: json['response'] as String,
      followUps: json['follow_ups'] as String,
    );
  }
}
