import 'package:flutter/material.dart';
import './pages/authPage.dart';
// import 'package:flutter/rendering.dart';

void main(){
 runApp(MyApp());

//  to add debuging paint on the UI screen

//  debugPaintPointersEnabled=true;
//  debugPaintSizeEnabled=true;
//  debugPaintBaselinesEnabled=true;
}

class MyApp extends StatelessWidget {
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          brightness: Brightness.light),
      home:AuthPage(),
    );
  }
}
