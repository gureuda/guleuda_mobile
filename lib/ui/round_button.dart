import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton({
    @required this.onPressed,
    @required this.color,
    @required this.text,
  });

  final GestureTapCallback onPressed;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: this.color,
      onPressed: this.onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(const Radius.circular(30))),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              this.text,
              maxLines: 1,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )
    );
  }
}
