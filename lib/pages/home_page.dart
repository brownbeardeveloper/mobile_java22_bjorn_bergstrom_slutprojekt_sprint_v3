import 'package:firebasev1/components/highscore_board.dart';
import 'package:firebasev1/components/ps2p_elevated_btn.dart';
import 'package:firebasev1/pages/chat_page.dart';
import 'package:firebasev1/pages/flappy_bird_game.dart';
import 'package:firebasev1/services/auth/auth_service.dart';
import 'package:firebasev1/services/auth/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
Ha fungerande backstack ( webbläsarens default back button ska funka )
*/

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginOrRegister()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "FLAPPY BIRD",
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'PressStart2P',
                    color: Colors.green),
              ),
            ),
            const Expanded(
              child: HighscoreBoard(),
            ),
            Row(
              children: [
                MyButton(
                  onPressed: signOut,
                  text: 'Signout',
                ),
                MyButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FlappyBirdGame(),
                      ),
                    );
                  },
                  text: 'Play',
                ),
                MyButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ChatPage(),
                      ),
                    );
                  },
                  text: 'Chat',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
