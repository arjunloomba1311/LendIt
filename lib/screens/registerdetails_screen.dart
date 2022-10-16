import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase/screens/profile_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'landing_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


//required variables
bool showSpinner = false;
int? phone;
String? name;

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? loggedInUser;


class RegistrationDetails extends StatefulWidget {
  const RegistrationDetails({Key? key}) : super(key: key);



  static const String id = 'registerdetails_screen';
  @override
  State<RegistrationDetails> createState() => _RegistrationDetailsState();
}

class _RegistrationDetailsState extends State<RegistrationDetails> {

  String? email;

  void getCurrentUser()  {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        // print(loggedInUser?.uid);
      }
    }
    catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    email = loggedInUser?.email;
    print(email);
  }

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;

  //picking image
  io.File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = io.File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = io.File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_photo!);
    } catch (e) {
      print('error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const BottomAppBar(),
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 20),
              child: ListView(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text("Sign Up",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                        "Almost There! Just a few additional Details. "
                            ""
                            "Spoiler Alert: Your image helps us letting you access the locker.",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
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
                    // _picture(),
                    const SizedBox(
                      height: 25,
                    ),
                    _name("Full Name", "John Smith", false),
                    const SizedBox(
                      height: 25,
                    ),
                    _number("Phone Number", "XXX-XXX-XXXX", false),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                children: <Widget>[
                  SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Color(0xff03A9F4),
                        child: _photo != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _photo!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                            : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50)),
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: double.infinity,
                      height: 60,
                      decoration: const BoxDecoration(
                      color: Color(0xff101223),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: TextButton(
                      onPressed:() async {
                    if (phone != null && name != null) {
                      try {
                             await _firestore.collection('users')
                                 .doc(loggedInUser?.uid)
                                 .set({
                             'name': name,
                             'phone': phone,
                             'uid': loggedInUser?.uid,
                             'borrowed': null,
                             'lent': null,
                             });
                             Navigator.pushNamed(context, profileScreen.id);
                             } catch (e) {
                        print(e);
                            }
                    }
                  },
                      child: Text(
                        "Sign Up",
                        style: const TextStyle(
                            color: Color(0xfff3f4f8),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                      ),
                    ),
                  ),
                    const SizedBox(height: 20),
                    SizedBox(height: 20.0,),
                  ],
                ),
              ),
            ),
          ),
        );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              color: Colors.transparent,
              child: new Wrap(

                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

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
        style: TextStyle(color: Colors.black),
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
          name = value;
        },
      ),
    ],
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

Widget _loginBtn() {
  return Container(
    width: double.infinity,
    height: 60,
    decoration: const BoxDecoration(
      color: Color(0xff101223),
      borderRadius: BorderRadius.all(Radius.circular(100)),
    ),
    child: TextButton(
      onPressed: () => {},
      child: Text(
        "Log In",
        style: GoogleFonts.josefinSans(
          textStyle: const TextStyle(
            color: Color(0xfff3f4f8),
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
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

Widget _number(String label, String hintText, bool isPassword) {
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
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, top: 15, bottom: 10),
          hintText: hintText,
          prefixIcon: const Icon(Icons.local_phone),
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
          phone = int.parse(value);
        },
      ),
    ],
  );
}

Widget _picture() {
  return Center(
    child: InkWell(
      onTap: () => {},
      child: Container(
        height: 180,
        width: 180,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('lib/images/Background.png'),
            fit: BoxFit.fill,
          ),
          shape: BoxShape.circle,
        ),
      ),
    ),
  );
}
