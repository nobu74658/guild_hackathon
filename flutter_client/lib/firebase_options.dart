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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACWOHwz6y-v-tMnzqwgUQDcVxtCXgoZ28',
    appId: '1:561731936896:android:808045c2d9fb221a1f7c65',
    messagingSenderId: '561731936896',
    projectId: 'yiwashita-guild-hackason',
    storageBucket: 'yiwashita-guild-hackason.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDOy-f7p608JUtv3Glf2GqObJ_Xcn-oI_Y',
    appId: '1:561731936896:ios:571a08af8a56942d1f7c65',
    messagingSenderId: '561731936896',
    projectId: 'yiwashita-guild-hackason',
    storageBucket: 'yiwashita-guild-hackason.firebasestorage.app',
    iosClientId: '561731936896-bfjuqt8bhjni80cgta8jc7kvtrpq578h.apps.googleusercontent.com',
    iosBundleId: 'com.yiwashita.knitting',
  );
}
