import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_paddy/controllers/login_controller.dart';
import 'package:rent_paddy/views/login_screen.dart';
import 'package:rent_paddy/views/new_chat_screen.dart';
import 'package:rent_paddy/views/widgets.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Chats', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NewChatScreen(),
                ),
              );
            },
            icon: const Icon(Icons.add, size: 34, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              ref.read(loginProvider.notifier).logout().then((value) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              });
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Column(
              children: [
                SizedBox(height: 20),
                ChatItem(),
              ],
            );
          }
          if (index == 9) {
            return const Column(
              children: [
                ChatItem(),
                SizedBox(height: 50),
              ],
            );
          } else {
            return const ChatItem();
          }
        },
      ),
    );
  }
}
