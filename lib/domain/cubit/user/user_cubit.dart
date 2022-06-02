import 'package:bloc/bloc.dart';
import 'package:bue_university_project/domain/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  List<UserModel> allMyUsers = [];

  Future getAllUsers()async{

try{
  GetAllUsersSLoadingState();
  final users = await FirebaseFirestore.instance.collection('users').get();
  allMyUsers= users.docs.map((doc) => UserModel.fromJson(doc)).toList();

  // final finalUsers = allUsers.map((user) => user);
  print(allMyUsers.toList());

  if(allMyUsers.isEmpty) {
    GetAllUsersSFailedState('No Users');
  }else if(allMyUsers.isNotEmpty){
    print(allMyUsers);
    emit(GetAllUsersSuccessState(allMyUsers));

  }
  return allMyUsers;
}catch(e){
  GetAllUsersSFailedState(e.toString());
}
    }

  }


