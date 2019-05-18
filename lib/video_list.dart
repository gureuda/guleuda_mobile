import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoList extends StatelessWidget {
  _makeListTile(String title) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      title: Text(
       title,
        style: TextStyle(color: Color(0xFF3B3F45), fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        '데구르 친구들을 위해 준비했어요, 올바른 구르기법!',
        style: TextStyle(color: Color(0xFF3B3F45))
      )
    );
  }

  _makeCard(String title, String url) {

    return InkWell(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          //
        }
      },
      child: Card(
        elevation: 1.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: _makeListTile(title),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('강의 영상 보기'),
          leading: IconButton(icon:Icon(Icons.arrow_back),
            onPressed:() => Navigator.pop(context, false),
          )
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            ListView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.only(top: 10),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (BuildContext context, int index) {
                switch (index) {
                  case 0:
                    return _makeCard('올바른 앞구르기 자세', 'https://youtu.be/-jCM5PoYwsI');
                  case 1:
                    return _makeCard('올바른 옆구르기 자세', 'https://youtu.be/BRfNEKKHlbA');
                  case 2:
                    return _makeCard('올바른 뒤구르기 자세', 'https://youtu.be/NjDw0TM4yjw');
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 270),
              child: Image.asset(
                'images/banner.png',
                width: 327,
                alignment: Alignment.center,
              ),
            ),
          ],
        )
      ),
    );
  }
}
