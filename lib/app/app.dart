import 'package:flutter/material.dart';
import '../presentation/resources/routes_manager.dart';
import '../presentation/resources/theme_manager.dart';
class MyApp extends StatefulWidget {

const MyApp._internal();
static const _instance = MyApp._internal();
factory MyApp()=>_instance;
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.splashScreen,
      onGenerateRoute: RoutesGenerator.getRoute,
      theme: getAppTheme(),
    );
  }
}
