import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  late String location; //location for the ui
  late String time; //time at selected location
  late String flag; //local uri of a flag asset
  late String url; //url endpoint for the current location
  late bool isDaytime; //true for day false for night

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse("https://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);
      // print(data);

      String dateTime = data["datetime"];
      String offset = data["utc_offset"].toString().substring(1, 3);
      // print(dateTime);
      // print("offset -> $offset");

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm().format(now);
    } catch (e) {
      print("caught error $e");
      time = "couldn't get time data";
    }
  }
}
