import 'package:flutter/material.dart';
import 'package:projectfinal/Theme/colors.dart';
import 'package:projectfinal/pages/chat%20work/chat_room.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 30,
              fontFamily: 'Nunito',
              color: AppColors.highicons,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: 4, // Replace with actual number of users
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: _buildUserCard(context, index),
          );
        },
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: AppColors.clear,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          leading: CircleAvatar(
            // You can set user's profile image here
            child: Image.asset("assets/Icons/Ellipse 8.png"),
          ),
          title: Text(
            'Organisation $index',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: AppColors.icons),
          ),
          subtitle: Text(
            'Last message from organisation $index',
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
          onTap: () {
            // Navigate to chat screen when user is tapped
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ChatRoom()),
            );
          },
        ),
      ),
    );
  }
}
