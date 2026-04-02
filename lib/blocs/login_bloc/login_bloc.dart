import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      var auth = FirebaseAuth.instance;
      if (event is LoginSubmittedEvent) {
        emit(LoginLoading());

        try {
          UserCredential user = await auth.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(LoginSuccess(user));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(LoginFailure('User not found!'));
          } else if (e.code == 'invalid-credential') {
            emit(LoginFailure('Invalid credential'));
          } else if (e.code == 'rejected-credential') {
            emit(LoginFailure('rejected credential!'));
          } else {
            emit(LoginFailure('Auth Error!'));
          }
        } on Exception catch (e) {
          emit(LoginFailure(e.toString()));
        }
      }
    });
  }
}
