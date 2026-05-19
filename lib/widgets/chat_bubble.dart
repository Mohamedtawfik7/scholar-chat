import 'package:flutter/material.dart';
import 'package:scholar_chat2/constant.dart';
import 'package:scholar_chat2/models/message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.message});
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        padding: EdgeInsets.only(left: 30, top: 25, bottom: 25, right: 30),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Text(
          message.message,

          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ),
    );
  }
}

class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight, // ⬅️ يمين شمال
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: EdgeInsets.only(left: 30, top: 25, bottom: 25, right: 30),
        decoration: BoxDecoration(
          color: Colors.grey[300], // ⬅️ لون مختلف
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25), // ⬅️ معكوس
          ),
        ),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
    );
  }
}
