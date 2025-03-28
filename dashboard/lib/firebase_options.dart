// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCwC5S965_kzlozt4J6nk5VbjqJZEwJsJ8',
    appId: '1:548288157184:web:b999eabd6c4cc4de4d6ae5',
    messagingSenderId: '548288157184',
    projectId: 'euportal-bb198',
    authDomain: 'euportal-bb198.firebaseapp.com',
    storageBucket: 'euportal-bb198.appspot.com',
    measurementId: 'G-L9T74XKGT9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAQAR3yTQXsUOcKAPZuykbluDc3bHDmp-E',
    appId: '1:548288157184:android:8e12c4ee855599944d6ae5',
    messagingSenderId: '548288157184',
    projectId: 'euportal-bb198',
    storageBucket: 'euportal-bb198.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBWT173W_IL6NdZT4hWLJx9ZeB-L6DwjsE',
    appId: '1:548288157184:ios:bf4a5aeea72fe52f4d6ae5',
    messagingSenderId: '548288157184',
    projectId: 'euportal-bb198',
    storageBucket: 'euportal-bb198.appspot.com',
    androidClientId: '548288157184-lqic9fujfuvo1n2e8k7iri4j44si76lv.apps.googleusercontent.com',
    iosClientId: '548288157184-kkq7ss4hsnhkbt8akotoq175an32hb0u.apps.googleusercontent.com',
    iosBundleId: 'com.example.dashboard',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBWT173W_IL6NdZT4hWLJx9ZeB-L6DwjsE',
    appId: '1:548288157184:ios:a98b12244ca09f5b4d6ae5',
    messagingSenderId: '548288157184',
    projectId: 'euportal-bb198',
    storageBucket: 'euportal-bb198.appspot.com',
    androidClientId: '548288157184-lqic9fujfuvo1n2e8k7iri4j44si76lv.apps.googleusercontent.com',
    iosClientId: '548288157184-44nt1fr6jca794ragqcutbu05fu18o51.apps.googleusercontent.com',
    iosBundleId: 'com.example.dashboard.RunnerTests',
  );
}
