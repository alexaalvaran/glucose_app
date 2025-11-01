import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/authmodel.dart';
import '../../presenter/authpresenter.dart';
import '../login/login.dart';

class SignupPage extends StatefulWidget {
  SignupPage({super.key});
  
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  State<SignupPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignupPage> implements AuthView {
  late Authpresenter presenter;

  @override
  void initState() {
    super.initState();
    presenter = Authpresenter(view: this, model: AuthModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('GlucoseNet',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 32,
        ),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 100),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50.0),
          ),
          child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 20, right:20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const SizedBox(height: 20),
                const Text('Email'),
                TextField(
                  controller: widget.emailController,
                  decoration: const InputDecoration(
                    labelText: 'example@gmail.com',
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 20),
                const Text('Password'),
                TextField(
                  controller: widget.passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),

                const Padding(padding: EdgeInsets.only(top: 50)),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      String email = widget.emailController.text.trim();
                      String password = widget.passwordController.text.trim();
                      presenter.signUp(email, password);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),

                    child: const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        )
        ),
    );

  }

  @override
  void showLoading() {
    Fluttertoast.showToast(
      msg: 'Loading...',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.blue,
      textColor: Colors.white,
      fontSize: 14.0,
      );
  }

  @override
  void hideLoading() {
    Fluttertoast.cancel();
  }

  @override
  void showSignUpSuccess() {
    Fluttertoast.showToast(
      msg: 'Login successful',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 14.0,
      );
  }

  @override
  void showSignUpError(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 14.0,
      );
  }

  @override
  void navigateToLogin() {
   Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (BuildContext context) => const LoginPage())
   );
  }
}