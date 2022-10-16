import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String? lenderAddress;
String? borrowerAddress;
int? Amt;

String? outputTxt = "";

class Escrow extends StatefulWidget {
  const Escrow({Key? key}) : super(key: key);

  static const id = 'escrow_screen';

  @override
  State<Escrow> createState() => _EscrowState();
}

class _EscrowState extends State<Escrow> {
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
                  height: 30,
                ),
                _labelTextBorrowerAddress(
                    "Your Address", "Your Address as the borrower", false),
                const SizedBox(
                  height: 30,
                ),
                _labelTextLenderAddress("Lender's Address", "Address of the person that you'll send to", false),
                const SizedBox(
                  height: 30,
                ),
                _labelTextAmount("Amount", "Deposit on payment", false),
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
                    onPressed: () {

                      Future.delayed(const Duration(milliseconds: 5000), () {

// Here you can write your code

                        setState(() {

                          outputTxt = "tesSUCCESS: Escrow has been executed";
                          // Here you can write your code for open new view
                        });

                      });


                      //Implement Escrow functionality functionality.
                    },
                    child: Text(
                      "Create Escrow",
                      style:  TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                      ),

                    ),
                  ),
                ),),
                const SizedBox(
                  height: 20,
                ),
                Text(outputTxt!,
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),


    );
  }
}

Widget _labelTextBorrowerAddress(String label, String hintText, bool isPassword) {
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
              fontSize: 16,
          ),
        ),
      ),
      TextField(
        obscureText: isPassword,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, top: 13, bottom: 10),
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Color(0xffc5d2e1),
              fontWeight: FontWeight.w400,
              fontSize: 15,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffdfe8f3)),
          ),
        ),
        onChanged: (value) {
          borrowerAddress = value;
        },
      ),
    ],
  );
}
Widget _labelTextLenderAddress(String label, String hintText, bool isPassword) {
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
              fontSize: 16,
          ),
        ),
      ),
      TextField(
        obscureText: isPassword,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 10, top: 13, bottom: 10),
          hintText: hintText,
          hintStyle: const TextStyle(
              color: Color(0xffc5d2e1),
              fontWeight: FontWeight.w400,
              fontSize: 15,
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffdfe8f3)),
          ),
        ),
        onChanged: (value) {
          lenderAddress = value;
        },
      ),
    ],
  );
}
Widget _labelTextAmount(String label, String hintText, bool isPassword) {
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
              fontSize: 16,
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
          Amt = int.parse(value);
        },
      ),
    ],
  );
}

