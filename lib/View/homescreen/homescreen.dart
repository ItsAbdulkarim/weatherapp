import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:wforcastapp/controller/getcontroller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  Mycontroller mycontroller=Get.put(Mycontroller());



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

mycontroller.getWeatherByDeviceLocation();


  }




  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/background.jpg'), fit: BoxFit.fill)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Obx(() => mycontroller.isLoading.value?Container(

            height: double.infinity,
            width: double.infinity,

            decoration: BoxDecoration(

                color: Colors.white54


            ),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset('images/secondsun.png'),




                SpinKitThreeInOut(
                  color: Colors.black,
                  size: 50.0,
                ),
              ],
            ),
          ): Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: Offset(0, 7),
                        )
                      ]

                  ),
                  // Customize the background color
                  child: TextField(
                    controller: mycontroller.searchcontroller.value,
                    decoration: InputDecoration(
                      prefixIcon: InkWell(
                          onTap: (){

                            mycontroller.getApiData();



                          },



                          child: Icon(Icons.send)),
                      hintText: 'Search...',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(width: 2)),
                    ),
                  ),
                ),
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
                            Obx(() =>  customContainer(
                                lable: 'Temperature',
                                img: 'https://openweathermap.org/img/wn/${mycontroller.iconn.value}@2x.png',


                                color: Colors.black, data:mycontroller.temperature.value ),
                            ),
                            Obx(() =>  customContainer(
                                lable: 'MaxTemperature', color: Colors.red, data:mycontroller.maxTemp.value ),
                            ),
                            Obx(() =>  customContainer(
                                lable: 'MinTemperature', color: Colors.red, data:mycontroller.minTemp.value ),
                            ),
                            Obx(() =>  customContainer(
                                lable: 'Humidity', color: Colors.red, data:mycontroller.humidity.value ),
                            ),
                            Obx(() =>  customContainer(
                                lable: 'Air Speed', color: Colors.red, data:mycontroller.airspeed.value ),
                            ),
                            Obx(() =>  customContainer(
                                lable: 'SunRise', color: Colors.red, data:mycontroller.sunrise.value ),
                            ),
                            Obx(() =>  customContainer(
                                lable: 'SunSet', color: Colors.red, data:mycontroller.sunsett.value ),
                            ),






                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          ),





        ),
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



