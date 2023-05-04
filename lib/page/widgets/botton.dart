import 'package:flutter/material.dart';


class Buttonkey extends StatelessWidget {
  const Buttonkey({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.color
  }) : super(key: key);
  final String text;
  final void Function() onPressed;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // primary: R.colors.primary,
    //background color of button
        elevation: 2, //elevation of button
                  backgroundColor: color,

        shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(11)),
      ),
      onPressed: onPressed,
      child: Text(
        text,
      ),
    );
  }
}
