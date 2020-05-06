import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: buildStack(1.3),
        ),
        Center(
          child: buildStack(-1.3),
        ),
      ],
    );
  }

  Stack buildStack(double x) {
    return Stack(
      alignment: Alignment(x, -.1),
//        alignment: AlignmentDirectional.centerEnd,
      children: <Widget>[
        Icon(
          Icons.call_to_action,
          color: Colors.red,
          size: 100,
        ),
        Icon(
          Icons.access_time,
          color: Colors.blue,
          size: 40,
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(widget.title),
    );
  }
}
