import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'resources/assets_manager.dart';
import 'resources/routes_manager.dart';
import 'resources/values_manager.dart';

class SignUpView extends StatefulWidget {
  // const LoginView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _emailController = TextEditingController();
 final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
   final auth = FirebaseAuth.instance;

  Future signUp(String email , String password)async {
    if(_formKey.currentState!.validate()){
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseFirestore.instance.collection('users').doc(auth.currentUser?.uid).set({
          'id':auth.currentUser?.uid,
          'email':email,
          'password':password,

        });
        Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
      } catch (e) {
        return 'username or password is invalid.';
      }
    }

  }
  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(AppPadding.p14),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 80),
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
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty ) {
                          return "Please Enter your email";
                        } else {
                          return null;
                        }

                      },
                      onSaved: (value){
                        _emailController.text = value!;

                      },
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    TextFormField(
                      decoration:const  InputDecoration(
                        // hintText: 'email',
                          labelText: 'password'
                      ),
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty  ) {
                          return "Please Enter your password";
                        } else {
                          return null;
                        }
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
                              signUp(_emailController.text, _passwordController.text);
                            }, child: const Text('SignUp',style:TextStyle(
                          fontSize: AppSize.s14,
                          color: Colors.black,
                        )))),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpFunctions {
  static final auth = FirebaseAuth.instance;
  static Future signUp(String email , String password,String imageUrl)async{
    try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseFirestore.instance.collection('users').doc(auth.currentUser?.uid).set({
          'id':auth.currentUser?.uid,
          'email':email,
          'password':password,
          'imageUrl':imageUrl,
        });
    }catch(e){
      return e;
    }
  }
}
