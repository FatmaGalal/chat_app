import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) async {
      var auth = FirebaseAuth.instance;
      if (event is RegisterSubmittedEvent) {
        emit(RegisterLoading());
        try {
          UserCredential user = await auth.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(RegisterSucessed(userCredential: user));
        } on FirebaseAuthException catch (e) {
          if (e.code == 'user-not-found') {
            emit(RegisterFailure('User not found!'));
          } else if (e.code == 'invalid-credential') {
            emit(RegisterFailure('Invalid credential'));
          } else if (e.code == 'rejected-credential') {
            emit(RegisterFailure('rejected credential!'));
          } else {
            emit(RegisterFailure('Auth Error!'));
          }
        } on Exception catch (e) {
          emit(RegisterFailure(e.toString()));
        }
      }
    });
  }
}
