import 'package:chatapp/components/MyButton.dart';
import 'package:chatapp/components/MyTextFiled.dart';
import 'package:chatapp/services/auth/AuthServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //var  userInfo = UserDataInfo("", "", "", "");

  void signIn() async {
    final authService = Provider.of<AuthServices>(context, listen: false);
    try {
      await authService.singInWithEmailPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        e.toString(),
      )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.login, size: 80, color: Colors.orangeAccent),
                const Text("Login to connect with others",
                    style: TextStyle(fontSize: 16)),
                const SizedBox(
                  height: 25,
                ),
                MyTextFiled(
                  controller: emailController,
                  hintText: "Email",
                  obscuredText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextFiled(
                  controller: passwordController,
                  hintText: "Password",
                  obscuredText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  onTap: signIn,
                  text: "Sign In",
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a Member? ",
                        style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
