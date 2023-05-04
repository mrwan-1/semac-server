import 'package:flutter/material.dart';


class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    
  }) : super(key: key);
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // primary: R.colors.primary,
    //background color of button
            elevation: 2, //elevation of button
            shape: RoundedRectangleBorder(
                //to set border radius to button
                borderRadius: BorderRadius.circular(11)),
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          ),
          onPressed: onPressed,
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
