import 'package:flutter/material.dart';

class Textfild extends StatelessWidget {
  Textfild(
      {Key? key,
       this.controller,
       this.typeData,
       this.title,
      required this.password,
      required this.numSmoL,
      required this.numBeg,
       this.icon,
       this.errorSmoL,
       this.errorBeg,
       this.keyboardType,
       this.maxLength,
       this.initialValue
       });
    String? initialValue; 
    int? maxLength;
  String? title;
  Icon? icon;
  bool password;
  String? errorSmoL, errorBeg;
  int numBeg, numSmoL;
  TextInputType? keyboardType;
  void Function(String?)?typeData;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
        initialValue: initialValue ,
        maxLength: maxLength,
        controller: controller,
        keyboardType: keyboardType,
        onChanged:typeData,
        onSaved: typeData,
        cursorColor: Colors.black,
        validator: (value) {
          if (value!.length > numBeg) {
            
            return errorBeg;
          } else if (value.length < numSmoL) {
            return errorSmoL;
          }else{
          return null;

          }
          

        },
        obscureText: password,
        decoration: InputDecoration(
          prefixIcon: icon,
          hintText: title,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
