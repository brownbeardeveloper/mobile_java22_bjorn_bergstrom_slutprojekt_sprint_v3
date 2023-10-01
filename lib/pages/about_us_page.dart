import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              // My profile picture
              radius: 100,
              backgroundImage: AssetImage('assets/images/hello.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Björn Bergström',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'PressStart2P',
                color: Color.fromARGB(255, 0, 56, 102),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Upcoming Java Developer',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'PressStart2P',
                color: Color.fromARGB(255, 66, 157, 227),
              ),
            ),
            const SizedBox(height: 20),
            FractionallySizedBox(
              widthFactor: 2.5 / 3, // 1/3 of the screen width
              child: Container(
                child: Text(
                  'I\'m a budding software developer with a passion for coding. Excited about Java and always eager to learn.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'PressStart2P',
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
