part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatILoading extends ChatState {}

final class ChatLoaded extends ChatState {
  final List<Message> messages;
  ChatLoaded(this.messages);
}

final class ChatFailure extends ChatState {
  final String errorMessage;

  ChatFailure(this.errorMessage);
}
