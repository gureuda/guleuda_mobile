import 'package:flutter/material.dart';

class ShowVideoButton extends StatelessWidget {
  ShowVideoButton({
    @required this.onPressed,
  });

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        fillColor: Color(0xFF3B3F45),
        onPressed: this.onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(const Radius.circular(30))),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text(
                '영상보기',
                maxLines: 1,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        )
    );
  }
}