import 'package:flutter/material.dart';


class ChatBubble extends StatelessWidget {
  final String message;
   final Color boxColor;


  const ChatBubble({Key? key, required this.message,
    required this.boxColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: boxColor,
      ),
      child: Text(message, style: TextStyle(
        fontSize: 16, color: Colors.white
      ),),
    );
  }
}
