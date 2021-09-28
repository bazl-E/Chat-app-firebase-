import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chats extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('sentAt', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatdata = chatSnapshot.data!.docs;
          // final user = FirebaseFirestore.instance.collection('users').get();
          return ListView.builder(
            reverse: true,
            itemCount: chatdata.length,
            itemBuilder: (ctx, i) => MessageBubble(
              chatdata[i]['text'],
              chatdata[i]['userName'],
              chatdata[i]['userImage'],
              chatdata[i]['userId'] == user!.uid,
              key: ValueKey(
                chatdata[i].id,
              ),
            ),
          );
        });
  }
}
