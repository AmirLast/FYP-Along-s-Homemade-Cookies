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
    apiKey: 'AIzaSyBQp1A9rTexL_7FX3-8N80OfwKhEx85_y0',
    appId: '1:922285547361:web:975cbd9a1f1614e0886f20',
    messagingSenderId: '922285547361',
    projectId: 'fyp-along-shomemadecookies',
    authDomain: 'fyp-along-shomemadecookies.firebaseapp.com',
    storageBucket: 'fyp-along-shomemadecookies.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBFRSwDrDnugM5ca2xaUxXMHN7Q4vNFX3Y',
    appId: '1:922285547361:android:459bb10fa60abe99886f20',
    messagingSenderId: '922285547361',
    projectId: 'fyp-along-shomemadecookies',
    storageBucket: 'fyp-along-shomemadecookies.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBH4Y4Ga3FESqZJUZsNxApIPCbQlvG8nQU',
    appId: '1:922285547361:ios:0f17829ee91e9ff7886f20',
    messagingSenderId: '922285547361',
    projectId: 'fyp-along-shomemadecookies',
    storageBucket: 'fyp-along-shomemadecookies.appspot.com',
    iosBundleId: 'com.example.fyp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBH4Y4Ga3FESqZJUZsNxApIPCbQlvG8nQU',
    appId: '1:922285547361:ios:0f17829ee91e9ff7886f20',
    messagingSenderId: '922285547361',
    projectId: 'fyp-along-shomemadecookies',
    storageBucket: 'fyp-along-shomemadecookies.appspot.com',
    iosBundleId: 'com.example.fyp',
  );
}
