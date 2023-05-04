import 'package:flutter/material.dart';

import '../../home/home_screen.dart';

class Notifications extends StatefulWidget {
  Notifications({super.key, required this.id, required this.title});
  String id;
  String title;
  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) {
                    return HomeScreen();
                  },
                ), (route) => false);
              },
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              ))
        ],
      ),
      body: Center(
        child: Text('Notifications'),
      ),
    );
  }
}
