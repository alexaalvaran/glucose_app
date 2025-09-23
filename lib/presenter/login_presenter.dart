import 'package:firebase_auth/firebase_auth.dart';
import '../model/authmodel.dart';

abstract class LoginView{
  void showLoading();
  void hideLoading();
  void showLoginError(String message);
  void navigateToHome();
}

class LoginPresenter {

  final LoginView view;
  final AuthModel model;

  LoginPresenter({required this.view, required this.model});

  void login(String email, String password) async {
    view.showLoading();
    try {
      await model.signIn(email: email, password: password);
      view.hideLoading();
      view.navigateToHome();
    } on FirebaseAuthException catch (e) {
      String message = '';
      if(e.code == 'user-not-found'){
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else {
        message = 'An unknown error occurred.';
      }
      view.hideLoading();
      view.showLoginError(message);
    }
  }
}
