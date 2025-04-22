import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';

class MessageActionBar extends StatelessWidget {
  final String messageText;
  final void Function()? onThumbsUp;
  final void Function()? onThumbsDown;

  const MessageActionBar({
    super.key,
    required this.messageText,
    this.onThumbsUp,
    this.onThumbsDown,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4, left: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Iconsax.copy, size: 20),
            tooltip: 'Copy',
            onPressed: () {
              Clipboard.setData(ClipboardData(text: messageText));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Copied to clipboard'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Iconsax.like_1, size: 20),
            tooltip: 'Helpful',
            onPressed: onThumbsUp,
          ),
          IconButton(
            icon: const Icon(Iconsax.dislike, size: 20),
            tooltip: 'Not helpful',
            onPressed: onThumbsDown,
          ),
        ],
      ),
    );
  }
}
