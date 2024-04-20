import 'package:diety_/features/Home/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'features/Asks/Gender.dart';
import 'features/Auth/Login.dart';
import 'features/Auth/SignUp.dart';
import 'features/Onboarding/view/onbording_screan.dart';
// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyAlLvnHxfl1dDBAhcM7NBNMzg031_nKSwM',
      appId: '1:1086387828729:web:8ff901f2f47cb3162c2f28',
      messagingSenderId: '1086387828729',
      projectId: 'diety-36af6',
      authDomain: 'diety-36af6.firebaseapp.com',
      storageBucket: 'diety-36af6.appspot.com',
      measurementId: 'G-WBRNBEJC26',
      databaseURL: 'https://diety-36af6-default-rtdb.firebaseio.com/',
    ),
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('================================User is currently signed out!');
      } else {
        print('================================User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: (FirebaseAuth.instance.currentUser != null &&
                FirebaseAuth.instance.currentUser!.emailVerified)
            ? const Gender()
            : const OnboardingScreen(),
        routes: {
          "SingUp": (context) => const SignUp(),
          "Login": (context) => const Login(),
          "home": (context) => const Home(),
          "Gender": (context) => const Gender(),
        });
  }
}
