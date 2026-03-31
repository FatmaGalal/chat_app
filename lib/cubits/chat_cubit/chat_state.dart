part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class ChatLoaded extends ChatState {}

final class ChatFailure extends ChatState {
  final String errorMessage;

  ChatFailure(this.errorMessage);
}
