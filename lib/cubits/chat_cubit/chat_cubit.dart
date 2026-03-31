import 'dart:async';

import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  final CollectionReference<Map<String, dynamic>> _messagesRef =
      FirebaseFirestore.instance.collection(kMessageCollection);
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>?
  _messagesSubscription;
  List<Message> messages = [];

  List<Message> getChatMessages() {
    _messagesSubscription ??= _messagesRef
        .orderBy(kCreatedAt)
        .snapshots()
        .listen(
          (snapshot) {
            messages = snapshot.docs
                .map((doc) => Message.fromJson(doc.data()))
                .toList();
            emit(ChatLoaded());
          },
          onError: (error) {
            emit(ChatFailure(error));
          },
        );

    return messages;
  }

  Future<void> sendMessage({
    required String message,
    required String id,
  }) async {
    await _messagesRef.add({
      kMessage: message,
      kId: id,
      kCreatedAt: DateTime.now(),
    });
  }
}
