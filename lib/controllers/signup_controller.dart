import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_paddy/models/profile_model.dart';

abstract class SignupState {}

class SignupInitialState extends SignupState {}

class SignupLoadingState extends SignupState {}

class SignupSuccessState<T> extends SignupState {
  final T data;
  SignupSuccessState(this.data);
}

class SignupErrorState<String> extends SignupState {
  final String message;
  SignupErrorState(this.message);
}

class SignupNotifier extends StateNotifier<SignupState> {
  SignupNotifier() : super(SignupInitialState());

  Future invoke({required String name, required String email, required String password, String? picture}) async {
    state = SignupLoadingState();
    try {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final profile = ProfileModel(email: email, name: name, picture: picture);
      await FirebaseFirestore.instance.collection('profiles').doc(userCredential.user!.uid).set(profile.toMap());
      state = SignupSuccessState<ProfileModel>(profile);
    } catch (e) {
      log(e.toString());
      state = SignupErrorState(e.toString());
    }
  }
}

final signupProvider = StateNotifierProvider<SignupNotifier, SignupState>((ref) => SignupNotifier());
