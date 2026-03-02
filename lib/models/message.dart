import 'package:chat_app/constants.dart';


class Message {

  final String message;
  final String id;

  Message( {required this.message,required this.id});

  factory Message.fromJson(JsonData)
  {
    return Message(message: JsonData[kMessage], id: JsonData[kId]);
  }
}
