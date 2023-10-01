import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasev1/services/highscore/highscore_service.dart';
import 'package:flutter/material.dart';

class HighscoreBoard extends StatefulWidget {
  const HighscoreBoard({Key? key}) : super(key: key);

  @override
  State<HighscoreBoard> createState() => _HighscoreBoardState();
}

class _HighscoreBoardState extends State<HighscoreBoard> {
  final HighScoreService _highScoreboardService = HighScoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Expanded(
              child: _buildScoreboardList(),
            ),
          ],
        ),
      ),
    );
  }

// build message list
  Widget _buildScoreboardList() {
    return StreamBuilder(
      stream: _highScoreboardService.fetchUserScores(),
      builder: (context, snapshot) {
        // if error
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        // if waiting
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text(
            'Loading',
            style: TextStyle(
              fontFamily: 'PressStart2P',
              color: Colors.green,
            ),
          );
        }
        // if there's no data
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text(
            "No highscore available.",
            style: TextStyle(
              fontFamily: 'PressStart2P',
              color: Colors.grey,
            ),
          );
        }
        // if it's working
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildHighscoreItem(document))
              .toList(),
        );
      },
    );
  }

  // _buildHighscoreItem
  Widget _buildHighscoreItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  data['senderUsername'],
                  style: const TextStyle(
                    fontFamily: 'PressStart2P',
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Row(
            children: [
              Expanded(
                child: Text(
                  "score: ${data['userScore']}",
                  style: const TextStyle(
                    fontFamily: 'PressStart2P',
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
