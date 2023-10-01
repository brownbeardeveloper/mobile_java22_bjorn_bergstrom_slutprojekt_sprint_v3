import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasev1/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();

  void sendMessage() async {
    // only send message if textfield isn't empty
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(_messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20.0),
            Expanded(
              child: _buildMessageList(),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  // build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.fetchMessages(),
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
            "No messages available.",
            style: TextStyle(
              fontFamily: 'PressStart2P',
              color: Colors.grey,
            ),
          );
        }
        // if it's working
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
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
                // Wrap the message text with Expanded
                child: Text(
                  data['message'],
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

  Widget _buildMessageInput() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            decoration: InputDecoration(
              hintText: 'Enter message',
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Colors.green,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  width: 3,
                  color: Colors.green,
                ),
              ),
              suffixIcon: IconButton(
                onPressed: sendMessage,
                icon: const Icon(
                  Icons.send,
                  size: 30,
                  color: Colors.green,
                ),
              ),
              hintStyle: const TextStyle(
                fontFamily: 'PressStart2P',
                color: Colors.grey,
              ),
            ),
            style: const TextStyle(
              fontFamily: 'PressStart2P',
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
