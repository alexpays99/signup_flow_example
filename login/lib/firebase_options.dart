import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBLcSabnKNpScMLfPp219Zvwa-DAmsm7Jo',
    appId: '1:690202184368:android:50e1ad14b069c4e145c975',
    messagingSenderId: '690202184368',
    projectId: 'interngram-echo',
    storageBucket: 'interngram-echo.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCOcWpg6JZMsapmqKlUr3GondMd27rztN4',
    appId: '1:690202184368:ios:84029d484ecf83e945c975',
    messagingSenderId: '690202184368',
    projectId: 'interngram-echo',
    storageBucket: 'interngram-echo.appspot.com',
    iosClientId:
        '690202184368-scc25n6jth1rsdg3gebbb0gh697o2810.apps.googleusercontent.com',
    iosBundleId: 'com.example.interngram',
  );
}
