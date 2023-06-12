import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ulitis/fbhelper_dart.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> {
  bool? isLogin;
  @override
  void initState() {
    super.initState();
    isLogin = Firebasehelper.fireHelper.checkUser();
  }
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () {Get.toNamed(isLogin!?'home':'In');});
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Container(
                  height: 200,
                  width: 200,
                ),
                Image.asset("assets/images/ecommerce.jpg"),
              ],
            ),
          )
      ),
    );
  }
}

