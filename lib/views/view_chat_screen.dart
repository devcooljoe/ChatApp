import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_paddy/views/widgets.dart';

class ViewChatScreen extends ConsumerStatefulWidget {
  const ViewChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ViewChatScreenState();
}

class _ViewChatScreenState extends ConsumerState<ViewChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Mr Funso', style: TextStyle(color: Colors.white)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text('Hello Joseph'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Hello Joseph',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Expanded(
                child: AppFormField(
                  hintText: 'Write a message...',
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send, color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
