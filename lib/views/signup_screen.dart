import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validator/form_validator.dart';
import 'package:rent_paddy/controllers/signup_controller.dart';
import 'package:rent_paddy/views/login_screen.dart';
import 'package:rent_paddy/views/widgets.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    formKey.currentState?.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(signupProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Signup Screen', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              const SizedBox(height: 50),
              AppFormField(
                labelText: 'Name',
                controller: nameController,
                validator: ValidationBuilder().required().build(),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      ref
                          .read(signupProvider.notifier)
                          .invoke(
                            name: nameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          )
                          .then((value) {
                        if (data is SignupSuccessState) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        } else if (data is SignupErrorState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text((data).message),
                            ),
                          );
                        }
                      });
                    }
                  },
                  child: data is SignupLoadingState ? const CircularProgressIndicator() : const Text('SIGNUP'),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text(
                  'Already registered? Login',
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
