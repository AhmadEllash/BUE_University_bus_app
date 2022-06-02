import 'package:bloc/bloc.dart';
import 'package:bue_university_project/domain/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'reservations_state.dart';

class ReservationsCubit extends Cubit<ReservationsState> {
  ReservationsCubit() : super(ReservationsInitial());
  List<ReservationModel> allReservations = [];

  // Future getAllReservations()async{
  //
  //   try{
  //     GetAllBusesLoadingState();
  //     final response = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).get();
  //
  //     final bus = await FirebaseFirestore.instance.collection('busNumbers').where('busNumber' , isEqualTo:response.data()?['busNumber']).get();
  //     final reservations =  FirebaseFirestore.instance.collection('busNumbers').doc(bus.docs[0]['busId']).collection('reservations').doc().get();
  //
  //     allReservations= reservations.then((doc) => ReservationModel.fromJson(doc)).toList();
  //
  //     // final finalUsers = allUsers.map((user) => user);
  //     print(allReservations.toList());
  //
  //     if(allReservations.isEmpty) {
  //       GetAllBusesFailedState('No Buses');
  //     }else if(allBuses.isNotEmpty){
  //       print(allBuses);
  //       emit(GetAllBusesSuccessState(allBuses));
  //
  //     }
  //     return allBuses;
  //   }catch(e){
  //     GetAllBusesFailedState(e.toString());
  //   }
  // }

}
