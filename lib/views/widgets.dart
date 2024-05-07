import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rent_paddy/views/view_chat_screen.dart';

class AppFormField extends ConsumerStatefulWidget {
  final String? labelText;
  final bool isPasswordField;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  const AppFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.isPasswordField = false,
    this.controller,
    this.validator,
  });

  @override
  ConsumerState<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends ConsumerState<AppFormField> {
  final isObscured = StateProvider<bool>((ref) => true);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.isPasswordField ? ref.watch(isObscured) : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        label: widget.labelText == null
            ? null
            : Text(
                widget.labelText!,
                style: const TextStyle(color: Colors.grey),
              ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        suffixIcon: widget.isPasswordField
            ? IconButton(
                onPressed: () {
                  ref.read(isObscured.notifier).state = !ref.watch(isObscured);
                },
                icon: Icon(ref.watch(isObscured) ? Icons.visibility_off : Icons.visibility, color: Colors.green),
              )
            : null,
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ViewChatScreen(),
          ),
        );
      },
      titleAlignment: ListTileTitleAlignment.top,
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset('assets/images/avatar.jpg', fit: BoxFit.cover),
      ),
      title: const Text('Mr Funso'),
      subtitle: const Text(
        'Hello Bayo, I asked Joe to pick the code from git.',
        style: TextStyle(color: Colors.grey),
      ),
      trailing: const Text(
        'Yesterday',
        style: TextStyle(color: Colors.green),
      ),
    );
  }
}
