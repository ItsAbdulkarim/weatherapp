import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wforcastapp/View/splishscreen/splishscreentwo.dart';

class SplishScreenOne extends StatefulWidget {
  const SplishScreenOne({Key? key}) : super(key: key);

  @override
  State<SplishScreenOne> createState() => _SplishScreenOneState();
}

class _SplishScreenOneState extends State<SplishScreenOne> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () {
Get.offAll(SplishScreenTwo());



    });
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/firstscreen.jpg')
          , fit: BoxFit.cover
          )


        ),
      ),
    );
  }
}
