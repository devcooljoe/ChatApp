import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_paddy/models/profile_model.dart';

abstract class ProfileState {}

class ProfileInitialState extends ProfileState {}

class ProfileLoadingState extends ProfileState {}

class ProfileSuccessState<T> extends ProfileState {
  final T data;
  ProfileSuccessState(this.data);
}

class ProfileErrorState extends ProfileState {
  final String message;
  ProfileErrorState(this.message) {
    log(message);
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(ProfileInitialState());

  Future get() async {
    emit(ProfileLoadingState());
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final docSnapshot = await FirebaseFirestore.instance.collection('profiles').doc(user.uid).get();
        if (docSnapshot.exists) {
          final profile = ProfileModel.fromMap(docSnapshot.data()!);
          emit(ProfileSuccessState<ProfileModel>(profile));
        } else {
          emit(ProfileErrorState('User not found in profile'));
        }
      }
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  emit(ProfileState value) {
    state = value;
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) => ProfileNotifier());
