import 'package:bue_university_project/presentation/main_admin.dart';
import 'package:bue_university_project/presentation/main_busdriver.dart';
import 'package:bue_university_project/presentation/main_student.dart';
import 'package:bue_university_project/presentation/resources/routes_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../resources/assets_manager.dart';
import '../resources/values_manager.dart';

class LoginView extends StatefulWidget {
  // const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future login(String email , String password)async {
    if(_formKey.currentState!.validate()){
      try {
      // await FirebaseAuth.instance.signInWithEmailAndPassword(
      //       email: email, password: password);
      final cred =   await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email.trim(), password: password);
        final response = await FirebaseFirestore.instance
            .collection('users')
            .doc(cred.user?.uid)
            .get();
        final bus = await FirebaseFirestore.instance
            .collection('busNumbers')
            .where('busNumber', isEqualTo: response.data()?['busNumber'])
            .get();

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
                    busId: bus.docs[0]['busId'],
                    busNumber:bus.docs[0]['busNumber'] ,
                    reservationId: response.data()?['reservationId'],
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
                  )));
        }      } catch (e) {
        return 'username or password is invalid.';
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return _getContentScreen(context);
  }

  Widget _getContentScreen(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration:  const BoxDecoration(
          image:  DecorationImage(image :AssetImage(AppAssets.background), fit: BoxFit.cover,),
        ),
        padding: const EdgeInsets.all(AppPadding.p14),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  margin: const EdgeInsets.only(top: 0),
                  child: Image.asset(AppAssets.login_logo),
                ),
                Container(
                  margin: const EdgeInsets.only(top: AppMargin.m10),
                  child: const Text('BUE Bus Application',style: TextStyle(color: Colors.black,fontSize: 19,fontWeight:FontWeight.bold),),
                ),
                Container(
                  margin: const EdgeInsets.only(top: AppMargin.m10),
                  child: const Text('Welcome',style: TextStyle(color: Colors.black,fontSize: 19,fontWeight:FontWeight.bold),),
                ),
                const SizedBox(
                  height: AppSize.s22,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration:const  InputDecoration(
                          // hintText: 'email',
                          labelText: 'email'
                        ),
                        controller: _userNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty ) {
                            return "Please Enter your username";
                          }
                            return null;

                        },
                        onSaved: (value) {
                          _userNameController.text = value!;
                        }
                      ),
                      const SizedBox(
                        height: AppSize.s10,
                      ),
                      TextFormField(
                        decoration:const  InputDecoration(
                            labelText: 'password'
                        ),
                        controller: _passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty  ) {
                            return "Please Enter your password";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _passwordController.text = value!;
                        },
                      ),
                      const SizedBox(
                        height:AppSize.s14,
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                            login(_userNameController.text, _passwordController.text);
                              }, child: const Text('Login',style:TextStyle(
                            fontSize: AppSize.s14,
                            color: Colors.black,
                          )))),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s22,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text('Doesn\'t have an account?'),
                //     TextButton(onPressed: (){
                //       Navigator.pushReplacementNamed(context, AppRoutes.signUpScreen);
                //
                //     }, child: Text('SignUp'))
                //
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginFunctions {
  static Future login(String email , String password,BuildContext context)async{
    try{
       await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
       Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);

    }catch(e){
      return 'username or password is invalid.';
    }
  }
}
