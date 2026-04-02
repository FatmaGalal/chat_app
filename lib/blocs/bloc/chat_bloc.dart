import 'dart:async';

import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final CollectionReference<Map<String, dynamic>> _messagesRef =
      FirebaseFirestore.instance.collection(kMessageCollection);
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
  _messagesSubscription;
  List<Message> messages = [];

  ChatBloc() : super(ChatInitial()) {
    on<ChatStarted>(_onChatStarted);
    on<MessagesReceived>(_onMessagesReceived);
    on<MessageSubmitted>(_onMessageSubmitted);
  }

  Future<void> _onChatStarted(
    ChatStarted event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatILoading());
    // add(MessagesReceived(messages: messages));
    _messagesSubscription ??= _messagesRef
        .orderBy(kCreatedAt)
        .snapshots()
        .listen((snapshot) {
          messages = snapshot.docs
              .map((doc) => Message.fromJson(doc.data()))
              .toList();
          add(MessagesReceived(messages: messages));
        });
  }

  void _onMessagesReceived(MessagesReceived event, Emitter<ChatState> emit) {
    emit(ChatLoaded(event.messages));
  }

  Future<void> _onMessageSubmitted(
    MessageSubmitted event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await _messagesRef.add({
        kMessage: event.message,
        kId: event.id,
        kCreatedAt: DateTime.now(),
      });
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }
}
