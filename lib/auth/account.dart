// ignore_for_file: use_build_context_synchronously



import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:shemac_service_provider/auth/signIn.dart';
import 'package:shemac_service_provider/auth/widgets/massege_full.dart';
import 'package:shemac_service_provider/config.dart';



class Account extends StatefulWidget {
  static const rautsAccount = 'account';
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  var userName = FirebaseAuth.instance.currentUser;
  var data = FirebaseFirestore.instance.collection("users");

  getUser() {
    print(userName?.email);
    print('==============================ohhh=========');
    print(data.id);
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Kbackdrung,
        leading: 
          IconButton(
            onPressed: () async {
              awesome(context, 'هل انت متاكد من قيامك بتسجيل الخروج', '',
                  DialogType.info, Colors.green, 'الغاء', () {}, () async {
                await FirebaseAuth.instance.signOut();

                Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (context) {
                      return Sign();
                    },), (route) => false);
              }, ' خروج ');
            },
            icon: const Icon(
              Icons.exit_to_app_outlined,
              size: 30,
              color: Colors.white,
            ),
          ),
        actions: [
          IconButton(onPressed: (){
            Navigator.of(context).pop();
          }, icon: Icon(Icons.arrow_back_ios_new))
        ],
      ),
      body: FutureBuilder(
        future: data.where('userid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(),
        builder:(context,snapshot){
       if (snapshot.hasData) {
         return  Column(
        children: [
          Container(
              width: double.infinity,
              height: 380,
              decoration: const BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(25)),
                color: Kbackdrung,
              ),
              alignment: Alignment.center,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    radius: 50,
                    child: const Icon(
                      Icons.account_circle_rounded,
                      color: Colors.black45,
                      size: 100,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                   Text(
                    '${snapshot.data?.docs[0].get('name')}',
                    style: TextStyle(fontSize: 29, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    '${snapshot.data?.docs[0].get('username')}',
                    style: const TextStyle(fontSize: 25, color: Colors.white),
                  ),
                   const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'رقم الهاتف : ${snapshot.data?.docs[0].get('phone')}',
                    style: TextStyle(fontSize: 17, color: Colors.white),
                  ),
                ],
              ))
        ],
      );
       }else{
               return Center(child: Text('... يتم جلب البيانات ',style: TextStyle(fontSize: 23),));

       }
        } )
    );
  }
}
