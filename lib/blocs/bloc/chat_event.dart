part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class ChatStarted extends ChatEvent {}

class MessagesReceived extends ChatEvent {
  final List<Message> messages;

  MessagesReceived({required this.messages});
}

class MessageSubmitted extends ChatEvent {
  final String message;
  final String id;

  MessageSubmitted({required this.message, required this.id});
}
