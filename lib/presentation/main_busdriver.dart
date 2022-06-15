import 'package:bue_university_project/presentation/google_maps/google_maps_screen10.dart';
import 'package:bue_university_project/presentation/google_maps/google_maps_screen4.dart';
import 'package:bue_university_project/presentation/google_maps/google_maps_screen5.dart';
import 'package:bue_university_project/presentation/google_maps/google_maps_screen6.dart';
import 'package:bue_university_project/presentation/google_maps/google_maps_screen7.dart';
import 'package:bue_university_project/presentation/google_maps/google_maps_screen8.dart';
import 'package:bue_university_project/presentation/google_maps/google_maps_screen9.dart';
import 'package:bue_university_project/presentation/qr_code.dart';
import 'package:bue_university_project/presentation/reservation_history.dart';
import 'package:bue_university_project/presentation/resources/routes_manager.dart';
import 'package:bue_university_project/presentation/resources/values_manager.dart';
import 'package:bue_university_project/reservation_list_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'resources/assets_manager.dart';
class MainBusDriver extends StatefulWidget {
  // const HomeView({Key? key}) : super(key: key);
  String ?userName;
  String ?role;
  String ?busId;
  String? reservationId;
  String?imageUrl;
  String ? busNumber;
  MainBusDriver({this.userName,this.role,this.busId,this.reservationId,this.imageUrl,this.busNumber});
  @override
  _MainBusDriverState createState() => _MainBusDriverState();
}

class _MainBusDriverState extends State<MainBusDriver> {
  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:  Text(value)
    ));
  }

  @override
  void initState() {
    // getUser();
    super.initState();

  }
  @override
  void dispose() {
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration:  const BoxDecoration(
            image:  DecorationImage(image :AssetImage(AppAssets.background), fit: BoxFit.cover,),
          ),
          padding: const EdgeInsets.all(AppPadding.p10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, AppRoutes.splashScreen);
                  }, child: Icon(Icons.logout)),
                  Column(
                    children:  [
                      Text(widget.userName ?? "",style: TextStyle(fontSize: 15),),
                    ],
                  ),
                  // const SizedBox(
                  //   width: AppSize.s20,
                  // ),
                  widget.imageUrl != null ? Image.network(widget.imageUrl!,height: 50,width: 50,) :  Icon(Icons.person),

                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset(AppAssets.login_logo),
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.black)
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ReservationListView(
                         busId: widget.busId,
                        )));

                      }, child: const Text('Reservation List',style:TextStyle(
                    fontSize: AppSize.s14,
                    color: Colors.green,
                  )))),
              const SizedBox(
                height: 10,
              ),
              // SizedBox(
              //     width: double.infinity,
              //     height: 50,
              //     child: ElevatedButton(
              //         style: ButtonStyle(
              //             backgroundColor: MaterialStateProperty.all(Colors.blue)
              //         ),
              //         onPressed: () {
              //           Navigator.push(context, MaterialPageRoute(builder: (context)=>ReservationListView(
              //             busId: widget.busId,
              //           )));
              //           // signUp(_emailController.text, _passwordController.text);
              //         }, child: const Text('Reservation History',style:TextStyle(
              //       fontSize: AppSize.s14,
              //       color: Colors.black,
              //     )))),
              // const SizedBox(
              //   height: 10,
              // ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue)
                      ),
                      onPressed: () {
                    if(widget.busNumber == '101'){
                      Navigator.pushNamed(context, AppRoutes.googleMap);
                    }else if(widget.busNumber == '102'){
                      Navigator.pushNamed(context, AppRoutes.googleMapScreenTwo);
                    }else if (widget.busNumber == '103'){
                      Navigator.pushNamed(context, AppRoutes.googleMapScreenThere);
                    }
                    else if (widget.busNumber == '104'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GoogleMapScreenFour()));
                    }else if (widget.busNumber == '105'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GoogleMapScreenFive()));

                    }else if (widget.busNumber == '106'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GoogleMapScreenSix()));

                    }else if (widget.busNumber == '107'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GoogleMapScreenSeven()));

                    }else if (widget.busNumber == '108'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GoogleMapScreenEight()));

                    }
                    else if (widget.busNumber == '109'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GoogleMapScreenNine()));

                    }else if (widget.busNumber == '110'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>GoogleMapScreenTen()));

                    }

                      }, child: const Text('Routes',style:TextStyle(
                    fontSize: AppSize.s14,
                    color: Colors.black,
                  )))),

              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.black),
                      ),
                      onPressed: () {
showInSnackBar("The Trip is started Successfully");

                      }, child: const Text('Start Trip',style:TextStyle(
                    fontSize: AppSize.s14,
                    color: Colors.red,
                  )))),

            ],
          ),
        ),
      ),
    );
  }

}
