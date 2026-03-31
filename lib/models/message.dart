import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/constants.dart';

class Message {
  final String message;
  final String id;
  final DateTime createdAt;
  Message({required this.message, required this.id, required this.createdAt});

  // factory Message.fromJson(JsonData)
  // {
  //   return Message(message: JsonData[kMessage], id: JsonData[kId]);
  // }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json[kMessage] as String,
      id: json[kId] as String,
      createdAt: (json[kCreatedAt] as Timestamp).toDate(),
    );
  }
}
