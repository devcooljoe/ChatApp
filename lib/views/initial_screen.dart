import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_paddy/controllers/profile_controller.dart';
import 'package:rent_paddy/views/chat_screen.dart';
import 'package:rent_paddy/views/login_screen.dart';
import 'package:rent_paddy/views/signup_screen.dart';

class InitialScreen extends ConsumerStatefulWidget {
  const InitialScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InitialScreenState();
}

class _InitialScreenState extends ConsumerState<InitialScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(profileProvider.notifier).get();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(profileProvider, (prevState, nextState) {
      log("State: $nextState");
      if (nextState is ProfileSuccessState) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const ChatScreen(),
          ),
        );
      } else if (nextState is UserNotLoggedInState) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      } else if (nextState is ProfileErrorState) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignupScreen(),
          ),
        );
      }
    });
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
