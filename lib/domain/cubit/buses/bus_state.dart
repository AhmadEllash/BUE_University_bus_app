part of 'bus_cubit.dart';

@immutable
abstract class BusState {}

class BusInitial extends BusState {}

class GetAllBusesSuccessState extends BusState{
  List<BusModel> buses;
  GetAllBusesSuccessState(this.buses);
}
class GetAllBusesFailedState extends BusState{
  String errorMessage;
  GetAllBusesFailedState(this.errorMessage);
}
class GetAllBusesLoadingState extends BusState{

}