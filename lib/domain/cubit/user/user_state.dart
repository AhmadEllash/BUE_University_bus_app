part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class GetAllUsersSuccessState extends UserState{
  List<UserModel> users;
  GetAllUsersSuccessState(this.users);
}
class GetAllUsersSFailedState extends UserState{
String errorMessage;
GetAllUsersSFailedState(this.errorMessage);
}
class GetAllUsersSLoadingState extends UserState{

}

