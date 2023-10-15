
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wforcastapp/View/homescreen/homescreen.dart';

import 'package:wforcastapp/controller/getcontroller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SearchScreen extends StatefulWidget {
  var  temp;
  var  minT;
  var  maxT;
  var  sunR;
  var sunset;
  var appbar;
  var humidityy;
  var airsped;
  var img;

   SearchScreen({Key? key,
  required this.temp,
     required this.img,
  required this.maxT,
  required this.minT,
  required this.sunR,
     required this.appbar,
     required this.humidityy,
     required this.airsped,
     required this.sunset





  }) : super(key: key);
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Mycontroller weatherController = Get.put(Mycontroller());



  @override

  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,


        title: Text(widget.appbar),
      ),
      body:Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),


            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: SizedBox(
                    child: GridView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5),
                      children: <Widget>[
                         customContainer(
img: 'https://openweathermap.org/img/wn/${widget.img}@2x.png',

                            lable: 'Temperature', color: Colors.black, data:widget.temp ),

                          customContainer(
                            lable: 'MaxTemperature', color: Colors.red, data:widget.maxT ),

                          customContainer(
                            lable: 'MinTemperature', color: Colors.red, data:widget.minT ),

                         customContainer(
                            lable: 'Humidity', color: Colors.red, data:widget.humidityy ),

                        customContainer(
                            lable: 'Air Speed', color: Colors.red, data:widget.airsped ),

                         customContainer(
                            lable: 'SunRise', color: Colors.red, data:widget.sunR ),

                         customContainer(
                            lable: 'SunSet', color: Colors.red, data:widget.sunset ),







                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){

                Get.to(HomeScreen());

              },
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 7),
                    )
                  ],
                  borderRadius: BorderRadius.circular(5),

                  color: Colors.red,
                ),
                child: Center(child: Text('HomeScreen',style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),)),
              ),
            )
          ],
        ),
      ),


















      //


      // Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     // Use Text widgets to display weather data
      //     _buildWeatherInfo(label: 'Temperature', data: widget.temp, color: Colors.blue),
      //     _buildWeatherInfo(label: 'Min Temperature', data: widget.minT, color: Colors.green),
      //     _buildWeatherInfo(label: 'Max Temperature', data: widget.maxT, color: Colors.red),
      //     _buildWeatherInfo(label: 'Sunrise', data: widget.sunR, color: Colors.blue),
      //
      //     ElevatedButton(
      //         style: ElevatedButton.styleFrom(
      //
      //           padding: EdgeInsets.symmetric(horizontal: 100 ,vertical: 35)
      //
      //
      //
      //         ),
      //
      //         onPressed: (){
      //
      //           Get.to(HomeScreenOne());
      //         }, child: Text('Go To Home'))
      //
      //   ],
      // ),
    );
  }

  Widget _buildWeatherInfo({
    required String label,
    required String data,
    required Color color,
    String? img
  }) {
    return Container(
      width: 300,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          if(img !=null)
            Image.network(img),
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            data,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}






Widget customContainer({
  required String lable,
  required String data,
  required Color color,
  String? img
}) {
  return Container(
    height: 40,
    width: 40,
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: Colors.black, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 10,
            offset: Offset(0, 7),
          )
        ]
    ),
    child: Column(
      children: [
        if (img != null) // Conditionally add the image if it's provided
          Image.network(img),
        Text(
          lable,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white, // You can customize the text color here
          ),
        ),
        SizedBox(height: 8),
        Text(
          data,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white, // You can customize the text color here
          ),
        ),
      ],
    ),
  );
}
