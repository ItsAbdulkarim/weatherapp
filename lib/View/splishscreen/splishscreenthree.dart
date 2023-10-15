import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wforcastapp/View/splishscreen/splishscreenfour.dart';
import 'package:wforcastapp/controller/getcontroller.dart';



class SplishScreenThree extends StatefulWidget {
  const SplishScreenThree({Key? key}) : super(key: key);

  @override
  State<SplishScreenThree> createState() => _SplishScreenThreeState();
}

class _SplishScreenThreeState extends State<SplishScreenThree> {
  @override

final Mycontroller mmm=Get.put(Mycontroller());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/screenthree.jpg'), fit: BoxFit.fill)),
        child: Column(
          children: [

            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: (){
mmm.skipNavgation();
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
                onTap: (){mmm.thirdNavigation();


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
