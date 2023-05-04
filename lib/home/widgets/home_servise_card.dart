// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:shemac_service_provider/config.dart';

class ServiseCard extends StatefulWidget {
   ServiseCard({super.key,required this.icon,required this.title,required this.id,required this.ontap});
  String id;
  IconData icon;
  String title;
  VoidCallback ontap;
  @override
  State<ServiseCard> createState() => _ServiseCardState();
}

class _ServiseCardState extends State<ServiseCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.ontap,
      child: Container(
    
        margin: EdgeInsets.all(10),
              width: double.infinity,
              height: MediaQuery.of(context).size.height/4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Kbackdrung,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                
                  Icon(widget.icon,size: 50,),
                  SizedBox(height: 20,),
                  Text(widget.title,style: TextStyle(fontSize: 21,),)
                ],
              ),
            ),
    );
  }
}