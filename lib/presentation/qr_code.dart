import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:uuid/uuid.dart';
class QRReaderView extends StatefulWidget {
String? uid;
String ?userName;
String ?busId;
QRReaderView({this.uid,this.userName,this.busId});
  @override
  _QRReaderViewState createState() => _QRReaderViewState();
}


class _QRReaderViewState extends State<QRReaderView> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final reservationId =const Uuid().v4();

  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }
  Future confirm( )async {
    try {
      await FirebaseFirestore.instance.collection('busNumbers').doc(widget.busId).collection('reservations').doc(reservationId).set(
          {
            'reservationId':reservationId,
            'uid': widget.uid,
            'userName': widget.userName,
            'date': DateTime.now(),

      });
      await FirebaseFirestore.instance.collection('users').doc(widget.uid).update(
          {
            'reservationId':reservationId,
            'isReserved':true,

          });
      // Navigator.pushReplacementNamed(context, AppRoutes.homeScreen);
    } catch (e) {
      return 'something went wrong.Please try again later';
    }


  }
   _onQRViewCreated(QRViewController controller ) async{
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        confirm();

  });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ?  Text(
                'you have Successfully Reserved')
                //   'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : Text('Scan Bus code'),
            ),
          ),

        ],
      ),
    );
  }



  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}