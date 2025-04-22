enum Sender { user, ai }

class CoversationModel {
  final String text;
  final Sender sender;

  CoversationModel({required this.text, required this.sender});
}
