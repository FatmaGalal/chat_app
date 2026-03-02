import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget{
  const ChatBubble({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    
   return Align(
    alignment: AlignmentGeometry.centerLeft,
     child: Container(
       padding: EdgeInsets.all(16),
       margin: EdgeInsets.all(6),
       decoration: BoxDecoration(
       borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
        bottomRight: Radius.circular(32),
      ),
      color: kPrimaryColor,
      ),
     child: Text(message.message, style: TextStyle(color: Colors.white),),
     ),
   );
  }
}


class ChatBubbleFriend extends StatelessWidget{
  const ChatBubbleFriend({super.key, required this.message});
  final Message message;

  @override
  Widget build(BuildContext context) {
    
   return Align(
    alignment: AlignmentGeometry.centerRight,
     child: Container(
       padding: EdgeInsets.all(16),
       margin: EdgeInsets.all(6),
       decoration: BoxDecoration(
       borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
        bottomLeft: Radius.circular(32),
      ),
      color: kPSecondryColor,
      ),
     child: Text(message.message, style: TextStyle(color: Colors.white),),
     ),
   );
  }
}