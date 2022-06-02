import 'package:bue_university_project/presentation/qr_code.dart';
import 'package:bue_university_project/presentation/resources/routes_manager.dart';
import 'package:bue_university_project/presentation/resources/values_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import 'resources/assets_manager.dart';
class HomeView extends StatefulWidget {
  // const HomeView({Key? key}) : super(key: key);
  String ?userName;
  String ?role;
  String ?busId;
  String? reservationId;
  String ? imageUrl;
  String ? busNumber;

  HomeView({this.userName,this.role,this.busId,this.reservationId,this.imageUrl,this.busNumber});
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
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
                    Text(FirebaseAuth.instance.currentUser!.email!,style: TextStyle(fontSize: 15),),
                    Text(FirebaseAuth.instance.currentUser!.uid,style: TextStyle(fontSize: 10),),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>QRReaderView(
                        uid: FirebaseAuth.instance.currentUser?.uid,
                        userName: widget.userName,
                        busId: widget.busId,
                      )));

                    }, child: const Text('Scan QR Code',style:TextStyle(
                  fontSize: AppSize.s14,
                  color: Colors.green,
                )))),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue)
                  ),
                    onPressed: () {

                      // signUp(_emailController.text, _passwordController.text);
                    }, child: const Text('Bus Numbers',style:TextStyle(
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
                        backgroundColor: MaterialStateProperty.all(Colors.blue)
                    ),
                    onPressed: () {

                      if(widget.busNumber == '101'){
                        Navigator.pushNamed(context, AppRoutes.googleMap);
                      }else if(widget.busNumber == '102'){
                        Navigator.pushNamed(context, AppRoutes.googleMapScreenTwo);
                      }else{
                        Navigator.pushNamed(context, AppRoutes.googleMapScreenThere);

                      }
                    }, child: const Text('Bus Routes',style:TextStyle(
                  fontSize: AppSize.s14,
                  color: Colors.black,
                )))),

            const SizedBox(
              height: 80,
            ),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                    onPressed: () async{
                      try{
                        await FirebaseFirestore.instance.collection('busNumbers').doc(widget.busId).collection('reservations').doc(widget.reservationId).delete();

                        await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).update(
                            {
                              'reservationId':'',
                              'isReserved':false,

                            });
                        showInSnackBar('your reservation is canceled successfully');

                      }catch(e){
                        e.toString();
                      }
                    }, child: const Text('Cancel Reservation',style:TextStyle(
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
