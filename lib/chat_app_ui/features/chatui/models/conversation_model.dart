enum Sender { user, ai }

class CoversationModel {
  final String text;
  final Sender sender;
  final Map<String, dynamic>? chartData;

  CoversationModel({required this.text, required this.sender, this.chartData});
}
