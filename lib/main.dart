import 'package:flutter/material.dart';

//screens import
import 'package:flutter_firebase/screens/welcome_screen.dart';
import 'package:flutter_firebase/screens/login_screen.dart';
import 'package:flutter_firebase/screens/registration_screen.dart';
import 'package:flutter_firebase/screens/chat_screen.dart';
import 'package:flutter_firebase/screens/registerdetails_screen.dart';
import 'package:flutter_firebase/screens/landing_page.dart';
import 'package:flutter_firebase/screens/profile_screen.dart';
import 'package:flutter_firebase/screens/newProduct.dart';
import 'package:flutter_firebase/screens/Alert.dart';
import 'package:flutter_firebase/screens/escrow.dart';

//firebase import
import 'package:firebase_core/firebase_core.dart';


void  main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        RegistrationDetails.id: (context) => RegistrationDetails(),
        landingPage.id: (context) => landingPage(),
        profileScreen.id: (context) => profileScreen(),
        newProduct.id: (context) => newProduct(),
        AlertScreen.id: (context) => AlertScreen(),
        Escrow.id: (context) => Escrow(),

      }
    );
  }
}
