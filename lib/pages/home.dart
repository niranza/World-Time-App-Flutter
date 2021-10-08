import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map;
    String time = data["time"];
    String location = data["location"];
    String flag = data["flag"];
    bool isDaytime = data["isDaytime"];

    String bigImage = isDaytime ? "daytime.jpg" : "nighttime.jpg";
    Color bgColor = isDaytime ? Colors.blue : Colors.indigo[700]!;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/$bigImage"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: <Widget>[
              OutlinedButton.icon(
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, "/location");
                  if (result != null) {
                    setState(() {
                      data = {
                        "time": result["time"],
                        "location": result["location"],
                        "isDaytime": result["isDaytime"],
                        "flag": result["flag"],
                      };
                    });
                  }
                },
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.black,
                ),
                label: Text(
                  "Edit Location",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    location,
                    style: TextStyle(fontSize: 28, letterSpacing: 2),
                  ),
                  SizedBox(width: 25),
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/$flag"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                time,
                style: TextStyle(fontSize: 66),
              )
            ],
          ),
        ),
      )),
    );
  }
}
