import 'package:flutter/material.dart';
import 'package:rent_paddy/views/widgets.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Chats', style: TextStyle(color: Colors.white)),
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
