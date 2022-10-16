import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'landing_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'registration_screen.dart';
import 'profile_screen.dart';

String? email;
String? password;

bool showSpinner = false;
final _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {

  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  //for loading the next page as an async call is made to the server

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomAppBar(),

        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Container(

    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("images/BackgroundLogin.png"),


    ),
    ),
            child: SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                  child: Container(
                    color: Colors.white,
                    height: 650,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Sign In",
                              style: TextStyle(
                                color: Colors.black,
                                  fontSize: 22, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start),
                          const SizedBox(height: 20),
                          const Text(
                              "Login!",
                              style: TextStyle(fontSize: 14, color: Colors.grey),
                              textAlign: TextAlign.start),
                          const SizedBox(
                            height: 50,
                          ),
                          _labelTextInputEmail(
                              'Email', "yourname@example.com", false),
                          const SizedBox(
                            height: 50,
                          ),
                          _labelTextInputPassword(
                              'Password', "Given Password", true),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [_FbLogon(), _AppleLogon(), _GoogleLogon()],
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
                              print(email);
                              setState(() {
                                showSpinner = true;
                              });
                              try {
                                final user = await _auth.signInWithEmailAndPassword(
                                    email: email!, password: password!);

                                if (user != null) {
                                  Navigator.pushNamed(context, profileScreen.id);
                                }

                                setState(() {
                                  showSpinner = false;
                                });
                              } catch (e) {
                                setState(() {
                                  showSpinner = false;
                                });
                                print(e);
                              }
                              //Implement login functionality.
                            },
                            child: Text(
                              "Log In",
                              style: const TextStyle(
                                  color: Color(0xfff3f4f8),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                          Container(
                        width: double.infinity,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 228, 228, 228),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: TextButton(
                          onPressed: () => {
                          Navigator.pushNamed(context, RegistrationScreen.id)
                        },
                          child: Text(
                            "Sign Up",
                            style: const TextStyle(
                                color: Color(0xff101223),
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                          const SizedBox(height: 60)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
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
          style: const TextStyle(
              color: Color.fromARGB(255, 13, 20, 29),
              fontWeight: FontWeight.w600,
              fontSize: 20,
          ),
        ),
      ),
      TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.black),
        obscureText: isPassword,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, top: 15, bottom: 10),
          hintText: hintText,
          prefixIcon: const Icon(Icons.lock_outline),
          hintStyle:  TextStyle(
              color: Color(0xffc5d2e1),
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),

          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffdfe8f3)),
          ),
        ),
        onChanged: (value) {
          password = value;
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
          style: const TextStyle(
              color: Color.fromARGB(255, 13, 20, 29),
              fontWeight: FontWeight.w600,
              fontSize: 20,
          ),
        ),
      ),
      TextField(
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(color: Colors.black),
        obscureText: isPassword,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, top: 13, bottom: 10),
          hintText: hintText,
          prefixIcon: const Icon(Icons.email_outlined),
          hintStyle:  TextStyle(
              color: Color(0xffc5d2e1),
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),

          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffdfe8f3)),
          ),
        ),
        onChanged: (value) {
          email = value;
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

// Widget _loginBtn() {
//   return Container(
//     width: double.infinity,
//     height: 60,
//     decoration: const BoxDecoration(
//       color: Color(0xff101223),
//       borderRadius: BorderRadius.all(Radius.circular(100)),
//     ),
//     child: TextButton(
//         onPressed: () async {
//           setState(() {
//             showSpinner = true;
//           });
//           try {
//             final user = await _auth.signInWithEmailAndPassword(
//                 email: email!, password: password!);
//
//             if (user != null) {
//               Navigator.pushNamed(context, landingPage.id);
//             }
//
//             setState(() {
//               showSpinner = false;
//             });
//           } catch (e) {
//             setState(() {
//               showSpinner = false;
//             });
//             print(e);
//           }
//           //Implement login functionality.
//         },
//       child: Text(
//         "Log In",
//         style: GoogleFonts.josefinSans(
//           textStyle: const TextStyle(
//             color: Color(0xfff3f4f8),
//             fontWeight: FontWeight.w800,
//             fontSize: 18,
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget _signBtn() {
//   return Container(
//     width: double.infinity,
//     height: 60,
//     decoration: const BoxDecoration(
//       color: Color.fromARGB(255, 228, 228, 228),
//       borderRadius: BorderRadius.all(Radius.circular(100)),
//     ),
//     child: TextButton(
//       onPressed: () => {
//         Navigator.pushNamed(context, landingPage.id);
//       },
//       child: Text(
//         "Sign Up",
//         style: GoogleFonts.josefinSans(
//           textStyle: const TextStyle(
//             color: Color(0xff101223),
//             fontWeight: FontWeight.w800,
//             fontSize: 18,
//           ),
//         ),
//       ),
//     ),
//   );
// }

Widget _Image() {
  return SizedBox(
      height: 436,
      width: 883,
      child: Image.network(
        ('https://www.verywellhealth.com/thmb/mqOqNSBIyH6q2wQfypw_PuR2OOk=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/GettyImages-1324188863-26d43224dc174820b798bb5533bf272b.jpg'),
        fit: BoxFit.none,
      ));
}