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
    apiKey: 'AIzaSyAQAY7JdkjIsFLk061apWoiMKYr8B5ZTFY',
    appId: '1:181390289480:web:9f8b164dfec0f13498c67d',
    messagingSenderId: '181390289480',
    projectId: 'my-project-686fe',
    authDomain: 'my-project-686fe.firebaseapp.com',
    storageBucket: 'my-project-686fe.appspot.com',
    measurementId: 'G-SXNRC7V7J9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBVHLKXwEnwWOubBihn6lOy_SKNOEu5cfw',
    appId: '1:181390289480:android:995185145afbe6d498c67d',
    messagingSenderId: '181390289480',
    projectId: 'my-project-686fe',
    storageBucket: 'my-project-686fe.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASACsxcaaRNLjjGuLRfaGJDhy4evN0Pdg',
    appId: '1:181390289480:ios:45f523aab15e144b98c67d',
    messagingSenderId: '181390289480',
    projectId: 'my-project-686fe',
    storageBucket: 'my-project-686fe.appspot.com',
    iosBundleId: 'com.example.myproject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyASACsxcaaRNLjjGuLRfaGJDhy4evN0Pdg',
    appId: '1:181390289480:ios:45f523aab15e144b98c67d',
    messagingSenderId: '181390289480',
    projectId: 'my-project-686fe',
    storageBucket: 'my-project-686fe.appspot.com',
    iosBundleId: 'com.example.myproject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAQAY7JdkjIsFLk061apWoiMKYr8B5ZTFY',
    appId: '1:181390289480:web:80f3efdd6eed793998c67d',
    messagingSenderId: '181390289480',
    projectId: 'my-project-686fe',
    authDomain: 'my-project-686fe.firebaseapp.com',
    storageBucket: 'my-project-686fe.appspot.com',
    measurementId: 'G-4VB1QGVWG6',
  );

 
}