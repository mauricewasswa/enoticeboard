import 'package:enoticeboard/firebase_options.dart';
import 'package:enoticeboard/nav_pages/main_page.dart';
import 'package:enoticeboard/onboarding/onboarding.dart';
import 'package:enoticeboard/onboarding/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //firebase storage init
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppRouter(),
    );
  }
}

class AppRouter extends StatefulWidget {
  const AppRouter({Key? key}) : super(key: key);

  @override
  _AppRouterState createState() => _AppRouterState();
}

class _AppRouterState extends State<AppRouter> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _auth.authStateChanges().first,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final User? user = snapshot.data;

        return FutureBuilder<bool>(
          future: _isOnboardingComplete(),
          builder: (context, onboardingSnapshot) {
            if (onboardingSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            final bool onboardingComplete = onboardingSnapshot.data ?? false;

            if (!onboardingComplete) {
              return Onboarding();
            }

            if (user != null) {
              return HomePage();
            } else {
              return LoginPage();
            }
          },
        );
      },
    );
  }

  Future<bool> _isOnboardingComplete() async {
    // Replace the following line with your actual implementation
    // Example using shared_preferences:
     SharedPreferences prefs = await SharedPreferences.getInstance();
     return prefs.getBool('onboarding_complete') ?? false;
    return true;
  }
}
