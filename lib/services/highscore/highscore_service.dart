import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasev1/model/score.dart';
import 'package:flutter/material.dart';

class HighScoreService extends ChangeNotifier {
  // get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  HighScoreService({Key? key});

// Send message
  Future<void> sendNewUserScore(int userScore) async {
    // get current user info
    final String thisUserId = _firebaseAuth.currentUser!.uid;
    final String thisUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new userscore
    Highscore newScore = Highscore(
        senderId: thisUserId,
        senderUsername: thisUserEmail,
        userScore: userScore,
        timestamp: timestamp);

    // add new userscore to datebase
    await _firestore.collection('highscores').add(newScore.toMap());
  }

  // Get messages
  Stream<QuerySnapshot> fetchUserScores() {
    return _firestore
        .collection('highscores')
        .orderBy('userScore', descending: true)
        .snapshots();
  }
}
