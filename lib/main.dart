import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thesis_pubsconnect/main_app.dart';
import 'package:thesis_pubsconnect/utils/session_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  FirebaseOptions firebaseConfig;

  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    firebaseConfig = const FirebaseOptions(
      apiKey: "AIzaSyBscF7jto3agk8vn5CjvSdNkMigQ2KMnh8",
      authDomain: "pubsconnect-thesis.firebaseapp.com",
      databaseURL: "https://pubsconnect-thesis-default-rtdb.asia-southeast1.firebasedatabase.app",
      projectId: "pubsconnect-thesis",
      storageBucket: "pubsconnect-thesis.appspot.com",
      messagingSenderId: "1053907455233",
      appId: "1:1053907455233:web:94b17cafc0cbd68386df00",
      measurementId: "G-00W7FYTQT3"
    );
    await Firebase.initializeApp(options: firebaseConfig);
  } else {
    await Firebase.initializeApp();
  }
  

  // await Firebase.initializeApp(options: firebaseConfig);

  runApp(
    ChangeNotifierProvider(
      create: (context) => SessionProvider(),
      child: const MainApp(),
    ),
  );
}
