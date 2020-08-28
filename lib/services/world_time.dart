import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime{

  String location; //Location name for the UI
  String time; //the Time in that location
  String flag; // url to an asset flag
  String url; //this is the location url for api endpoint
  bool isDayTime; //true or false if daytime or not

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async{
    try{
      //make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      print(data);


      //get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1,3);

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours:int.parse(offset)));
      print(now);

      //set the time property
      isDayTime = now.hour>6 && now.hour<20?true:false;
      print("Is Day Time = "+isDayTime.toString());
      time = DateFormat.jm().format(now);
    }
    catch(e){
      print('Ashraf We have Caught Error : $e');
      time = 'Could not get time data';
    }
  }
}

