import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState<T> extends LoginState {
  final T data;
  LoginSuccessState(this.data);
}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState(this.message) {
    log(message);
  }
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginInitialState());

  Future invoke({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccessState<User>(userCredential.user!));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  emit(LoginState value) {
    state = value;
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) => LoginNotifier());
