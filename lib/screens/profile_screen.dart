import 'package:flutter/material.dart';
import 'package:flutter_firebase/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'chat_screen.dart';
import 'newProduct.dart';
import '../models/userModel.dart';
import 'productDetails.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'welcome_screen.dart';
import 'Alert.dart';

final _firestore = FirebaseFirestore.instance;
String? email;
User? loggedInUser;

final List<String> imgList = ['images/tech.png', 'images/recreation.png', 'hiking.png'];


class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  static const String id = 'profile_screen';

  @override
  State<profileScreen> createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {

  final _auth = FirebaseAuth.instance;
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

  //Key Components: Bottom Navigation, App Bar, Body

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric( vertical: 20),
        child: GNav(
          activeColor: Color(0xFF2196F3),
          gap: 8,
          padding: EdgeInsets.all(16),
          tabs: [
            GButton(
              icon: Icons.chat,
              text: 'Chat',
              onPressed: () {
                Navigator.pushNamed(context, ChatScreen.id);
              },
            ),
            GButton(
              icon: Icons.add,
              text: 'Add Item',
              onPressed: () {
                Navigator.pushNamed(context, newProduct.id);
              },
            ),
            GButton(
              icon: Icons.add_alert,
              text: 'Alerts',
              onPressed: () {
                Navigator.pushNamed(context, AlertScreen.id);
              }
            ),
            GButton(
              icon: Icons.person,
              text: 'Home',
            ),
          ],
        ),
      ),
      appBar: AppBar(

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close,color: Colors.black,),
            onPressed: () => {
            _auth.signOut(),
            Navigator.popUntil(context, ModalRoute.withName(WelcomeScreen.id))
            },
            color: Colors.black,
          )
        ],
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "LendIt",
                  style: TextStyle(color: Colors.black),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
        body: ModalProgressHUD(
            inAsyncCall: false,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                        Text('Welcome $email!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                        SizedBox(
                      height: 15,
                    ),
                        Text(
                        "Here's a few suggestions for what you can Borrow and Lend in our Lockers!", style: TextStyle(fontSize: 14), textAlign: TextAlign.start),
                        SizedBox(
                      height: 25,
                    ),
                        Container(child: newCarousel()),
                        SizedBox(
                      height: 30,
                    ),
                        Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text("Lent"),
                        const Text(
                          "Borrowed",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text("Map View")
                      ],
                    ),
                        SizedBox(
                      height: 30,
                    ),
                        Row(children: [const Text("Available Items",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.start),],),
                        SizedBox(
                      height: 30,
                    ),
                        productsStream(),
                        SizedBox(
                      height: 30,
                    ),
                        Row(children: [const Text("Things you've borrowed",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.start),],),
                        borrowedStream(),
                        SizedBox(
                      height: 30,
                    ),
                        Row(children: [const Text("Things that you've lent out",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.start),],),
                        SizedBox(
                      height: 30,
                    ),
                        Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color(0xff101223),
                            borderRadius: BorderRadius.all(Radius.circular(100)),
                          ),
                          child: TextButton(
                      onPressed: () => {
                          // String? id = widget.productId;
                          setState(() {
                            _firestore.collection('toRaspi').doc(loggedInUser?.uid).set({'hereToCollect': true});
                          })
                      },
                      child: Text(
                          "Collect Item Now",
                          style: const TextStyle(
                            color: Color(0xfff3f4f8),
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                      ),
                    ),
                        ),
                        SizedBox(
                      height: 30,
                    ),

                    // profileInfo(),
                        // Text('Your Friends', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54)),
                        // yourFriends(),
                      ],
                  ),
                ),
            ),
        );
  }
}
Widget newCarousel() {
  return CarouselSlider(
      items: [
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage('images/recreation.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage('images/hiking.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: AssetImage('images/tech.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
      options: CarouselOptions(
        height: 180.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ));

}

//Widget to loop through items that someone can borrow
class productsStream extends StatelessWidget {
  const productsStream({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('products').snapshots(),
      builder: (context, snapshot) {
        //class type is Product Bubble
        List<productsBubble> productBubbles = [];
        if (snapshot.hasData) {
          final products = snapshot.data!.docs;
          for (var product in products) {
              final productName = product.get('productName');
              final productCost = product.get('priceDay');
              final productId = product.reference.id;
              final productBubble = productsBubble(productName: productName, dailyCost: productCost, productId: productId);
              productBubbles.add(productBubble);
          }
        }
        return Container(
          width: 10000,
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            //Listview makes my app scrollable
              children: productBubbles,
            ),
        );
      },
    );
  }
}

//bubble for the styling of all products
class productsBubble extends StatelessWidget {
  const productsBubble({this.productName, this.dailyCost, this.productId});

  final String? productName;
  final int? dailyCost;
  final String? productId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {
      Navigator.push(context, MaterialPageRoute(builder: (context) => productDetails(productId: productId),))
      },
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.baseline,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.symmetric( horizontal: 5),
            child: Container(
              height: 150,
              width: 123,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child:
                      Text(productName!, style: TextStyle(color: Colors.white))),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: 60,
                        width: 60,
                      ),
                    ],
                  )
                ],
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/1.jpg'),
                  fit: BoxFit.cover,
                ),
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}

//Borrowed Stream
class borrowedStream extends StatelessWidget {
  borrowedStream();
  String? productId;
  String? productName;
  int? productCost;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("users").snapshots(),
        builder: (context, snapshot) {
          //iterate through all friends, once name found
          if (snapshot.hasData) {
            final users = snapshot.data!.docs;
            for (var user in users) {
              if (user.reference.id == loggedInUser?.uid) {
                productId = user.get('borrowed');
              }
            }
          }

          return StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection("products").snapshots(),
              builder: (context, snapshotNested) {
                List<productsBubble> productBubbles = [];
                if (snapshotNested.hasData) {
                  final products = snapshotNested.data!.docs;
                  for (var product in products) {
                    if (product.reference.id == productId) {
                      productName = product.get('productName');
                      productCost = product.get('priceDay');
                      final productBubble = productsBubble(productName: productName, dailyCost: productCost, productId: productId);
                      productBubbles.add(productBubble);
                    }
                  }
                }
                return Container(
                  width: 10000,
                  height: 150,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    //Listview makes my app scrollable
                    children: productBubbles,
                  ),
                );
              });
        }
    );
  }
}

