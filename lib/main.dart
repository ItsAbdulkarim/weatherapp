import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:wforcastapp/View/splishscreen/splishscreenone.dart';
import 'package:wforcastapp/View/splishscreen/splishscreentwo.dart';

import 'View/homescreen/homescreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplishScreenOne(),
    );
  }
}