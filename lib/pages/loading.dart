import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time_app/services/world_time.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String time = "loading";

  void setupWorldTime() async {
    WorldTime worldTime = WorldTime(
        location: "Israel", flag: "israel.png", url: "Asia/Jerusalem");
    await worldTime.getTime();
    Navigator.popAndPushNamed(
      context,
      "/home",
      arguments: {
        "location": worldTime.location,
        "flag": worldTime.flag,
        "time": worldTime.time,
        "isDaytime": worldTime.isDaytime
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFoldingCube(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
