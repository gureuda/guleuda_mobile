import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayer/audioplayer.dart';

import 'gurenda.dart';
import 'video_list.dart';
import 'ui/round_button.dart';
import 'ui/show_video_button.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '구르다',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '구르다'),
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
  bool isStarted = false;
  GurendaResult result;
  Gurenda gurenda = new Gurenda();
  AudioPlayer audioPlugin = new AudioPlayer();

  void _onPress() async {
    setState(() {
      this.result = null;
      this.isStarted = true;
    });

    var result = await this.gurenda.start();
    await this.audioPlugin.play('audios/1.mp3', isLocal: true);

    result.listen((_result) {
      setState(() {
        this.result = _result;
        this.isStarted = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: Color(0xFF005EFF)),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 80,
                    child: Image.asset(
                      'images/logo.png',
                      width: 140
                    ),
                  )
                )
              ],
            ),
            Positioned.fill(
              child: Image.asset(
                'images/bGarea.png',
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomLeft,
              ),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 400),
                alignment: Alignment.center,
                child: !this.isStarted && this.result != null ? Material(
                    type: MaterialType.transparency,
                    child: Text(
                      this.result.success ? '성공!' : '실패!',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFFFFF),
                      ),
                    )
                ) : Container(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 290),
              alignment: Alignment.center,
              child: !this.isStarted && this.result != null && this.result.success ? Material(
                  type: MaterialType.transparency,
                  child: Text(
                    '정말 안정적인 구르기 였어요.\n기품이 느껴져요!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFFFFFFFF),
                    ),
                    maxLines: 2,
                  )
              ) : Container(),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 400),
              alignment: Alignment.center,
              child: this.result == null && !this.isStarted ? Material(
                type: MaterialType.transparency,
                child: Text(
                  '지금 구르시겠어요?',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                )
              ) : Container()
            ),
            Padding(
              padding: EdgeInsets.only(top: 320, left: 62),
              child: Image.asset(
                this.result != null && this.result.success ? 'images/tissue.gif' : 'images/tissue.png',
                width: 260,
                alignment: Alignment.center,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 630),
                child: Row(
                  children: <Widget>[
                        !this.isStarted ? Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(left: 24, right: 24),
                              child: RoundButton(
                                  text: this.result != null ? '다시 구르기' : '구르다',
                                  onPressed: _onPress,
                                  color: Color(0xFF005EFF)
                              )
                            )
                        ) : Container(),
                  ],
                )
            ),
            Padding(
                padding: EdgeInsets.only(top: 698),
                child: Row(
                  children: <Widget>[
                    !this.isStarted ? Expanded(
                        flex: 1,
                        child: Padding(
                            padding: EdgeInsets.only(left: 24, right: 24),
                            child: ShowVideoButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => VideoList()),
                                );
                              },
                            ),
                        )
                    ) : Container(),
                  ],
                )
            ),
          ],
        ));
  }
}
