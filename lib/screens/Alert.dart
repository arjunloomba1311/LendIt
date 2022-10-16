import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({Key? key}) : super(key: key);

  static const String id = 'alert_screen';


  @override
  State<AlertScreen> createState() => _AlertScreen();
}

class _AlertScreen extends State<AlertScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => {
                Navigator.pop(context)
              },
              color: Colors.black,
            )
          ],
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                Text(
                  "LendIt",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text("Notifications",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
                const SizedBox(
                  height: 25,
                ),
                const Text("Your Alerts! ",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
                const SizedBox(
                  height: 25,
                ),
                _alerts()
                // CarouselWithDotsPage(imgList: imgList),
              ],
            ),
          ),
        ));
  }
}

Widget _alerts() {
  return Expanded(
    child: ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Container(
          height: 80,
          width: 100,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 215, 238, 216),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "A hat has been taken out of the locker",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

class AlertStream extends StatelessWidget {
  const AlertStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


