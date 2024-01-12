import 'package:http/http.dart';
import 'dart:convert';


class worker
{
  late String location;

  worker({required this.location}) {
    location = this.location;
  }

  late String temp;
  late String humidity;
  late String air_speed;
  late String description;
  late String main;
  late String icon;

  Future<void> getData() async{
    try{
      Response response = await get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$location&appid=cf31e6839c000eb02c672f30d95340ba"));
      Map data = jsonDecode(response.body);

      // temp, humidity
      Map temp_data = data['main'];
      String getHumidity = temp_data['humidity'].toString();
      double getTemp = temp_data['temp'] - 273.15;

      // getting air speed
      Map wind = data['wind'];
      double getAir_speed = wind['speed'] * 3.6;

      //gettiing Description
      List weather_data = data['weather'];
      Map weather_main_data = weather_data[0];
      String getMain_des = weather_main_data['main'];
      String getDesc = weather_main_data['description'];

      //value daal di
      temp =getTemp.toString();
      humidity = getHumidity;
      air_speed = getAir_speed.toString();
      description = getDesc;
      main = getMain_des;
      icon = weather_main_data["icon"].toString();

    }catch(e){
      temp ="NA";
      humidity = "NA";
      air_speed = "NA";
      description = "NA";
      main = "NA";
      icon = "09d";
    }
  }
}