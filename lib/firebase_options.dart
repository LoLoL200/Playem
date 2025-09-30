

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseEnvOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return _web();
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return _android();
      case TargetPlatform.iOS:
        return _ios();
      case TargetPlatform.macOS:
        return _macos();
      case TargetPlatform.windows:
        return _windows();
      case TargetPlatform.linux:
        throw UnsupportedError(
          'FirebaseEnvOptions not configured for Linux.',
        );
      default:
        throw UnsupportedError(
          'FirebaseEnvOptions are not supported for this platform.',
        );
    }
  }

  static FirebaseOptions _web() => FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_API_KEY_WEB']!,
        appId: dotenv.env['FIREBASE_APP_ID_WEB']!,
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID_WEB']!,
        projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
        authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN_WEB'],
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET_WEB'],
        measurementId: dotenv.env['FIREBASE_MEASUREMENT_ID_WEB'],
      );

  static FirebaseOptions _android() => FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_API_KEY_ANDROID']!,
        appId: dotenv.env['FIREBASE_APP_ID_ANDROID']!,
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID_ANDROID']!,
        projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET_ANDROID'],
      );

  static FirebaseOptions _ios() => FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_API_KEY_IOS']!,
        appId: dotenv.env['FIREBASE_APP_ID_IOS']!,
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID_IOS']!,
        projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET_IOS'],
        iosBundleId: dotenv.env['FIREBASE_IOS_BUNDLE_ID'],
      );

  static FirebaseOptions _macos() => FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_API_KEY_MACOS']!,
        appId: dotenv.env['FIREBASE_APP_ID_MACOS']!,
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID_MACOS']!,
        projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET_MACOS'],
        iosBundleId: dotenv.env['FIREBASE_MACOS_BUNDLE_ID'],
      );

  static FirebaseOptions _windows() => FirebaseOptions(
        apiKey: dotenv.env['FIREBASE_API_KEY_WINDOWS']!,
        appId: dotenv.env['FIREBASE_APP_ID_WINDOWS']!,
        messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID_WINDOWS']!,
        projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
        authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN_WINDOWS'],
        storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET_WINDOWS'],
        measurementId: dotenv.env['FIREBASE_MEASUREMENT_ID_WINDOWS'],
      );
}


