import 'package:chatapp/model/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverId, String message) async {

    final currentUserId = auth.currentUser?.uid;
    final currentEmail = auth.currentUser?.email;
    final timeStamp = Timestamp.now();

    Message newMessage = Message(currentUserId!, currentEmail!,
        receiverId, message, timeStamp);

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoomId = ids.join("_");

    await firestore.collection('chat_rooms')
        .doc(chatRoomId).collection('messages')
        .add(newMessage.toMap());

  }

  Stream<QuerySnapshot> getMessages(String usrId, String otherUser){

    List<String> ids = [usrId, otherUser];
    ids.sort();
    String chartId = ids.join("_");

    return firestore
        .collection('chat_rooms')
        .doc(chartId)
        .collection('messages')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
}