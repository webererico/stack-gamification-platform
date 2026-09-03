// File generated normally by the FlutterFire CLI, but hand-written here as
// a PLACEHOLDER because this environment has no access to a real Firebase
// project. Every value below is a fake, non-functional stand-in.
//
// Before running the app for real:
//   1. Create a Firebase project at https://console.firebase.google.com
//   2. Enable Authentication -> Sign-in method -> Email/Password
//   3. Enable Firestore Database
//   4. Run `dart pub global activate flutterfire_cli` (once)
//   5. Run `flutterfire configure` from the project root and follow the
//      prompts — this REGENERATES this exact file with your real project's
//      values (and adds google-services.json / GoogleService-Info.plist).
//
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform. '
          'Run `flutterfire configure` to generate real options.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD7sGrOkDBH5c3mHtnPy-TRAHJJsXX58DM',
    appId: '1:30264076058:web:d14b412c9f1a238abc6ea3',
    messagingSenderId: '30264076058',
    projectId: 'stack-up-917a4',
    authDomain: 'stack-up-917a4.firebaseapp.com',
    storageBucket: 'stack-up-917a4.firebasestorage.app',
    measurementId: 'G-02VZW76HWS',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAFH2q-eLeADMZIlDLH6cv3iBg9L1SfP9o',
    appId: '1:30264076058:android:ac11aadf370e2b76bc6ea3',
    messagingSenderId: '30264076058',
    projectId: 'stack-up-917a4',
    storageBucket: 'stack-up-917a4.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA76TvYkzC98BJVZM4kVqeF2_-zA-Z1Ziw',
    appId: '1:30264076058:ios:f8779d4222297277bc6ea3',
    messagingSenderId: '30264076058',
    projectId: 'stack-up-917a4',
    storageBucket: 'stack-up-917a4.firebasestorage.app',
    iosClientId: '30264076058-vp570lqnvl7fn3val3ibf113ginmh51a.apps.googleusercontent.com',
    iosBundleId: 'com.webererico.stackGamificationPlatform',
  );
}
