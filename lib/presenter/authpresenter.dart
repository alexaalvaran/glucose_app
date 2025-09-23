import 'package:firebase_auth/firebase_auth.dart';
import '../model/authmodel.dart';
import 'package:flutter/material.dart';

abstract class AuthView {
  void showLoading();
  void hideLoading();
  void showSignUpSuccess();
  void showSignUpError(String message);
  void navigateToLogin();
}

class Authpresenter {

  final AuthView view;
  final AuthModel model;

  Authpresenter({required this.view, required this.model});

  void signUp(String email, String password) async {
    view.showLoading();
    try {
      await model.signUp(email: email, password: password);
      view.hideLoading();
      view.showSignUpSuccess();
      view.navigateToLogin();
    } on FirebaseAuthException catch (e) {
      String message = '';
      if(e.code == 'email-already-in-use'){
        message = 'Email is already in use';
        view.showSignUpError(message);
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak';
        view.showSignUpError(message);
      }
    }
  }
}