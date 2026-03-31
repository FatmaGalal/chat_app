import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    var auth = FirebaseAuth.instance;
    emit(LoginLoading());
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess(user));
      return user;
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

      return null;
    } on Exception catch (e) {
      emit(LoginFailure(e.toString()));
      return null;
    }
  }
}
