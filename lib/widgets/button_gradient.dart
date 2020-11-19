import 'package:flutter/material.dart';

class ButtonGradient extends StatelessWidget {
  final double width;
  final double height;
  final Function onPressed;
  final Text text;
  final Icon icon;

  const ButtonGradient(
      {Key key, this.width, this.height, this.onPressed, this.text, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Colors.amber, Colors.teal],
        ),
      ),
      child: MaterialButton(
        onPressed: this.onPressed,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              text,
              icon,
            ],
          ),
        ),
      ),
    );
  }
}
