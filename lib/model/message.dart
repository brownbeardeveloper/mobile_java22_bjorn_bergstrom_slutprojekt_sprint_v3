import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderUsername;
  final String message;
  final Timestamp timestamp;
  Message(
      {required this.senderId,
      required this.senderUsername,
      required this.message,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderUsername': senderUsername,
      'message': message,
      'timestamp': timestamp,
    };
  }
}
