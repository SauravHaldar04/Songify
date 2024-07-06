import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/repositories/auth_remote_repository.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view/widgets/auth_custom_textfield.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In.',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomField(hintText: 'Email', controller: emailController),
              const SizedBox(
                height: 15,
              ),
              CustomField(
                hintText: 'Password',
                controller: passwordController,
                isObscure: true,
              ),
              const SizedBox(
                height: 15,
              ),
              AuthGradientButtonn(
                buttonText: 'Sign In',
                onPressed: () async {
                  final res = await AuthRemoteRepository().login(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                  final val = switch (res) {
                    Left(value: final l) => l.toString(),
                    Right(value: final r) => r.toString(),
                  };
                  print(val);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const SignUpPage(),
                    ),
                  );
                },
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                              color: Pallete.gradient2,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
