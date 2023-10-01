import 'dart:async';
import 'package:firebasev1/components/barrier.dart';
import 'package:firebasev1/components/bird.dart';
import 'package:firebasev1/services/highscore/highscore_service.dart';
import 'package:flutter/material.dart';

class FlappyBirdGame extends StatefulWidget {
  @override
  State<FlappyBirdGame> createState() => _HomePageState();
}

class _HomePageState extends State<FlappyBirdGame> {
  static double birdY = 0;

  // bird variables
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -1; // strenght of the gravity
  double velocity = 1; // strength of the jump
  double birdWidth = 0.1;
  double birdHeight = 0.1;

  // game settings
  bool gameHasStarted = false;
  int userScore = 0;

  // barrier variables
  static List<double> barrierX = [
    2,
    2 + 2,
    2 + 4,
    2 + 6,
  ]; // Add more barrier positions as needed
  static double barrierWidth = 0.5;
  List<List<double>> barrierHeight = [
    // top height & bottom height
    [0.6, 0.4],
    [0.4, 0.6]
  ];

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      height = gravity * time * time + velocity * time;

      setState(() {
        birdY = initialPos - height;
      });

      if (birdIsDead()) {
        timer.cancel();
        _showDialog();

        if (userScore != 0) {
          // Add highscore
          HighScoreService highScoreService = HighScoreService();
          highScoreService.sendNewUserScore(userScore);
        }
      }

      moveMap();

      // keep the time going
      time += 0.1;
    });
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'G A M E  O V E R',
          ),
          content: Text(
            'Your Score: $userScore',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            GestureDetector(
              onTap: resetGame,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  child: const Text('PLAY AGAIN'),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  void resetGame() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      initialPos = birdY;
      userScore = 0;
    });
    resetBarriers();
  }

  void resetBarriers() {
    setState(() {
      barrierX = [
        2,
        2 + 5,
        2 + 10,
        2 + 15,
        2 + 20,
        2 + 25,
      ];
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  bool birdIsDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }

    for (int i = 0; i < barrierX.length; i++) {
      if (i < barrierHeight.length &&
          barrierX[i] <= birdWidth &&
          barrierX[i] + barrierWidth >= -birdWidth &&
          (birdY <= -1 + barrierHeight[i][0] ||
              birdY + birdHeight >= 1 - barrierHeight[i][1])) {
        return true;
      }
    }

    return false;
  }

  void moveMap() {
    for (int i = 0; i < barrierX.length; i++) {
      // keep barriers moving
      setState(() {
        barrierX[i] -= 0.025;
      });

      // if barrier exists the left part of the screen, keep it looping
      if (barrierX[i] < -1.5) {
        barrierX[i] += 3;
        // Increase score when bird passes the barrier
        userScore++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Stack(children: [
                    MyBird(
                      birdY: birdY,
                      birdWidth: birdWidth,
                      birdHeight: birdHeight,
                    ),
                    Container(
                      alignment: const Alignment(0, -0.5),
                      child: Text(gameHasStarted ? "" : "T A P   T O   P L A Y",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                    ),
                    // Top barrier 0
                    MyBarrier(
                      barrierX: barrierX[0],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[0][0],
                      isThisBottomBarrier: false,
                    ),
                    // Bottom barrier 0
                    MyBarrier(
                      barrierX: barrierX[0],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[0][1],
                      isThisBottomBarrier: true,
                    ), // Top barrier 1
                    MyBarrier(
                      barrierX: barrierX[1],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[1][0],
                      isThisBottomBarrier: false,
                    ), // Bottom barrier 1
                    MyBarrier(
                      barrierX: barrierX[1],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[1][1],
                      isThisBottomBarrier: true,
                    ), // Top barrier 2
                    MyBarrier(
                      barrierX: barrierX[2],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[1][0],
                      isThisBottomBarrier: false,
                    ), // Bottom barrier 2
                    MyBarrier(
                      barrierX: barrierX[2],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[1][1],
                      isThisBottomBarrier: true,
                    ), // Top barrier 3
                    MyBarrier(
                      barrierX: barrierX[3],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[0][0],
                      isThisBottomBarrier: false,
                    ), // Bottom barrier 3
                    MyBarrier(
                      barrierX: barrierX[3],
                      barrierWidth: barrierWidth,
                      barrierHeight: barrierHeight[0][1],
                      isThisBottomBarrier: true,
                    )
                  ]),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
