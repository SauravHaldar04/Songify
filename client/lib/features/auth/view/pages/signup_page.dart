import 'package:client/core/theme/app_pallete.dart';
import 'package:client/features/auth/view/widgets/auth_custom_textfield.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
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
                'Sign Up.',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomField(hintText: 'Name', controller: nameController),
              const SizedBox(
                height: 15,
              ),
               CustomField(hintText: 'Email', controller: emailController),
              const SizedBox(
                height: 15,
              ),
               CustomField(hintText: 'Password', controller: passwordController,isObscure: true,),
              const SizedBox(
                height: 15,
              ),
               AuthGradientButtonn(
                buttonText: 'Sign Up',
                onPressed: (){},  
              ),
              const SizedBox(
                height: 15,
              ),
              RichText(
                text: TextSpan(
                    text: 'Already have an account? ',
                    style: Theme.of(context).textTheme.titleMedium,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(
                            color: Pallete.gradient2,
                            fontWeight: FontWeight.bold),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
