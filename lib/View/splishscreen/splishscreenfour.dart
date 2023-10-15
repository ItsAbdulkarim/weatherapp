import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wforcastapp/View/splishscreen/splishscreenfive.dart';
import 'package:wforcastapp/controller/getcontroller.dart';



class SplishScreenfour extends StatefulWidget {
  const SplishScreenfour({Key? key}) : super(key: key);

  @override
  State<SplishScreenfour> createState() => _SplishScreenfourState();
}

class _SplishScreenfourState extends State<SplishScreenfour> {

 Mycontroller mmm=Get.put(Mycontroller());


  @override


  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/screenfour.jpg'), fit: BoxFit.fill)),
        child: Column(
          children: [

            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: (){
                  mmm..skipNavgation();
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
                mmm.forthNavigation();
                  print('hello');
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
