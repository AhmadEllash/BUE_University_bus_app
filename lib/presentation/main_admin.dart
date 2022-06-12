import 'package:bue_university_project/presentation/resources/assets_manager.dart';
import 'package:bue_university_project/presentation/resources/routes_manager.dart';
import 'package:bue_university_project/presentation/resources/values_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class MainAdmin extends StatefulWidget {
  String ? userName;
  String ?imageUrl;
  MainAdmin({this.imageUrl,this.userName});
  @override
  _MainAdminState createState() => _MainAdminState();
}

class _MainAdminState extends State<MainAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
          decoration:  const BoxDecoration(
            image:  DecorationImage(image :AssetImage(AppAssets.background), fit: BoxFit.cover,),
          ),
          padding:  const EdgeInsets.all(AppPadding.p10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, AppRoutes.splashScreen);
                  }, child:  Icon(Icons.logout)),
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
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.getAllUsersScreen);

                      }, child: const Text('Users',style:TextStyle(
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
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.allBusesRoute);
                      }, child: const Text('Bus Numbers',style:TextStyle(
                    fontSize: AppSize.s14,
                    color: Colors.black,
                  )))),
              const SizedBox(
                height: 10,
              ),


            ],
          ),
        ),
      ),
    );

  }
}
