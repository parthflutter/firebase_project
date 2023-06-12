import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'admin_side/view/SignIn.dart';
import 'admin_side/view/SignUp.dart';
import 'admin_side/view/home_screen.dart';
import 'admin_side/view/second screen.dart';
import 'admin_side/view/splash_screen.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
      runApp(
    Sizer(
      builder: (context, orientation, deviceType) =>
    GetMaterialApp(
    debugShowCheckedModeBanner: false,
      getPages: [
       GetPage(name: '/', page: () => Splash_screen()),
        GetPage(name: '/In', page: () => SignIn(),),
        GetPage(name: '/up', page: () => SignUp(),),
        GetPage(name: '/home', page: () => Home_screen(),),
        GetPage(name: '/second', page: () => second_screen(),),
      ],
  ),
    ),
  );
}

