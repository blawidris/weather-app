import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String? location; //location name for the UI
  String? time; // the time in that location
  String? flag; // uri for asset
  String? uri; // location url for api endpoint
  bool? isDaytime; // true or false if dayytime or not

  WorldTime({
    this.location,
    this.flag,
    this.uri,
  });

  Future<void> getTime() async {
    try {
      // set url
      var url = Uri.http('worldtimeapi.org/api/timezone/', "$uri");

      //  make request
      var response = await http.get(url);
      Map data = jsonDecode(response.body);

      // get properties from data
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].toString().substring(1, 3);

      // create a datetime object
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set a time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = "could not get time data";
    }
  }
}
