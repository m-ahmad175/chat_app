import 'package:chatapp/pages/chat/HomePage.dart';
import 'package:chatapp/services/auth/LoginOrRegister.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // for facebook application
              return const HomePage();

              // for chat application

              //return const HomePage();
            } else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
