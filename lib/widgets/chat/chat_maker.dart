import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatCreator extends StatefulWidget {
  ChatCreator({Key? key}) : super(key: key);

  @override
  _ChatCreatorState createState() => _ChatCreatorState();
}

class _ChatCreatorState extends State<ChatCreator> {
  var enteredMessage = '';
  final controller = TextEditingController();
  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    print(enteredMessage.trim());
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    await FirebaseFirestore.instance.collection('chat').add({
      'text': enteredMessage.trim(),
      'sentAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData['username'],
      'userImage': userData['userImage'],
    });
    controller.clear();
    enteredMessage = '';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(hintText: 'Send a message...'),
              onChanged: (value) {
                setState(() {
                  enteredMessage = value;
                });
              },
            ),
          ),
          IconButton(
            onPressed: enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
