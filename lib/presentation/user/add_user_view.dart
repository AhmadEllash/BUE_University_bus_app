import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';
import 'package:uuid/uuid.dart';

class AddUserView extends StatefulWidget {
  const AddUserView({Key? key}) : super(key: key);

  // const LoginView({Key? key}) : super(key: key);

  @override
  _AddUserViewState createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _busNumberControllerController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  String role = 'Student';
  bool imageSelected =false;
  String userId = Uuid().v4();
  File? myPickedImage;
  String? imageUrl;

  List<String> roles = ['Student', 'Admin', 'BusDriver'];
  pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageSelected = true;
      myPickedImage = File(pickedImage!.path);
    });
  }


Future<void> uploadImage(String uid) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference reference =
storage
      .ref()
      .child("user/${uid}/i");
  TaskSnapshot uploadImage = await reference.putFile(myPickedImage!);
  String url = await uploadImage.ref.getDownloadURL();
  setState(() {
    imageUrl = url;
  });
}
  Future addUser(
      String email, String password, String username, String role,String busNumber) async {
    if (_formKey.currentState!.validate()) {
      try {
       final cred =  await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email.trim(), password: password);
       await uploadImage(cred.user!.uid);

       await FirebaseFirestore.instance
            .collection('users')
            .doc(cred.user?.uid)
            .set({
          'id': cred.user?.uid,
          'email': email,
          'password': password,
          'username': username,
          'role': role,
          'isReserved':false,
          'reservationId':'',
          'busNumber':busNumber,
          'imageUrl':imageUrl,

        });
        // Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
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
      appBar: AppBar(
        title: Text('AddUser'),
        // centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        decoration:  const BoxDecoration(
          image:  DecorationImage(image :AssetImage(AppAssets.background), fit: BoxFit.cover,),
        ),
        padding: const EdgeInsets.all(AppPadding.p14),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: Image.asset(AppAssets.login_logo),
              ),
              // Container(
              //   margin: const EdgeInsets.only(top: AppMargin.m10),
              //   child: const Text(
              //     'BUE Bus Application',
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 19,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Container(
              //   margin: const EdgeInsets.only(top: AppMargin.m10),
              //   child: const Text(
              //     'Welcome',
              //     style: TextStyle(
              //         color: Colors.black,
              //         fontSize: 19,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              const SizedBox(
                height: AppSize.s22,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          // hintText: 'email',
                          labelText: 'username'),
                      controller: _usernameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter your email";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _usernameController.text = value!;
                      },
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          // hintText: 'email',
                          labelText: 'email'),
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter your email";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _emailController.text = value!;
                      },
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          // hintText: 'email',
                          labelText: 'password'),
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
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
                      height: AppSize.s10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        // hintText: 'email',
                          labelText: 'Bus Number'),
                      controller: _busNumberControllerController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter your Bus Number";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _busNumberControllerController.text = value!;
                      },
                    ),

                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Row(children: [
                      Text('File : ',style: TextStyle(
                        fontSize: 17
                      ),),
                      SizedBox(
                          // width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.grey.shade200),
                            ),
                              onPressed: () {
                                pickImage();

                              },
                              child: const Text('Choose Image',
                                  style: TextStyle(
                                    fontSize: AppSize.s14,
                                    color: Colors.black,
                                  )))),
          imageSelected== true ?   Icon(Icons.done,color: Colors.green,) : SizedBox(),

                    ],),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Row(
                      children: [
                        Text('Role'),
                        SizedBox(width: AppSize.s18,),
                        dropDownMenuButton(),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s14,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              addUser(
                                  _emailController.text,
                                  _passwordController.text,
                                  _usernameController.text,
                                  role,
                                  _busNumberControllerController.text
                              );
                             setState(() {
                               _usernameController.clear();
                               _emailController.clear();
                               _passwordController.clear();
                               role = 'Student';
                               _busNumberControllerController.clear();

                             });
                            },
                            child: const Text('Save',
                                style: TextStyle(
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

  Widget dropDownMenuButton() {
    return DropdownButton(
      value: role,
        items: roles.map((String role) {
          return DropdownMenuItem(
            value: role,
            child: Text(role,style: TextStyle(color: Colors.black),),
          );
        }).toList(),
        onChanged: (String? currentRole) {
          setState(() {
            role = currentRole!;
          });
        });
  }
}

class SignUpFunctions {
  static final auth = FirebaseAuth.instance;
  static Future signUp(String email, String password, String imageUrl) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser?.uid)
          .set({
        'id': auth.currentUser?.uid,
        'email': email,
        'password': password,
        'imageUrl': imageUrl,
      });
    } catch (e) {
      return e;
    }
  }
}
