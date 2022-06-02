import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';

class AddBusNumberView extends StatefulWidget {
  const AddBusNumberView({Key? key}) : super(key: key);

  // const LoginView({Key? key}) : super(key: key);

  @override
  _AddBusNumberViewState createState() => _AddBusNumberViewState();
}

class _AddBusNumberViewState extends State<AddBusNumberView> {
  final TextEditingController _busNumberController = TextEditingController();
  final TextEditingController _busDestinationController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;

  String time = '4';

  List<String> times = ['4', '12', '9'];


  Future addBusNumber(
      String busNumber, String destination,String time) async {
    String busId = const Uuid().v4();

    if (_formKey.currentState!.validate()) {

      try {
        await FirebaseFirestore.instance
            .collection('busNumbers')
            .doc(busId)
            .set({
          'busId':busId,
          'busNumber':busNumber,
          'destination': destination,
          'time':time,
          'reservations':[],
        });
        // Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
      } catch (e) {
        return e.toString();
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
        title: const Text('Add BusNumber'),
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
                          labelText: 'busNumber'),
                      controller: _busNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter bus number";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _busNumberController.text = value!;
                      },
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        // hintText: 'email',
                          labelText: 'Start From'),
                      controller: _busDestinationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter bus destination";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        _busDestinationController.text = value!;
                      },
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    dropDownMenuButton(),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    const SizedBox(
                      height: AppSize.s14,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              addBusNumber(
                                  _busNumberController.text,
                                  _busDestinationController.text,
                                time,
                                  );
                              setState(() {
                                _busNumberController.clear();
                                _busDestinationController.clear();


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
        value: time,
        items: times.map((String time) {
          return DropdownMenuItem(
            value: time,
            child: Text(time,style: TextStyle(color: Colors.black),),
          );
        }).toList(),
        onChanged: (String? currentTime) {
          setState(() {
            time = currentTime!;
          });
        });
  }
}

