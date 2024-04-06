import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/Colors.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String sender;
  final String timestamp;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.message,
    required this.sender,
    required this.timestamp,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isMe ? AppColors.icons : AppColors.clear,
            ),
          ),
          Material(
            borderRadius: BorderRadius.circular(12.0),
            elevation: 5.0,
            color: isMe ? AppColors.icons : AppColors.clear,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            timestamp,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
