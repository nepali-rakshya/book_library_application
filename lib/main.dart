// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:book_application/libraries.dart';

import 'package:book_application/screens/signin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBI2i33jn7psHvfG1_8bZa1BsEd8DOraac", // Your apiKey
      appId: "1:914740818584:android:6b55a0eac4bf78e668d6ed", // Your appId
      messagingSenderId: "914740818584", // Your messagingSenderId
      projectId: "book-application-ac1a7", // Your projectId
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      debugShowCheckedModeBanner: false,
      title: 'Note Keeping App',
      home: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return SigninScreen();
            }
          },
        ),
      ),
    );
  }
}
