import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/screens/profile_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/productModel.dart';
import '../models/imageModel.dart';

final _firestore = FirebaseFirestore.instance;
final _auth = FirebaseAuth.instance;
User? loggedInUser;
bool showSpinner = false;

String? productName;
String? description;
int? priceDay;

class newProduct extends StatefulWidget {
  static const String id = 'newproduct_screen';
  // const newProduct({Key? key}) : super(key: key)
  @override
  State<newProduct> createState() => _newProductState();
}

class _newProductState extends State<newProduct> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  void getCurrentUser()  {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
    }
    catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "LendIt",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Center(
            child: ListView(
              children: [
                const Text("Product Details",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
                const SizedBox(height: 20),
                const Text(
                    "Add something you'd like to lend, and help your friends to avoid unnecessary purchases!",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    textAlign: TextAlign.start),
                const SizedBox(
                  height: 10,
                ),
                _picture(),
                const SizedBox(
                  height: 30,
                ),
                _labelTextInputProduct(
                    "Product Name", "yourname@example.com", false),
                const SizedBox(
                  height: 30,
                ),
                _labelTextInputDescription("Description", "Short Description", false),
                const SizedBox(
                  height: 30,
                ),
                _labelTextInputPrice("Price", "Price per Day", false),
                const SizedBox(
                  height: 30,
                ),
                Center(child: Container(
                  width: 350,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextButton(
                    onPressed: () async {
                      try {Product product = new Product(loggedInUser?.uid, productName, description, priceDay);
                                  await _firestore.collection('products')
                                      .add({
                                    "productName": productName,
                                    "description": description,
                                    "priceDay": priceDay,
                                    "userLent": loggedInUser?.uid,
                                    "lockerNumber": product.getLockerNumber(),
                                    "location": product.getlocation(),
                                  });
                                  Navigator.pop(context);
                                } catch (e) {
                                  print(e);
                                }
                              //Implement registration functionality.
                            },
                    child: Text(
                      "Submit Product",
                      style:  TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),

                    ),
                  ),
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
Widget _labelTextInputProduct(String label, String hintText, bool isPassword) {
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
              fontSize: 16,
            ),
          ),
        ),
      ),
      TextField(
        obscureText: isPassword,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, top: 13, bottom: 10),
          hintText: hintText,
          hintStyle: GoogleFonts.josefinSans(
            textStyle: const TextStyle(
              color: Color(0xffc5d2e1),
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffdfe8f3)),
          ),
        ),
        onChanged: (value) {
          productName = value;
        },
      ),
    ],
  );
}

Widget _labelTextInputDescription(String label, String hintText, bool isPassword) {
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
              fontSize: 16,
            ),
          ),
        ),
      ),
      TextField(
        obscureText: isPassword,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, top: 13, bottom: 10),
          hintText: hintText,
          hintStyle: GoogleFonts.josefinSans(
            textStyle: const TextStyle(
              color: Color(0xffc5d2e1),
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffdfe8f3)),
          ),
        ),
        onChanged: (value) {
          description = value;
        },
      ),
    ],
  );
}

Widget _labelTextInputPrice(String label, String hintText, bool isPassword) {
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
              fontSize: 16,
            ),
          ),
        ),
      ),
      TextField(
        obscureText: isPassword,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, top: 13, bottom: 10),
          hintText: hintText,
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
          priceDay = int.parse(value);
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
        height: 130,
        width: 130,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Background.png'),
            fit: BoxFit.fill,
          ),
          shape: BoxShape.circle,
        ),
      ),
    ),
  );
}

