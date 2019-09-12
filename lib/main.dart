import 'package:flutter/material.dart';
import './radialMenu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'FlutterBase', home: MyHomePage());
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
    return MaterialApp(
        home: Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.red,
          ),
          Column(
            children: <Widget>[
              Text('dataaaaaaaaaaaaaaaaa'),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: 400, left: 200),
            child: Text('data'),
          ),
          Menu(),
        ],
      ),
    ));
  }
}
