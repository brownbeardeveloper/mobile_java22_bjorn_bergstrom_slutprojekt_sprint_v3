import 'package:cloud_firestore/cloud_firestore.dart';

class Highscore {
  final String senderId;
  final String senderUsername;
  final int userScore;
  final Timestamp timestamp;
  Highscore(
      {required this.senderId,
      required this.senderUsername,
      required this.userScore,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderUsername': senderUsername,
      'userScore': userScore,
      'timestamp': timestamp,
    };
  }
}
