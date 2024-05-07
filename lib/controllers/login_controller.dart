import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_paddy/controllers/profile_controller.dart';

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
  LoginNotifier(this.ref) : super(LoginInitialState());

  final Ref ref;

  Future invoke({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      ref.read(profileProvider.notifier).get().then((_) {
        emit(LoginSuccessState<User>(userCredential.user!));
      });
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      //
    }
  }

  emit(LoginState value) {
    state = value;
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) => LoginNotifier(ref));
