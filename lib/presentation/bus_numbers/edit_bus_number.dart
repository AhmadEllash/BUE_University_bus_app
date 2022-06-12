import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../resources/assets_manager.dart';
import '../resources/routes_manager.dart';
import '../resources/values_manager.dart';

class EditBusNumberView extends StatefulWidget {
  final String? busNumber;
  final String? destination;
  final String? time;
  EditBusNumberView({this.busNumber,this.destination,this.time});
  // const LoginView({Key? key}) : super(key: key);

  @override
  _EditBusNumberViewState createState() => _EditBusNumberViewState();
}

class _EditBusNumberViewState extends State<EditBusNumberView> {
  final TextEditingController _busNumberController = TextEditingController();
  final TextEditingController _busDestinationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(
        content:  Text(value)
    ));
  }
  String time = '4';

  List<String> times = ['4', '12', '9'];


  Future editBusNumber(
      String busNumber, String destination, String time) async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance
            .collection('busNumbers')
            .doc()
            .update({
          'busNumber':busNumber,
          'destination': destination,
          'time':time,
        });
        showInSnackBar('Bus updated successfully');
        // Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
      } catch (e) {
        return e.toString();
      }
    }
  }
  @override
  void initState() {
    super.initState();
    _busNumberController.text = widget.busNumber!;
    _busDestinationController.text = widget.destination!;
    time = widget.time!;

  }

  @override
  Widget build(BuildContext context) {
    return _getContentScreen();
  }

  Widget _getContentScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Bus'),
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
                          labelText: 'Bus Number'),
                      controller: _busNumberController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Bus Number";
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
                      // textInputAction: TextInputAction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Bus Destination";
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

                    SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                            onPressed: () {
                              editBusNumber(
                                  _busNumberController.text,
                                  _busDestinationController.text,
                                time,
                                  );
                              setState(() {
                                _busNumberController.clear();
                                _busDestinationController.clear();

                              });
                            },
                            child: const Text('Update',
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
        value: widget.time,
        items: times.map((String time) {
          return DropdownMenuItem(
            value: time,
            child: Text(time,style: TextStyle(color: Colors.black),),
          );
        }).toList(),
        onChanged: (String? currentTime) {
          setState(() {
            time = currentTime!;
            print(time);
          });
        });
  }

}


