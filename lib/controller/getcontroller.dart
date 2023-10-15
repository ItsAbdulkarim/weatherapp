import 'dart:convert';
import 'dart:ffi';
import 'package:geolocator/geolocator.dart';


import 'package:flutter/material.dart';


import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wforcastapp/View/homescreen/seachscreen.dart';
import 'package:wforcastapp/View/splishscreen/splishscreenfive.dart';
import 'package:wforcastapp/View/splishscreen/splishscreenfour.dart';
import 'package:wforcastapp/View/splishscreen/splishscreenthree.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../View/homescreen/homescreen.dart';


class Mycontroller extends GetxController {
  Rx<TextEditingController> searchcontroller = TextEditingController().obs;
  var temperature = ''.obs;
  var minTemp = "".obs;

  var maxTemp = ''.obs;
  var descriptonn = ''.obs;
  var humidity = "".obs;
  var sunrise = ''.obs;
  var sunsett = ''.obs;
  var airspeed = ''.obs;
  RxBool isLoading = false.obs;

  var iconn=''.obs;
  // Add a flag to track whether device location data has been fetched
  var deviceLocationFetched = false.obs;






  Future<void> getApiData() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(
          "https://api.openweathermap.org/data/2.5/weather?q=${searchcontroller.value.text}&appid=900da351c6e100d0c0fc8a8ba76815a2"));

      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);

        List weatherdata = data['weather'];
        Map weather = weatherdata[0];
        String desc = weather["description"];
        var iconnn= weather['icon'];

        Map temperdata = data['main'];
        var temppKelvin = temperdata['temp'];
        var mintemppKelvin = temperdata["temp_min"];
        var maxtemppKelvin = temperdata["temp_max"];
        var humidityy = temperdata["humidity"];

        Map airspeeddata = data["wind"];
        var airspeeddd = airspeeddata["speed"];

        Map sunsystem = data["sys"];
        var sunriseee = sunsystem["sunrise"];
        var sunsettt = sunsystem["sunset"];

        ////////////////////
        //convertt time
        var utcSunriseTimestamp = sunriseee; // Use your variable
        var utcSunsetTimestamp = sunsettt; // Use your variable
        ////
        // Convert UTC to PKT
        DateTime utcSunriseDateTime = DateTime.fromMillisecondsSinceEpoch(
            (utcSunriseTimestamp * 1000) ,
            isUtc: true);
        DateTime utcSunsetDateTime = DateTime.fromMillisecondsSinceEpoch(
            utcSunsetTimestamp * 1000,
            isUtc: true);

        // Add 5 hours to convert to PKT
        DateTime pktSunriseDateTime =
            utcSunriseDateTime.add(Duration(hours: 5));
        DateTime pktSunsetDateTime = utcSunsetDateTime.add(Duration(hours: 5));

        // Format the PKT DateTime objects as strings
        String pktSunriseTime =
            DateFormat('hh:mm a').format(pktSunriseDateTime);
        String pktSunsetTime = DateFormat('hh:mm a').format(pktSunsetDateTime);

        // Convert temperature from Kelvin to Celsius
        var temppCelsius = temppKelvin - 273.15;
        var mintemppCelsius = mintemppKelvin - 273.15;
        var maxtemppCelsius = maxtemppKelvin - 273.15;

        // Convert wind speed from meters per second to kilometers per hour
        var airspeedKmph = airspeeddd * 3.6;

        // Update the Rx variables with the converted values
        temperature.value = '${temppCelsius.toStringAsFixed(2)}°C';
        minTemp.value = '${mintemppCelsius.toStringAsFixed(2)}°C';
        maxTemp.value = '${maxtemppCelsius.toStringAsFixed(2)}°C';
        descriptonn.value = desc;
        humidity.value = '$humidityy%';
        sunrise.value = pktSunriseTime;
        sunsett.value = pktSunsetTime;
        iconn.value=iconnn;
        airspeed.value = '${airspeeddd.toStringAsFixed(2) }m/s / ${airspeedKmph.toStringAsFixed(2)} km/h';
       Get.offAll(SearchScreen(img: iconn,airsped: airspeed.value, humidityy: humidity.value,sunset: sunsett.value,temp: temperature.value, maxT: maxTemp.value, minT: minTemp.value, sunR: sunrise.value, appbar:searchcontroller.value.text));
        Fluttertoast.showToast(
          msg: "Weather data fetched successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        // Handle the error here
        Fluttertoast.showToast(
          msg: "HTTP Error: ${response.statusCode}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      isLoading.value = false;
      // Handle any exceptions that occur
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } finally {
      isLoading.value = false;
    }
  }


/////////////////


  Future<void> getWeatherByDeviceLocation() async {
    print("Before requesting location permission");
    await Geolocator.checkPermission();
    await Geolocator.requestPermission();
    print("After requesting location permission");

if(deviceLocationFetched.value){

  return;
}
    try {

      print("Before getting current location");
      isLoading.value = true;

      final GeolocatorPlatform geolocator = await GeolocatorPlatform.instance;
      final Position position = await geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,

      );

        print('tttttttttPosition obtained: $position');
      print("After getting current location");

      if (position != null) {




          // Continue with your weather API call here
          final response = await http.get(Uri.parse(
            "https://api.openweathermap.org/data/2.5/weather?lat=${position
                .latitude}&lon=${position
                .longitude}&appid=900da351c6e100d0c0fc8a8ba76815a2"));

        print('this is in api$position');
        if (response.statusCode == 200) {
          Map data = jsonDecode(response.body);



          // Process weather data
          List weatherData = data['weather'];
          Map weather = weatherData[0];
          String desc = weather["description"];
          var iconnn= weather['icon'];


          Map tempData = data['main'];
          var tempKelvin = tempData['temp'];
          var minTempKelvin = tempData["temp_min"];
          var maxTempKelvin = tempData["temp_max"];
          var humidityValue = tempData["humidity"];

          Map windData = data["wind"];
          var windSpeed = windData["speed"];

          Map sunData = data["sys"];
          var sunriseTime = sunData["sunrise"];
          var sunsetTime = sunData["sunset"];

          // Convert temperature from Kelvin to Celsius
          var tempCelsius = tempKelvin - 273.15;
          var minTempCelsius = minTempKelvin - 273.15;
          var maxTempCelsius = maxTempKelvin - 273.15;

          // Format sunrise and sunset times
          DateTime sunriseDateTime =
          DateTime.fromMillisecondsSinceEpoch((sunriseTime * 1000) as int, isUtc: true);
          DateTime sunsetDateTime =
          DateTime.fromMillisecondsSinceEpoch((sunsetTime * 1000) as int, isUtc: true);

          // Add 5 hours to convert to PKT (Pakistan Standard Time)
          sunriseDateTime = sunriseDateTime.add(Duration(hours: 5));
          sunsetDateTime = sunsetDateTime.add(Duration(hours: 5));

          // Format sunrise and sunset times as strings
          String formattedSunrise = DateFormat('hh:mm a').format(
              sunriseDateTime);
          String formattedSunset = DateFormat('hh:mm a').format(sunsetDateTime);

          // Update the observables
          temperature.value = '${tempCelsius.toStringAsFixed(2)}°C';
          minTemp.value = '${minTempCelsius.toStringAsFixed(2)}°C';
          maxTemp.value = '${maxTempCelsius.toStringAsFixed(2)}°C';
          descriptonn.value = desc;
          iconn.value=iconnn;
          humidity.value = '$humidityValue%';
          sunrise.value = formattedSunrise;
          sunsett.value = formattedSunset;
          airspeed.value = '$windSpeed m/s';

          isLoading.value = false;
          Fluttertoast.showToast(
            msg: "data is loaded successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,

          );
          deviceLocationFetched.value = true;

        }else{

          isLoading.value = false;
          print("Failed to fetch weather data: ${response.statusCode}");
          Fluttertoast.showToast(
            msg: "Failed to fetch weather data",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );

        }
        }  else {
          isLoading.value = false;
          // Handle API error

          Fluttertoast.showToast(
            msg: "Failed to fetch weather data",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }






    } catch (e) {
      isLoading.value = false;
      // Handle exceptions
      print('noooo data is found');
      print(e);
      Fluttertoast.showToast(
        msg: "Error: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }



  void skipNavgation() {
    Get.offAll(HomeScreen());
  }

  void secondNavigation() {
    Get.offAll(SplishScreenThree());
  }

  void thirdNavigation() {
    Get.offAll(SplishScreenfour());
  }

  void forthNavigation() {
    Get.offAll(SplishScreenfive());
  }




}




// Future<void> getWeatherByDeviceLocation() async {
  //   final location = Location();
  //   final hasPermission = await location.hasPermission();
  //   if (hasPermission == PermissionStatus.denied) {
  //     await location.requestPermission();
  //   }
  //
  //   try {
  //     isLoading.value = true;
  //     final locationData = await location.getLocation();
  //     final latitude = locationData.latitude;
  //     final longitude = locationData.longitude;
  //
  //     final response = await http.get(Uri.parse(
  //         "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=YOUR_API_KEY"));
  //
  //     if (response.statusCode == 200) {
  //       Map data = jsonDecode(response.body);
  //
  //       // Process weather data
  //       List weatherData = data['weather'];
  //       Map weather = weatherData[0];
  //       String desc = weather["description"];
  //
  //       Map tempData = data['main'];
  //       double tempKelvin = tempData['temp'];
  //       double minTempKelvin = tempData["temp_min"];
  //       double maxTempKelvin = tempData["temp_max"];
  //       int humidityValue = tempData["humidity"];
  //
  //       Map windData = data["wind"];
  //       double windSpeed = windData["speed"];
  //
  //       Map sunData = data["sys"];
  //       int sunriseTime = sunData["sunrise"];
  //       int sunsetTime = sunData["sunset"];
  //
  //       // Convert temperature from Kelvin to Celsius
  //       double tempCelsius = tempKelvin - 273.15;
  //       double minTempCelsius = minTempKelvin - 273.15;
  //       double maxTempCelsius = maxTempKelvin - 273.15;
  //
  //       // Format sunrise and sunset times
  //       DateTime sunriseDateTime =
  //       DateTime.fromMillisecondsSinceEpoch(sunriseTime * 1000, isUtc: true);
  //       DateTime sunsetDateTime =
  //       DateTime.fromMillisecondsSinceEpoch(sunsetTime * 1000, isUtc: true);
  //
  //       // Add 5 hours to convert to PKT (Pakistan Standard Time)
  //       sunriseDateTime = sunriseDateTime.add(Duration(hours: 5));
  //       sunsetDateTime = sunsetDateTime.add(Duration(hours: 5));
  //
  //       // Format sunrise and sunset times as strings
  //       String formattedSunrise = DateFormat('hh:mm a').format(sunriseDateTime);
  //       String formattedSunset = DateFormat('hh:mm a').format(sunsetDateTime);
  //
  //       // Update the observables
  //       temperature.value = '${tempCelsius.toStringAsFixed(2)}°C';
  //       minTemp.value = '${minTempCelsius.toStringAsFixed(2)}°C';
  //       maxTemp.value = '${maxTempCelsius.toStringAsFixed(2)}°C';
  //       descriptonn.value = desc;
  //       humidity.value = '$humidityValue%';
  //       sunrise.value = formattedSunrise;
  //       sunsett.value = formattedSunset;
  //       airspeed.value = '$windSpeed m/s';
  //
  //       isLoading.value = false;
  //     } else {
  //       isLoading.value = false;
  //       // Handle API error
  //     }
  //   } catch (e) {
  //     isLoading.value = false;
  //     // Handle exceptions
  //   }
  // }





