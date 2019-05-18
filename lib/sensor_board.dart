import 'package:flutter/material.dart';

import 'gurenda.dart';

class SensorBoard extends StatefulWidget {
  SensorBoardState createState() => new SensorBoardState();
}

class SensorBoardState extends State<SensorBoard> {
  bool isStarted = false;
  Gurenda gurenda = new Gurenda();

  void _start() async {
    setState(() {
      isStarted = true;
    });

    var result = await this.gurenda.start();
    result.listen((_result) {
      print(_result.success);
      setState(() {
        isStarted = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new RaisedButton(
          onPressed: _start,
          child: Text(
              '시작',
              style: TextStyle(fontSize: 20)
          ),
        ),
      ],
    );
  }
}
