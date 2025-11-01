
import 'package:flutter/material.dart';



class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            'Login',
            style: TextStyle(fontSize: 24, color: Colors.white),
             )
          
         ),
      )
    );
  }
}
