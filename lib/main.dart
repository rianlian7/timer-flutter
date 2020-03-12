import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(TimerApp());

class TimerApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return new TimerAppState();
  }
}

class TimerAppState extends State<TimerApp>{
  static const duration = const Duration(seconds:1);

  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;  

  void handleTicks(){
    if (isActive){
      setState(() {
        secondsPassed += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    if (timer == null)
      timer = Timer.periodic(duration, (Timer t){
        handleTicks();
      });

    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60*60);

    String timeFormat(int time){
      String timeFormat;
      if (time < 10){
        timeFormat = '0' + time.toString();
      }
      else{
        timeFormat = time.toString();
      }
      return timeFormat;
    }
  

    return MaterialApp(
      title: 'Flutter Timer Demo',

      theme: ThemeData(
      primarySwatch: Colors.blue,
      ),
      
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Timer'),
        ),
      
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                CustomTextContainer(label: 'HRS', value: timeFormat(hours)),
                CustomTextContainer(label: 'MIN', value: timeFormat(minutes)),
                CustomTextContainer(label: 'SEC', value: timeFormat(seconds)),
                ],
              ),
              
              Container(
                padding: EdgeInsets.all(25),
                ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  
                  RaisedButton(
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      setState((){
                        isActive ? isActive = !isActive : isActive = isActive;
                        secondsPassed = 0;
                      });
                    },
                    child: Container(
                      child: Text("RESET", style: TextStyle(fontSize: 25)),)
                    ),

                  RaisedButton(
                    padding: EdgeInsets.all(15),
                    onPressed: () {
                      setState(() {
                        isActive = !isActive;
                      });
                    },
                    child: Container(
                      child: Text((isActive ? 'PAUSE' : 'START'), style: TextStyle(fontSize: 25),),
                    ),
                  ),
                ],
              )
            ],
          ), 
        ),
      )
    );
  }
}


class CustomTextContainer extends StatelessWidget{
  CustomTextContainer({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(15),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(10),
        color: Colors.black87
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 54,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$label',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}
