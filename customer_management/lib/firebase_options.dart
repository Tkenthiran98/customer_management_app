// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDuNadvI-BPNLwWBCl7VUVa9LsTTBgmqbs',
    appId: '1:256429737542:web:157ab42f667afba6876c47',
    messagingSenderId: '256429737542',
    projectId: 'flutter-apps-4bf2d',
    authDomain: 'flutter-apps-4bf2d.firebaseapp.com',
    storageBucket: 'flutter-apps-4bf2d.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAnAM9-jjIIy9kh_mn5TFCQU3kPVautaTU',
    appId: '1:256429737542:android:c482d4152ec22a16876c47',
    messagingSenderId: '256429737542',
    projectId: 'flutter-apps-4bf2d',
    storageBucket: 'flutter-apps-4bf2d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRY8zSSTRj4usw0M8dHKilxSFFeBJkJwM',
    appId: '1:256429737542:ios:17bf48b06ef6d0c0876c47',
    messagingSenderId: '256429737542',
    projectId: 'flutter-apps-4bf2d',
    storageBucket: 'flutter-apps-4bf2d.appspot.com',
    iosClientId: '256429737542-1f478orjbe4cvnftse7dt8t2oak37ed3.apps.googleusercontent.com',
    iosBundleId: 'com.example.customerManagement',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCRY8zSSTRj4usw0M8dHKilxSFFeBJkJwM',
    appId: '1:256429737542:ios:17bf48b06ef6d0c0876c47',
    messagingSenderId: '256429737542',
    projectId: 'flutter-apps-4bf2d',
    storageBucket: 'flutter-apps-4bf2d.appspot.com',
    iosClientId: '256429737542-1f478orjbe4cvnftse7dt8t2oak37ed3.apps.googleusercontent.com',
    iosBundleId: 'com.example.customerManagement',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDuNadvI-BPNLwWBCl7VUVa9LsTTBgmqbs',
    appId: '1:256429737542:web:cb3f8c6e531de4e7876c47',
    messagingSenderId: '256429737542',
    projectId: 'flutter-apps-4bf2d',
    authDomain: 'flutter-apps-4bf2d.firebaseapp.com',
    storageBucket: 'flutter-apps-4bf2d.appspot.com',
  );
}
