import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<UserCredential?> registerUser({
    required String email,
    required String password,
  }) async {
    var auth = FirebaseAuth.instance;
    emit(RegisterLoading());
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSucessed(userCredential: user));
      return user;
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

      return null;
    } on Exception catch (e) {
      emit(RegisterFailure(e.toString()));
      return null;
    }
  }
}
