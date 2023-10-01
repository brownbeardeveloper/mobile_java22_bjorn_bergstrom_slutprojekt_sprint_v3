import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasev1/model/message.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  // get instance of auth and firestore
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

// Send message
  Future<void> sendMessage(String message) async {
    // get current user info
    final String thisUserId = _firebaseAuth.currentUser!.uid;
    final String thisUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    // create a new message
    Message newMessage = Message(
        senderId: thisUserId,
        senderUsername: thisUserEmail,
        message: message,
        timestamp: timestamp);

    // add new message to datebase
    await _firestore.collection('chat').add(newMessage.toMap());
  }

  // Get messages
  Stream<QuerySnapshot> fetchMessages() {
    return _firestore
        .collection('chat')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
