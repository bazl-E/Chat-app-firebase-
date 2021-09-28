import 'dart:io';

import 'package:chat_app/widgets/auth/auth_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var isLoading = false;
  void _submitData(
    String emailID,
    String? userName,
    String passWord,
    dynamic userImage,
    bool islogin,
    BuildContext ctx,
  ) async {
    UserCredential userCredential;
    try {
      setState(() {
        isLoading = true;
      });
      if (islogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: emailID,
          password: passWord,
        );
        isLoading = false;
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: emailID, password: passWord);

        final ref = FirebaseStorage.instance
            .ref()
            .child('User_images')
            .child(userCredential.user!.uid + '.jpg');
        await ref.putFile(File(userImage.path));
        final imageUrl = await ref.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'username': userName,
          'email': emailID,
          'userImage': imageUrl,
        });
        print(userName);
        isLoading = false;
      }
    } on FirebaseAuthException catch (err) {
      setState(() {
        isLoading = false;
      });
      var message = 'An error occured, please check your credentials';
      if (err.message != null) {
        message = err.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(
            message,
            style: TextStyle(color: Colors.red),
          ),
          backgroundColor: Colors.white,
        ),
      );
    } catch (err) {
      print(err);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthCard(_submitData, isLoading),
    );
  }
}
