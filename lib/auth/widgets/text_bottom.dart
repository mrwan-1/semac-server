
import 'package:flutter/material.dart';


class TextButtonWedgets extends StatelessWidget {
   TextButtonWedgets({
    Key? key,
    required this.title,
    required this.suptitle,
    required this.onPressed
    
  });
   String title, suptitle;

 VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(onPressed: onPressed, child: Text(suptitle)),
        Text(title),
      ],
    );
  }
}
