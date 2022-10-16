import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_firebase/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/screens/profile_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'escrow.dart';

import '../models/productModel.dart';

final _firestore = FirebaseFirestore.instance;
String? email;
User? loggedInUser;

//can possibily get UserName that lent also as an input to the function!
class productDetails extends StatefulWidget {
  const productDetails({Key? key, required this.productId}) : super(key: key);

  final String? productId;


  @override
  State<productDetails> createState() {
    return _productDetailsState();
  }
}

class _productDetailsState extends State<productDetails> {

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
    // setState(() {
    //   getProductDetails();
    //   getUserCreatedName();
    // });
  }

  // void getProductDetails() {
  //   //query to get particular product of specific Id
  //
  //   try {
  //     getData() async {
  //       return await _firestore.collection('products')
  //           .doc(widget.productId)
  //           .get();
  //     }
  //
  //     getData().then((val) =>
  //     {
  //       userLent = val.data()?["userLent"],
  //       print(userLent),
  //       description = val.data()?["description"],
  //       lockerNumber = val.data()?["lockerNumber"],
  //       priceDay = val.data()?["priceDay"],
  //       productName = val.data()?["productName"],
  //       location = val.data()?["location"]
  //     });
  //
  //
  //
  //   } catch (e) {
  //     print(e);
  //   }
  //
  // }

  // get the user 'Name' that created this product -
  // void getUserCreatedName() {
  //   try {
  //     getData1() async {
  //       return await _firestore.collection('users').doc(userLent).get();
  //     }
  //
  //     getData1().then((val) => {
  //       userNameThatLent = val.data()?["name"],
  //       print(userNameThatLent)
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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
        actions: <Widget>[],
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
      body: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Container(child: productDetailsStream(widget.productId)),
    Container(width: 250, height: 60,
      decoration: const BoxDecoration(
    color: Color(0xff101223),
    borderRadius: BorderRadius.all(Radius.circular(100)),
    ),
    child: TextButton(
    onPressed: () => {
      // String? id = widget.productId;
      setState(() {
        _firestore.collection('users').doc(loggedInUser?.uid).update({'borrowed': widget.productId});

      })



    },
    child: Text(
    "Borrow Item",
    style: const TextStyle(
    color: Color(0xfff3f4f8),
    fontWeight: FontWeight.w800,
    fontSize: 18,
    ),
    ),
    ),
    ),
            SizedBox(height: 10),
            Container(width: 250, height: 60,
              decoration: const BoxDecoration(
                color: Color(0xff101223),
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: TextButton(
                onPressed: () => {
                  // String? id = widget.productId;
                  Navigator.pushNamed(context, Escrow.id)
                },
                child: Text(
                  "Set up Escrow",
                  style: const TextStyle(
                    color: Color(0xfff3f4f8),
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
              ),
            ) ])


    //   body: Column(
    //      children: [Column(
    //        children: <Widget>[
    //          Text('Arjun', style: TextStyle(fontSize: 15, color: Colors.black)),
    //          Text(description.toString(), style: TextStyle(fontSize: 15, color: Colors.black)),
    //          Text(lockerNumber.toString(), style: TextStyle(fontSize: 15, color: Colors.black)),
    //          Text(location.toString(), style: TextStyle(fontSize: 15, color: Colors.black)),
    //          Text(productName.toString(), style: TextStyle(fontSize: 15, color: Colors.black)),
    //        ],
    //      ),
    //        Padding(
    //          padding: EdgeInsets.symmetric(vertical: 16.0),
    //          child: Material(
    //            color: Colors.blueAccent,
    //            borderRadius: BorderRadius.all(Radius.circular(30.0)),
    //            elevation: 5.0,
    //            child: MaterialButton(
    //              onPressed: ()  {
    //                var id = widget.productId;
    //                var list_name = [];
    //                getData() async {
    //                  return await _firestore.collection('users').doc(loggedInUser?.uid).get();
    //                }
    //                getData().then((val) => {
    //                for (var value in val.data()?['borrowed']) {
    //                  list_name.add(value)
    //                },
    //                });
    //
    //                list_name.add(widget.productId);
    //
    //                var list_name1 = [];
    //                bool flag = false;
    //                getData1() async {
    //                  return await _firestore.collection('users').doc(loggedInUser?.uid).get();
    //                }
    //                getData1().then((val) => {
    //                  for (var value in val.data()?['lent']) {
    //                    list_name1.add(value),
    //                    if (value == widget.productId) {
    //                      flag = true
    //                    }
    //                  },
    //                  //    print(val.data()?['borrowed'])
    //                });
    //
    //                if (!flag) {
    //                  list_name1.add(widget.productId);
    //                }
    //
    //                print(list_name1);
    //                _firestore.collection('users').get().then((snapshot) {
    //                  for (DocumentSnapshot ds in snapshot.docs) {
    //                    ds.reference.update({
    //                      'borrowed':list_name,
    //                      'lent':list_name1
    //                    });
    //                  }
    //                });
    //
    //                },
    //              minWidth: 200.0,
    //              height: 42.0,
    //              child: Text(
    //                'Borrow',
    //                style: TextStyle(color: Colors.white),
    //              ),
    //            ),
    //          ),
    //        ),]
    // ),
    );
      // Text(widget.productId!);
  }
}
class productDetailsStream extends StatelessWidget {
  productDetailsStream(this.productId);
  final String? productId;

  String? userLent;
  String? description;
  int? priceDay;
  String? location;
  int? lockerNumber;
  String? productName;

  String? userNameThatLent;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("products").snapshots(),
        builder: (context, snapshot) {
          //iterate through all friends, once name found
          if (snapshot.hasData) {
            final products = snapshot.data!.docs;
            for (var product in products) {
              if (product.reference.id == productId) {
                userLent = product.get('userLent');
                print(userLent);
                description = product.get('description');
                priceDay = product.get('priceDay');
                location = product.get('location');
                lockerNumber = product.get('lockerNumber');
                productName = product.get('productName');
              }
            }
          }

          return StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection("users").snapshots(),
          builder: (context, snapshotNested) {


            if (snapshotNested.hasData) {
              final users = snapshotNested.data!.docs;
              for (var user in users) {
                if (user.reference.id == userLent) {
                  userNameThatLent = user.get('name');
              }
            }
          }
            return Container(
              child: productDetailsBubble(productName: productName, userThatLentName: userNameThatLent, description: description, priceDay: priceDay, location: location, lockerNumber: lockerNumber)
            );
          });
        }
    );
  }
}

class productDetailsBubble extends StatelessWidget {

  const productDetailsBubble({this.productName, this.userThatLentName, this.description, this.priceDay, this.location, this.lockerNumber});

  final String? productName;
  final String? userThatLentName;
  final String? description;
  final int? priceDay;
  final String? location;
  final int? lockerNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          SizedBox(
            height: 5,
            width: double.infinity,
          ),
          Text(productName!, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
          SizedBox(
            height: 20,
            width: double.infinity,
          ),
          Text(
              description!,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.start),
          const SizedBox(
            height: 30,
            width: double.infinity,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'images/ProductImage.png',
                    ),
                    fit: BoxFit.fill),
              ),
              width: 250,
              height: 330,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _dots(),
                _Clickeddots(),
                _dots(),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.library_books),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "26\u1d57\u02b0 Oct",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.house),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            location!,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.check),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        lockerNumber!.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 23, right: 85),
                child: Text("DATE", style: TextStyle(fontSize: 14)),
              ),
              const Text("LOCATION", style: TextStyle(fontSize: 14)),
              const Padding(
                padding: EdgeInsets.only(left: 60),
                child: Text("LOCKER", style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ));
      // Column(
      //   children: <Widget>[
      //     Material(
      //       borderRadius: BorderRadius.circular(30.0),
      //       elevation: 5.0,
      //       color: Colors.lightBlueAccent,
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      //         child: Column(
      //           children: [
      //             Text(userThatLentName!),
      //             Text(description!),
      //             Text(priceDay!.toString()),
      //             Text(location!),
      //             Text(lockerNumber!.toString())
      //           ],
      //         )
    // )]));
  }
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
      onPressed: () => {

      },
      child: Text(
        "Borrow Item",
          style: const TextStyle(
            color: Color(0xfff3f4f8),
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
      ),
    );
  // );
}

Widget _dots() {
  return Center(
    child: Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 3,
      ),
      decoration:
      const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
    ),
  );
}

Widget _Clickeddots() {
  return Center(
    child: Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 3,
      ),
      decoration:
      const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
    ),
  );
}






