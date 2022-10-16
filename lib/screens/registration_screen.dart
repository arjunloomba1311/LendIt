import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'chat_screen.dart';
import 'registerdetails_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

final _auth = FirebaseAuth.instance;
bool showSpinner = false;

String? email;
String? password;
class RegistrationScreen extends StatefulWidget {

  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

// class _RegistrationScreenState extends State<RegistrationScreen> {
//
//   //auth object to authenticate users
//   final _auth = FirebaseAuth.instance;
//   bool showSpinner = false;
//
//   String? email;
//   String? password;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: ModalProgressHUD(
//         inAsyncCall: showSpinner,
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 24.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[
//               Flexible(
//                 child: Hero(
//                   tag: 'logo',
//                   child: Container(
//                     height: 100.0,
//                     child: Image.asset('images/logo.png'),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 48.0,
//               ),
//               TextField(
//                 textAlign: TextAlign.center,
//                 keyboardType: TextInputType.emailAddress,
//                 style: TextStyle(color: Colors.black),
//                 onChanged: (value) {
//                   email = value;
//                   //Do something with the user input.
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Enter your email',
//                   hintStyle: TextStyle(color: Colors.black54),
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
//                     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
//                     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 8.0,
//               ),
//               TextField(
//                 obscureText: true,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: Colors.black),
//                 onChanged: (value) {
//                   password = value;
//                   //Do something with the user input.
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Enter your password',
//                   hintStyle: TextStyle(color: Colors.black54),
//                   contentPadding:
//                       EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
//                     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
//                     borderRadius: BorderRadius.all(Radius.circular(32.0)),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 24.0,
//               ),
//
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 16.0),
//                 child: Material(
//                   color: Colors.blueAccent,
//                   borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                   elevation: 5.0,
//                   child: MaterialButton(
//                     onPressed: () async {
//                       setState(() {
//                         showSpinner = true;
//                       });
//                       try {
//                             final newUser = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);
//
//                             if (newUser != null) {
//                               Navigator.pushNamed(context, RegistrationDetails.id);
//                             }
//
//                             setState(() {
//                               showSpinner = false;
//                             });
//                       }
//                       catch (e) {
//                         print(e);
//                         setState(() {
//                           showSpinner = false;
//                         });
//
//                       }
//
//                       // print(email);
//                       // print(password);
//                       //Implement registration functionality.
//                     },
//                     minWidth: 200.0,
//                     height: 42.0,
//                     child: Text(
//                       'Next',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
          bottomNavigationBar: const BottomAppBar(),
          backgroundColor: Colors.white,
          body: ModalProgressHUD(
            inAsyncCall: showSpinner,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Sign Up",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                        "Sign Up Now!",
                        style: TextStyle(fontSize: 14, color: Colors.grey,fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [_FbLogon(), _AppleLogon(), _GoogleLogon()],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    _labelTextInputEmail("Email", "johnsmith@gmail.com", false),
                    const SizedBox(
                      height: 25,
                    ),
                    _labelTextInputPassword("Password", "******", true),
                    const SizedBox(
                      height: 25,
                    ),
                    _labelTextInputPassword("Retype Password", "******", true),
                    const SizedBox(
                      height: 50,
                    ),
                    const SizedBox(height: 20),
                    Container(
                  width: double.infinity,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xff101223),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      setState(() {
                        showSpinner = true;
                      });
                      try {
                            final newUser = await _auth.createUserWithEmailAndPassword(email: email!, password: password!);
                            if (newUser != null) {
                              Navigator.pushNamed(context, RegistrationDetails.id);
                            }
                            setState(() {
                              showSpinner = false;
                            });
                      }
                      catch (e) {
                        print(e);
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    },
                    child: Text(
                      "Next Page",
                      style: GoogleFonts.josefinSans(
                        textStyle: const TextStyle(
                          color: Color(0xfff3f4f8),
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),//signup - next page
                    const SizedBox(height: 20),
                    _signBtn(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

Widget _labelTextInputPassword(String label, String hintText, bool isPassword) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 13),
        child: Text(
          label,
          style: GoogleFonts.josefinSans(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 13, 20, 29),
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
      ),
      TextField(
        obscureText: isPassword,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, top: 15, bottom: 10),
          hintText: hintText,
          prefixIcon: const Icon(Icons.lock_outline),
          hintStyle: GoogleFonts.josefinSans(
            textStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 114, 114, 114)),
          ),
        ),
        onChanged: (value) => {
          password = value
        },
      ),
    ],
  );
}

Widget _labelTextInputEmail(String label, String hintText, bool isPassword) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 13),
        child: Text(
          label,
          style: GoogleFonts.josefinSans(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 13, 20, 29),
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
      ),
      TextField(
        obscureText: isPassword,
        cursorColor: Colors.black,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, top: 13, bottom: 10),
          hintText: hintText,
          prefixIcon: const Icon(Icons.email_outlined),
          hintStyle: GoogleFonts.josefinSans(
            textStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 114, 114, 114)),
          ),
        ),
        onChanged: (value) => {
          email = value
        },
      ),
    ],
  );
}

// ignore: non_constant_identifier_names
Widget _FbLogon() {
  return SizedBox(
    width: 60,
    height: 60,
    child: IconButton(
      icon: const Icon(Icons.facebook_outlined),
      onPressed: () => {},
      color: Colors.grey,
      iconSize: 37,
    ),
  );
}

Widget _AppleLogon() {
  return SizedBox(
    width: 60,
    height: 60,
    child: IconButton(
      icon: const Icon(Icons.apple_outlined),
      onPressed: () => {},
      color: Colors.grey,
      iconSize: 37,
    ),
  );
}

Widget _GoogleLogon() {
  return SizedBox(
    width: 60,
    height: 60,
    child: IconButton(
      icon: const Icon(Icons.all_out),
      onPressed: () => {},
      color: Colors.grey,
      iconSize: 37,
    ),
  );
}

Widget _signBtn() {
  return Container(
    width: double.infinity,
    height: 60,
    decoration: const BoxDecoration(
      color: Color.fromARGB(173, 199, 199, 199),
      borderRadius: BorderRadius.all(Radius.circular(100)),
    ),
    child: TextButton(
      onPressed: () => {},
      child: Text(
        "Sign Up",
        style: GoogleFonts.josefinSans(
          textStyle: const TextStyle(
            color: Color(0xff101223),
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}

Widget _name(String label, String hintText, bool isPassword) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(
          left: 15,
        ),
        child: Text(
          label,
          style: GoogleFonts.josefinSans(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 13, 20, 29),
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
        ),
      ),
      TextField(
        obscureText: isPassword,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, top: 15, bottom: 10),
          hintText: hintText,
          prefixIcon: const Icon(Icons.person),
          hintStyle: GoogleFonts.josefinSans(
            textStyle: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 114, 114, 114)),
          ),
        ),
        onChanged: (value) {
        },
      ),
    ],
  );
}