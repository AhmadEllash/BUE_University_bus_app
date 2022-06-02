import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String ? uid;
  String ? username;
  String ? email;
  String ? password;
  String ? role;
  String ? busNumber;
  bool ?isReserved;
  String ? reservationId;
  String? imageUrl;

  UserModel({this.uid,this.username,this.email,this.password,this.role,this.busNumber,this.reservationId,this.isReserved,this.imageUrl});

  UserModel.fromJson(DocumentSnapshot snapshot) {
    uid = snapshot['id'];
    username = snapshot['username'];
    email = snapshot['email'];
    password = snapshot['password'];
    role = snapshot['role'];
    busNumber = snapshot['busNumber'] ?? {} ;
    isReserved = snapshot['isReserved'];
    reservationId = snapshot['reservationId'];
    imageUrl = snapshot['imageUrl'];

  }
}

class BusModel{
  String ? busId;
  String ? busNumber;
  String ? destination;
  String ? time;

  BusModel({this.busId,this.busNumber,this.destination,this.time});

  BusModel.fromJson(DocumentSnapshot snapshot) {
    busId = snapshot['busId'];
    busNumber = snapshot['busNumber'];
    destination = snapshot['destination'];
    time = snapshot['time'];

  }
}
class ReservationModel{
  String ? uid;
  String ? reservationId;
  String ? userName;
  Timestamp ? date;

  ReservationModel({this.uid,this.reservationId,this.userName,this.date});

  ReservationModel.fromJson(DocumentSnapshot snapshot) {
    uid = snapshot['uid'];
    reservationId = snapshot['reservationId'];
    userName = snapshot['userName'];
    date = snapshot['date'];

  }
}