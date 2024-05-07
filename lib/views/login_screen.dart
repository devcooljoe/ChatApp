import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:rent_paddy/controllers/login_controller.dart';
import 'package:rent_paddy/views/chat_screen.dart';
import 'package:rent_paddy/views/signup_screen.dart';
import 'package:rent_paddy/views/widgets.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController(text: 'joe@gmail.com');
    passwordController = TextEditingController(text: 'password');
  }

  @override
  void dispose() {
    super.dispose();
    formKey.currentState?.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(loginProvider, (prev, next) {
      if (next is LoginSuccessState) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ChatScreen(),
          ),
        );
      } else if (next is LoginErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Login Screen', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(height: 50),
              AppFormField(
                labelText: 'Email',
                controller: emailController,
                validator: ValidationBuilder().required().email().build(),
              ),
              const SizedBox(height: 20),
              AppFormField(
                labelText: 'Password',
                isPasswordField: true,
                controller: passwordController,
                validator: ValidationBuilder().required().build(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      ref.read(loginProvider.notifier).invoke(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          );
                    }
                  },
                  child: ref.watch(loginProvider) is LoginLoadingState ? const CircularProgressIndicator() : const Text('LOGIN'),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignupScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Not registered? Signup',
                  style: TextStyle(decoration: TextDecoration.underline, color: Colors.blue, decorationColor: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
