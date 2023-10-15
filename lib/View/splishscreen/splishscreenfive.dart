import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../homescreen/homescreen.dart';

class SplishScreenfive extends StatelessWidget {
  const SplishScreenfive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/screenfive.jpg'), fit: BoxFit.fill)),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Get.to(HomeScreen());
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
                onTap: () {
                  Get.to(HomeScreen());
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
