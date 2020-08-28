import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldtime/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  List<WorldTime> locations = [
    WorldTime(url: 'Asia/Tokyo', location: 'Tokyo', flag: 'Tokyo.jpg'),
    WorldTime(url: 'Europe/Berlin', location: 'Berlin', flag: 'Berlin.jpg'),
    WorldTime(url: 'America/Denver', location: 'Denver', flag: 'Denver.jpg'),
    WorldTime(url: 'Africa/Nairobi', location: 'Nairobi', flag: 'Nairobi.jpg'),
    WorldTime(url: 'Europe/Moscow', location: 'Moscow', flag: 'Moscow.jpg'),
    WorldTime(url: 'Europe/Oslo', location: 'Oslo', flag: 'Oslo.jpg'),
    WorldTime(url: 'Europe/Stockholm', location: 'Stockholm', flag: 'StockHolm.jpg'),
    WorldTime(url: 'Europe/Sofia', location: 'Sofia', flag: 'Sofia.jpg'),
    WorldTime(url: 'Europe/Lisbon', location: 'Lisbon', flag: 'Lisbon.jpg'),
    WorldTime(url: 'America/Rio_Branco', location: 'Rio', flag: 'Rio.jpg'),
    WorldTime(url: 'Europe/Helsinki', location: 'Helsinki', flag: 'Helsinki.jpg'),
    WorldTime(url: 'Europe/Madrid', location: 'Marseille', flag: 'Marseille.jpg'),
    WorldTime(url: 'America/New_York', location: 'Professor', flag: 'Professor.jpg'),
    WorldTime(url: 'America/Bogota', location: 'Bogota', flag: 'Bogota.jpg'),

  ];

  void updateTime(index) async{
    WorldTime instance = locations[index];
    await instance.getTime();
    //Navigate to home screen
    Navigator.pop(context,{
      'location':instance.location,
      'flag':instance.flag,
      'time':instance.time,
      'isDayTime':instance.isDayTime,
    });
    //print("Andar se:"+instance.isDayTime.toString());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:Text('Choose a Location'),
        elevation: 0,
      ),
      body:ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){updateTime(index);},
            child: Container(
              height: 300,
              child: Card(
                color: Colors.black,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child:ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.red, Colors.transparent],
                    ).createShader(Rect.fromLTRB(0, 0, rect.width, 300.0));
                  },
                  blendMode: BlendMode.dstIn,
                  child:
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/${locations[index].flag}'),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: Container(
                    padding:EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 20.0),
                    alignment: Alignment.topLeft,
                    child: Text(locations[index].location,
                    style:TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                    )),
                  ),
                ),
              ),
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 5,
            margin: EdgeInsets.all(10),
            ),
          ),
          );
          }),
    );

  }


}
