import 'package:firebasev1/components/ps2p_detector_btn.dart';
import 'package:firebasev1/components/ps2p_textfields.dart';
import 'package:firebasev1/pages/about_us_page.dart';
import 'package:firebasev1/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign in user
  void signIn() async {
    // get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
          emailController.text, passwordController.text);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            error.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10),
                  // header & logo
                  const Text(
                    "FLAPPY BIRD 2.0 ",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'PressStart2P',
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // username textfield
                  MyTextField(
                      controller: emailController,
                      hintText: 'email',
                      obscureText: false),
                  // password textfield
                  MyTextField(
                      controller: passwordController,
                      hintText: 'password',
                      obscureText: true),
                  // sign-in button
                  DectorButton(
                      onTap: () {
                        signIn();
                      },
                      text: 'Login'),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Ready to Explore? Register Here!',
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
