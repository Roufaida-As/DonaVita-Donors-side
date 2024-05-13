import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/pages/chat%20work/message_model.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<MessageBubble> messages = const [
      MessageBubble(
        message: 'Hello there!',
        sender: 'Organisation',
        timestamp: '10:00 AM',
        isMe: false,
      ),
      MessageBubble(
        message: 'Hi ! is there any problems with my donation?',
        sender: 'Donor',
        timestamp: '10:05 AM',
        isMe: true,
      ),
      MessageBubble(
        message: 'we need your exact location and the time you want to meet !',
        sender: 'Organisation',
        timestamp: '10:06 AM',
        isMe: false,
      ),
      MessageBubble(
        message: 'at 11:00 AM if it\'possible ?',
        sender: 'Donor',
        timestamp: '10:07 AM',
        isMe: true,
      ),
      MessageBubble(
        message: 'Perfect ! See you there .',
        sender: 'Organisation',
        timestamp: '10:10 AM',
        isMe: false,
      ),
      // Add more messages as needed
    ];

    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: BackButton(
            color: AppColors.highicons,
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 2.0),
          child: Row(
            children: [
              CircleAvatar(
                // Display receiver's image in the app bar
                backgroundImage: AssetImage("assets/Icons/Ellipse 8.png"),
              ),
              Text(
                "  El-Baraka",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.highicons,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.05),
                    child: MessageBubble(
                      message: messages[index].message,
                      sender: messages[index].sender,
                      timestamp: messages[index].timestamp,
                      isMe: messages[index].isMe,
                    ),
                  );
                },
              ),
            ),
            _buildMessageInputField(),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInputField() {
    return Container(
      //decoration: const BoxDecoration(color: AppColors.clear),
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.emoji_emotions,
              color: AppColors.icons,
            ), // Sticker icon
            onPressed: () {
              // Add functionality for sticker selection
            },
          ),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Enter your message...',
                iconColor: AppColors.clear,
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: AppColors.icons,
            ),
            onPressed: () {
              // Send message functionality
            },
          ),
        ],
      ),
    );
  }
}
