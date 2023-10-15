import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wforcastapp/View/splishscreen/splishscreenfour.dart';
import 'package:wforcastapp/View/splishscreen/splishscreenthree.dart';
import 'package:wforcastapp/controller/getcontroller.dart';



class SplishScreenTwo extends StatefulWidget {
  const SplishScreenTwo({Key? key}) : super(key: key);

  @override
  State<SplishScreenTwo> createState() => _SplishScreenTwoState();
}

class _SplishScreenTwoState extends State<SplishScreenTwo> {
  @override

final Mycontroller mycontroller=Get.put(Mycontroller());

  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/screentwo.jpg'), fit: BoxFit.fill)),
        child: Column(
          children: [

            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: (){
                mycontroller.skipNavgation();
                },

                child: Container(
                  height: 150,
                  width: 150,
                  color: Colors.transparent,
                ),
              ),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: (){
                  mycontroller.secondNavigation();
                },

                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
