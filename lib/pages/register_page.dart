import 'package:firebasev1/components/ps2p_detector_btn.dart';
import 'package:firebasev1/components/ps2p_textfields.dart';
import 'package:firebasev1/pages/about_us_page.dart';
import 'package:firebasev1/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // create a new user
  void registerNewUser() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match!'),
        ),
      );
    }
    // get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailAndPassword(usernameController.text,
          emailController.text, passwordController.text);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SafeArea(
            child: Center(
              child: Column(
                children: <Widget>[
                  // title
                  const SizedBox(height: 10),
                  const Text(
                    "Register here",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'PressStart2P',
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // username textfield
                  MyTextField(
                      controller: usernameController,
                      hintText: 'username',
                      obscureText: false),
                  // email textfield
                  MyTextField(
                      controller: emailController,
                      hintText: 'email',
                      obscureText: false),

                  // password textfield
                  MyTextField(
                      controller: passwordController,
                      hintText: 'password',
                      obscureText: true),
                  // confirm password textfield
                  MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'confirm password',
                      obscureText: true),
                  // register this user button
                  DectorButton(
                      onTap: () {
                        registerNewUser();
                      },
                      text: 'Create Your Account'),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Been here before? Login instead!',
                      style: TextStyle(
                        fontFamily: 'PressStart2P',
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return const AboutUsPage();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      'About Us',
                      style: TextStyle(
                        fontFamily: 'PressStart2P',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
