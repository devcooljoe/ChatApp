import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_paddy/models/profile_model.dart';

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState<T> extends LoginState {
  final T data;
  LoginSuccessState(this.data);
}

class LoginErrorState<String> extends LoginState {
  final String message;
  LoginErrorState(this.message);
}

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier() : super(LoginInitialState());

  Future invoke({required String email, required String password}) async {
    state = LoginLoadingState();
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      final docSnapshot = await FirebaseFirestore.instance.collection('profiles').doc(userCredential.user!.uid).get();
      if (docSnapshot.exists) {
        final profile = ProfileModel.fromMap(docSnapshot.data()!);

        state = LoginSuccessState<ProfileModel>(profile);
      } else {
        log('User not found in profile');
        state = LoginErrorState('User not found in profile');
      }
    } catch (e) {
      log(e.toString());
      state = LoginErrorState(e.toString());
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) => LoginNotifier());
