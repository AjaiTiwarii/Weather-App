import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:qweather_icons/qweather_icons.dart';
import 'package:weather_icons/weather_icons.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController searchController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("this is init state");
  }

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    print("Set state called");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Widget destroyed");
  }

  @override
  Widget build(BuildContext context) {
    Map? info = ModalRoute.of(context)?.settings.arguments as Map?;
    //Map info = ModalRoute.of(context).settings.arguments;
    String temp =  ((info?['temp_value']).toString());
    String air = ((info?['air_speed_value']).toString());
    if(temp == "NA")
    {
      print("NA");
    }
    else
    {
      temp =  ((info?['temp_value']).toString()).substring(0,4);
      air = ((info?['air_speed_value']).toString()).substring(0,4);
    }
    // String temp =  ((info?['temp_value']).toString()).substring(0,4);
    String icon = info?['icon_value'];
    String getcity = info?['city_value'];
    String hum = info?['hum_value'];
    //String air = ((info?['air_speed_value']).toString()).substring(0,4);
    String des = info?['des_value'];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.blue.shade500,
        )
      ),


      body: SingleChildScrollView(
        child: SafeArea(
           child: Container(
             decoration: BoxDecoration(
               gradient: LinearGradient(
                 begin: Alignment.topCenter,
                 end: Alignment.bottomCenter,
                 colors: [Colors.blue.shade400, Colors.blue.shade200]
               )
             ),
             child: Column(
               children: [
                 Container(
                   padding: EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                   margin: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                   decoration: BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(10)
                   ),
                   child: Row(
                     children: [
                       GestureDetector(
                         onTap: () {
                           Navigator.pushNamed(context, "/loading",arguments: {
                             "searchText" : searchController.text,
                           });
                         },
                         child: Container(
                           child: Icon(
                             Icons.search,
                             color:  Colors.lightBlue,
                           ),
                           margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                         ),
                       ),
                       Expanded(
                         child: TextField(
                           controller: searchController,
                           decoration: InputDecoration(
                             border: InputBorder.none, hintText: "Search $getcity"
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
                 Row(
                   children: [
                     Expanded(
                       child: Container(
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10),
                           color: Colors.white.withOpacity(0.5)
                         ),
                         margin: EdgeInsets.symmetric(horizontal: 25),
                         padding: EdgeInsets.all(0),
                         child:  Row(children: [
                           Image.network("https://openweathermap.org/img/wn/$icon@2x.png"),
                           SizedBox(width: 15,),
                           Column(
                             children: [
                               Text("$des",style: TextStyle(
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold
                               ),),
                               Text("In $getcity",style: TextStyle(
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold
                               ),)
                             ],
                           )
                         ]),
                       ),
                     )
                   ],
                 ),
                 Row(
                   children: [
                     Expanded(
                       child: Container(

                         height: 260,
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(14),
                             color: Colors.white.withOpacity(0.5)),

                         margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                         padding: EdgeInsets.all(26),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Icon(WeatherIcons.thermometer),
                             SizedBox(
                               height: 25,
                             ),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text("$temp", style: TextStyle(
                                   fontSize: 90
                                 ),),

                                 Text("°C",style: TextStyle(
                                   fontSize: 30
                                 ),)
                               ],
                             )
                           ],
                         ),
                       ),
                     ),
                   ],
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Expanded(
                       child: Container(
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(14),
                             color: Colors.white.withOpacity(0.5)),
                         margin: EdgeInsets.fromLTRB(25, 0, 10, 0),
                         padding: EdgeInsets.all(26),
                         child: Column(
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Icon(WeatherIcons.wind)
                               ],
                             ),
                             SizedBox(height: 22,)
                             ,
                             Text("$air",style: TextStyle(
                                 fontSize: 40,
                                 fontWeight: FontWeight.bold
                             ),),
                             Text("km/hr")
                           ],
                         ),
                         height: 180,
                       ),
                     ),
                     Expanded(
                       child: Container(
                         decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(14),
                             color: Colors.white.withOpacity(0.5)),
                         margin: EdgeInsets.fromLTRB(10, 0, 25, 0),
                         padding: EdgeInsets.all(26),
                         height: 180,
                         child: Column(
                           children: [
                             Row(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: [
                                 Icon(WeatherIcons.humidity)
                               ],
                             ),
                             SizedBox(height: 22,)
                             ,
                             Text("$hum",style: TextStyle(
                                 fontSize: 40,
                                 fontWeight: FontWeight.bold
                             ),),
                             Text("Percent")
                           ],
                         ),
                       ),
                     ),
                   ],
                 ),

                 SizedBox(height: 26,),

                 Container(
                   padding: EdgeInsets.all(20),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       Text("Made By Ajay"),
                       Text("Data Provided By Openweathermap.org")
                     ],
                   ),
                 )
               ],
             ),
           ),
        ),
      ),
    );
  }
}
