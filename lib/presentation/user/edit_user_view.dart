import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';

class EditUserView extends StatefulWidget {
  final String ?id;
 final String? email;
 final String? password;
 final String? userName;
 final String? role;
EditUserView({this.id,this.userName,this.email,this.password,this.role});
  // const LoginView({Key? key}) : super(key: key);

  @override
  _EditUserViewState createState() => _EditUserViewState();
}

class _EditUserViewState extends State<EditUserView> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content:  Text(value)
    ));
  }

  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  String? role ;

  List<String> roles = ['Student', 'Admin', 'BusDriver'];

  Future editUser(
      String email, String password, String username, String role) async {
    if (_formKey.currentState!.validate()) {
      try {

        await FirebaseFirestore.instance
            .collection('users')
            .doc(widget.id)
            .update({
          'id': widget.id,
          'email': email,
          'password': password,
          'username': username,
          'role': role,
        });
        showInSnackBar('User updated successfully');
        // Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
      } catch (e) {
        return e.toString();
      }
    }
  }
  @override
  void initState() {
    super.initState();
    _usernameController.text = widget.userName!;
    _passwordController.text = widget.password!;
    _emailController.text = widget.email!;
    role = widget.role;

  }

  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text('EditUser'),
        centerTitle: true,
      ),
      body: Container(
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
                      readOnly: true,
                      // textInputAction: TextInputAction,
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
                      readOnly: true,
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
                              editUser(
                                  _emailController.text,
                                  _passwordController.text,
                                  _usernameController.text,
                                  role!);
                              setState(() {
                                _usernameController.clear();
                                _emailController.clear();
                                _passwordController.clear();
                                role = 'Student';
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
        value: widget.role,
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
