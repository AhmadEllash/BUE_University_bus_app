part of 'reservations_cubit.dart';

@immutable
abstract class ReservationsState {}

class ReservationsInitial extends ReservationsState {}
class GetAllReservationsSuccessState extends ReservationsState{
  List<ReservationModel> reservations;
  GetAllReservationsSuccessState(this.reservations);
}
class GetAllReservationsFailedState extends ReservationsState{
  String errorMessage;
  GetAllReservationsFailedState(this.errorMessage);
}
class GetAllReservationsLoadingState extends ReservationsState{

}