import 'package:flutter/material.dart';

class TextCircleButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color textColor;
  final double fontSize;
  final EdgeInsets padding;
  final double elevation;
  final Color backgroundColor;

  TextCircleButton({
    this.onPressed,
    this.text,
    this.textColor,
    this.fontSize,
    this.padding,
    this.elevation,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.button;
    return CircleButton(
      onPressed: onPressed,
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: textColor ?? textStyle.color, fontSize: fontSize ?? textStyle.fontSize),
          overflow: TextOverflow.clip,
        ),
      ),
      padding: padding,
      elevation: elevation,
      color: backgroundColor,
    );
  }
}

class CircleButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final EdgeInsets padding;
  final double elevation;
  final Color color;

  CircleButton({this.onPressed, this.child, this.padding, this.elevation, this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 40,
      height: 40,
      child: RawMaterialButton(
        onPressed: onPressed,
        child: child,
        shape: CircleBorder(),
        elevation: elevation ?? 2.0,
        fillColor: color ?? Theme.of(context).buttonColor,
      ),
    );
  }
}
