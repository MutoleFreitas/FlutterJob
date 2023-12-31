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
    apiKey: "AIzaSyDltPPfUJ_qthBYh9oF7SIPp2P5mNfKpnw",
    authDomain: "biblioteca-cm.firebaseapp.com",
    projectId: "biblioteca-cm",
    storageBucket: "biblioteca-cm.appspot.com",
    messagingSenderId: "89087894897",
    appId: "1:89087894897:web:73668b6371d409d3d5c2d0",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyDltPPfUJ_qthBYh9oF7SIPp2P5mNfKpnw",
    appId: "1:89087894897:web:73668b6371d409d3d5c2d0",
    messagingSenderId: "89087894897",
    projectId: "biblioteca-cm",
    storageBucket: "biblioteca-cm.appspot.com",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyDltPPfUJ_qthBYh9oF7SIPp2P5mNfKpnw",
    appId: "1:89087894897:web:73668b6371d409d3d5c2d0",
    messagingSenderId: "89087894897",
    projectId: "biblioteca-cm",
    storageBucket: "biblioteca-cm.appspot.com",
    iosClientId:
        '93297685344-qiqtdfobg0fcfplg4uvrv4gdeoo67ekk.apps.googleusercontent.com',
    iosBundleId: 'com.example.vidViewr',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyDltPPfUJ_qthBYh9oF7SIPp2P5mNfKpnw",
    appId: "1:89087894897:web:73668b6371d409d3d5c2d0",
    messagingSenderId: "89087894897",
    projectId: "biblioteca-cm",
    storageBucket: "biblioteca-cm.appspot.com",
    iosClientId:
        '93297685344-qiqtdfobg0fcfplg4uvrv4gdeoo67ekk.apps.googleusercontent.com',
    iosBundleId: 'com.example.vidViewr',
  );
}
