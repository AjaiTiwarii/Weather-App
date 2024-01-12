import 'package:flutter/material.dart';
import 'package:weather_app/Worker/worker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  late String temp;
  late String hum;
  late String des;
  late String main;
  late String city = "Kanpur";
  late String air_speed;
  late String icon;

  void startApp(String city) async{
    worker instance = worker(location: city);
    await instance.getData();

    temp = instance.temp;
    hum = instance.humidity;
    air_speed=instance.air_speed;
    main=instance.main;
    des=instance.description;
    icon=instance.icon;
    //loc=instance.location;

    Future.delayed(Duration(seconds: 1),() {
      Navigator.pushNamed(context, '/home', arguments: {
        "temp_value" : temp,
        "hum_value" : hum,
        "air_speed_value" : air_speed,
        "des_value" : des,
        "main_value" : main,
        "icon_value" : icon,
        "city_value" : city,
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    //startApp();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Map? search = ModalRoute.of(context)?.settings.arguments as Map?;

    if(search?.isNotEmpty ?? false){
      city = search?['searchText'];
    }
    startApp(city);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/mlogo.png", height: 100, width: 100,),

            SizedBox(height: 15,),

            Text("Weather App",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),),
            Text("Made by Ajay"),

            SizedBox(height: 30,),

            SpinKitWave(
              color: Colors.black,
              size: 30.0,
            ),
          ],
        ),
      ),
    );
  }
}
