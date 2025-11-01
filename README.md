# Glucose App

This mobile application is a Flutter-based Glucose App designed to help users track and manage their blood glucose levels.

The app integrates Firebase Authentication for user login and registration, and Cloud Firestore for securely storing glucose readings in real time.

# Running the app locally

## 1.Requirements
- Flutter SDK
- Xcode (iOS) or Android Studio (Android)
- Emulator or physical device

## 2.Clone Repository

```
git clone https://github.com/alexaalvaran/glucose_app.git
cd glucose_app
```

## 3.Install Dependencies

```
flutter pub get
```

## 4.Run The Application
Start the emulator or connect to a physical device and run:

```
flutter run
```

If multiple devices are connected run:

```
flutter run -d <device-id>
```

## 5.User Login
You have the option of creating a new user, if you do not wish to there is a test user account:

- email: test@gmail.com
- password: test123

# Expected Screens
- User login and registration : Forms for login or registration
- Home screen : Empty home screen with navigation bar at the bottom of the screen.
- Glucose reading: Page containing all authenticated user readings and options to delete or add reading
- Glucose form: Form to add a new glucose reading

# Firebase

Firebase Authentication was used for user authentication for login and register.
Firebase Cloud Firestore was used as the database to store and retrieve data.

Internet connection is required for Firebase functionality. 
This repository contains API keys for Firebase - which is safe for client use as thye only connect to this Firebase project. 


