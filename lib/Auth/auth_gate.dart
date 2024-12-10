import 'package:i_wakili/screens/signin_screen.dart';
import 'package:i_wakili/screens/signup_screen.dart';
import 'package:i_wakili/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            if (snapshot.hasData) {
              return const WelcomeScreen();
            }

            else {
              return const SignUpScreen();
            }
          }
      ),
    );
  }
}
