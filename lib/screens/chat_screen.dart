import 'package:chat_app/widgets/chat/chat_maker.dart';
import 'package:chat_app/widgets/chat/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   // await Firebase.initializeApp();

//   print("Handling a background message: ${message.messageId}");
// }

class ChatSCreen extends StatefulWidget {
  const ChatSCreen({Key? key}) : super(key: key);

  @override
  _ChatSCreenState createState() => _ChatSCreenState();
}

class _ChatSCreenState extends State<ChatSCreen> {
  @override
  void initState() {
    FirebaseMessaging.instance.getToken().then((value) {
      FirebaseMessaging.onMessage.listen((event) {
        print(event.toString() + 'thisi the mesage.....');
      });
      // FirebaseMessaging.onBackgroundMessage((message) async {
      //   print(message.notification);
      // });
      // FirebaseMessaging.onBackgroundMessage((message) async {
      //   print(message.notification);
      // });
      // FirebaseMessaging.onMessageOpenedApp.listen((event) {
      //   print(event.toString() + 'thisi the mesage.....');
      // });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              items: [
                DropdownMenuItem(
                  onTap: () {},
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.blueGrey,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout'),
                      ],
                    ),
                  ),
                  value: 'logout',
                ),
              ],
              onChanged: (ident) {
                if (ident == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Chats(),
            ),
            ChatCreator(),
          ],
        ),
      ),
    );
  }
}
