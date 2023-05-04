import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shemac_service_provider/config.dart';
import 'package:shemac_service_provider/page/skin_care/widgets/skin_care_card.dart';
import 'package:shemac_service_provider/page/skin_care/widgets/skin_care_data.dart';

import '../../home/home_screen.dart';

class SkinCare extends StatefulWidget {
  SkinCare({
    super.key,
     this.title,
     this.id,
     this.docid,
     this.list,
  });
   String? title;

  String? id;
    String? docid;
    var list;


  @override
  State<SkinCare> createState() => _SkinCareState();
}

class _SkinCareState extends State<SkinCare> {
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  CollectionReference skinCare = FirebaseFirestore.instance.collection('skinCare');
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  add() async {
    var formdata = formState.currentState;

    if (formdata!.validate()) {
      formdata.save();
    }
  }

  late File file;
  Reference? ref;
  String? imageUrl, title1, prais;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        actions: [
                    IconButton(onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
              return HomeScreen();
            },), (route) => false);
          }, icon: Icon(Icons.arrow_back_ios_new,color: Colors.white,))
        ],
      ),
      body: Form(
        key: formState,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return SkinCareData(
                       
                        );
                      },
                    ));
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    height: double.infinity,
                    width: size.width / 1.1,
                    decoration: BoxDecoration(
                        color: Ktitle, borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          size: 50,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'اضافه منتج',
                          style: TextStyle(fontSize: 22),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
              Expanded(
            flex: 2,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: RefreshIndicator(
                color: Kbackdrung,
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  return Future<void>.delayed(const Duration(seconds: 3));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                 
                    SingleChildScrollView(
                        child: Builder(
                          builder: (context) {
                            return FutureBuilder(
                              future: skinCare.get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasError) {
                                  return const Text("Something went wrong");
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  var data = snapshot.data?.docs;
                                  var children = data?.map((e) {
                                    return InkWell(
                                      onTap: () {
                                        // Get.to(Prodect(
                                        //   list: e,
                                        // ));
                                      },
                                      child: SkinCard(
                                          url: e["image"],
                                          title: e["name"],
                                          price: e["def"],
                                           docid: e.id,
                                            list: e.data(),
                                          ),
                                    );
                                  }).toList();
                                  return Column(
                                    children: children as List<Widget>,
                                  );
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                          },
                        )),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}


