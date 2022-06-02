import 'package:bue_university_project/presentation/main_admin.dart';
import 'package:bue_university_project/presentation/main_busdriver.dart';
import 'package:bue_university_project/presentation/main_student.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'presentation/resources/assets_manager.dart';
import 'presentation/resources/routes_manager.dart';

class SplashScreen extends StatefulWidget {
  // const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  toNext() async{
      if (FirebaseAuth.instance.currentUser?.uid == null) {
        Navigator.pushNamed(context, AppRoutes.signInScreen);
      } else {
        final response = await FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .get();
        final bus = await FirebaseFirestore.instance
            .collection('busNumbers')
            .where('busNumber', isEqualTo: response.data()?['busNumber'])
            .get();
        print('role : ${response.data()?['role']}');

        if (response.data()?['role'] == 'Admin') {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> MainAdmin(
    imageUrl:response.data()?['imageUrl'] ,
    )));
        } else if (response.data()?['role'] == 'Student') {
          //todo change role
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeView(
                        userName: response.data()?['username'],
                        role: response.data()?['role'],
                    busNumber: response.data()?['busNumber'],
                    busId: bus.docs[0]['busId'],
                        reservationId: response.data()?['reservationId'],
                    imageUrl:response.data()?['imageUrl'] ,
                      )));
        } else if (response.data()?['role'] == 'BusDriver') {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MainBusDriver(
                        userName: response.data()?['username'],
                        role: response.data()?['role'],
                        busId: bus.docs[0]['busId'],
                        busNumber:bus.docs[0]['busNumber'] ,
                        reservationId: response.data()?['reservationId'],
                    imageUrl:response.data()?['imageUrl'] ,

                  )));
        }
      }

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppAssets.splash_logo,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Container(
            margin: EdgeInsets.only(top: 60),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [

                  Text(
                    'The British University ',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'In Egypt ',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.05 * h,
            right: 0.34 * width,
            child: TextButton(
              onPressed: (){
                toNext();
              },
              child: Text('Click here >',style: TextStyle(
color: Colors.black,fontSize: 19
              ),),
            ),
          ),

        ],
      ),
    );
  }
}
