import 'package:bloc/bloc.dart';
import 'package:bue_university_project/domain/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'bus_state.dart';

class BusCubit extends Cubit<BusState> {
  BusCubit() : super(BusInitial());
  List<BusModel> allBuses = [];

  Future getAllBuses()async{

    try{
      GetAllBusesLoadingState();
      final buses = await FirebaseFirestore.instance.collection('busNumbers').get();
      allBuses= buses.docs.map((doc) => BusModel.fromJson(doc)).toList();

      // final finalUsers = allUsers.map((user) => user);
      print(allBuses.toList());

      if(allBuses.isEmpty) {
        GetAllBusesFailedState('No Buses');
      }else if(allBuses.isNotEmpty){
        print(allBuses);
        emit(GetAllBusesSuccessState(allBuses));

      }
      return allBuses;
    }catch(e){
      GetAllBusesFailedState(e.toString());
    }
  }
}
