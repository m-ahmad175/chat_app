import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthServices extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserCredential> singInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // firestore.collection('user').doc(userCredential.user!.uid).set({
      //   'uid': userCredential.user!.uid,
      //   'email': userCredential.user!.email,
      // }, SetOptions(merge: true));

      var document = await firestore
          .collection('user')
          .doc(userCredential.user!.uid)
          .get();
      Map<String, dynamic>? dataUser = document.data();

      final ref =
          FirebaseStorage.instance.ref().child(userCredential.user!.uid);

      final urlDownload = await ref.getDownloadURL();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> singUpWithEmailPassword(
      String name, String email, String password, XFile file) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      firestore.collection('user').doc(userCredential.user!.uid).set({
        'name': name,
        'uid': userCredential.user!.uid,
        'email': userCredential.user!.email,
      });

      uploadImage(userCredential.user!.uid, file);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<void> uploadImage(String uuid, XFile file) async {
    final ref = FirebaseStorage.instance.ref().child(uuid);

    UploadTask upload = ref.putFile(File(file.path));

    final snapshot = await upload!.whenComplete(() => {});

    final urlDownload = await snapshot.ref.getDownloadURL();
  }

  Future<void> singOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
