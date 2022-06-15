import 'package:bue_university_project/domain/cubit/buses/bus_cubit.dart';
import 'package:bue_university_project/domain/cubit/user/user_cubit.dart';
import 'package:bue_university_project/presentation/google_maps/google_maps_screen.dart';
import 'package:bue_university_project/presentation/bus_numbers/add_busNumbers.dart';
import 'package:bue_university_project/presentation/bus_numbers/all_bus_numbers.dart';
import 'package:bue_university_project/presentation/bus_numbers/edit_bus_number.dart';
import 'package:bue_university_project/presentation/bus_numbers_student.dart';
import 'package:bue_university_project/presentation/bus_recorder.dart';
import 'package:bue_university_project/presentation/google_maps/google_maps_screen2.dart';
import 'package:bue_university_project/presentation/google_maps/google_maps_screen3.dart';
import 'package:bue_university_project/presentation/main_busdriver.dart';
import 'package:bue_university_project/presentation/main_student.dart';
import 'package:bue_university_project/presentation/login/login_view.dart';
import 'package:bue_university_project/presentation/main_admin.dart';
import 'package:bue_university_project/presentation/reservation_history.dart';
import 'package:bue_university_project/presentation/signup_screen.dart';
import 'package:bue_university_project/presentation/user/add_user_view.dart';
import 'package:bue_university_project/presentation/user/all_users_view.dart';
import 'package:bue_university_project/reservation_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splashScreen';
  static const String addUserScreen = '/addUserScreen';
  static const String signInScreen = '/signInScreen';
  static const String homeScreen = '/homeScreen';
  static const String addReservationScreen = '/addReservationScreen';
  static const String reservationScreen = '/ReservationScreen';
  static const String busRecorder = '/busRecorder';
  static const String getAllUsersScreen = '/getAllUsersScreen';
  static const String googleMap = '/googleMap';
  static const String mainAdmin = '/mainAdmin';
  static const String mainBusDriver = '/mainBusDriver';
  static const String allBusesRoute = '/allBusesRoute';
  static const String addBusRoute = '/addBusRoute';
  static const String editBusRoute = '/editBusRoute';
  static const String allBusesStudent = '/allBusesStudent';
  static const String googleMapScreenTwo = '/googleMapScreenTwo';
  static const String googleMapScreenThere = '/googleMapScreenThere';







}

class RoutesGenerator {

  static Route<dynamic> ? getRoute(RouteSettings route) {
    switch (route.name) {
      case AppRoutes.splashScreen :
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case AppRoutes.signInScreen :
        return MaterialPageRoute(builder: (context) => LoginView());
      case AppRoutes.homeScreen :
        return MaterialPageRoute(builder: (context) => HomeView());
      case AppRoutes.addUserScreen :
        return MaterialPageRoute(builder: (context) => const AddUserView());

      case AppRoutes.reservationScreen :
        return MaterialPageRoute(builder: (context) => ReservationView());
      case AppRoutes.busRecorder :
        return MaterialPageRoute(builder: (context) => BusRecorder());
      case AppRoutes.getAllUsersScreen :
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(
              create: (context) => UserCubit(),
              child: AllUsersView(),
            ));
      case AppRoutes.allBusesRoute :
        return MaterialPageRoute(builder: (context) =>
            BlocProvider(
              create: (context) => BusCubit(),
              child: AllBusView(),
            ));
      case AppRoutes.googleMap :
        return MaterialPageRoute(builder: (context) => GoogleMapScreen());
      case AppRoutes.mainAdmin :
        return MaterialPageRoute(builder: (context) =>  MainAdmin());
      case AppRoutes.addBusRoute :
        return MaterialPageRoute(builder: (context) => const AddBusNumberView());
      case AppRoutes.editBusRoute :
        return MaterialPageRoute(builder: (context) =>  EditBusNumberView());
      case AppRoutes.allBusesStudent :
        return MaterialPageRoute(builder: (context) =>   BlocProvider(
          create: (context) => BusCubit(),
          child: AllBusStudentView(),
        ));
      case AppRoutes.mainBusDriver :
        return MaterialPageRoute(builder: (context) =>  MainBusDriver());
      case AppRoutes.googleMapScreenThere :
        return MaterialPageRoute(builder: (context) =>  GoogleMapScreenthree());
        case AppRoutes.googleMapScreenTwo :
      return MaterialPageRoute(builder: (context) =>  GoogleMapScreenTwo());
        // googleMapScreenThere
    }
  }
}