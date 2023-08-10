import 'package:chatapp/components/MyButton.dart';
import 'package:chatapp/components/MyTextFiled.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth/AuthServices.dart';

class RegisterPage extends StatefulWidget {

  final void Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassword = TextEditingController();

  void registerUser() async {
    if(passwordController.text != confirmPassword.text){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:  Text(
            "Password do not  match!",
          )));
      return;
    }

    final authService = Provider.of<AuthServices>(context, listen: false);
    try {
      await authService.singOutWithEmailPassword(
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
                Icon(Icons.app_registration, size: 80, color: Colors.orangeAccent),
                const Text("Let`s create an account with us",
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
                  height: 10,
                ),
                MyTextFiled(
                  controller: confirmPassword,
                  hintText: "Confirm Password",
                  obscuredText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  onTap: registerUser,
                  text: "Register",
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already a Member ",
                        style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ))
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
