
import 'package:flutter/material.dart';
import 'package:shemac_service_provider/auth/account.dart';
import 'package:shemac_service_provider/home/widgets/home_servise_card.dart';
import 'package:shemac_service_provider/page/mackup/mackup.dart';
import 'package:shemac_service_provider/page/parfan/parfan.dart';
import 'package:shemac_service_provider/page/skin_care/skin_care.dart';
import 'package:shemac_service_provider/page/trind/trind.dart';

import '../page/notifications/notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic listRat = [
    {
      "id": "1",
      "title": "الرائج",
      "IconData": Icons.trending_up_outlined,
      "page": Trind(id: "1", title: "الرائج",),
    },
    {
      "id": "2",
      "title": "المكياج",
      "IconData": Icons.filter_b_and_w_sharp,
      "page": Mackup(id: "2", title: "المكياج",),
    },
    {
      "id": "3",
      "title": "العطور",
      "IconData": Icons.panorama_fisheye_rounded,
      "page":Parfan(id: "3", title: "العطور",),
    },
    {
      "id": "4",
      "title": "العنايه بالبشره",
      "IconData": Icons.message,
      "page":SkinCare(id: "4", title: "العنايه بالبشره",),
    },
    {
      "id": "5",
      "title": "الاشعارات",
      "IconData": Icons.notifications,
      "page": Notifications(id: '5', title: 'الاشعارات',)
    },
    // {
    //   "id": "6",
    //   "title": "الطلبيات قيد التنفيذ",
    //   "IconData": Icons.access_alarm,
    //   // "page":OrderNow(id: "6", title: "الطلبيات قيد التنفيذ",),
    // },
  ];
  GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // _globalKey.currentState?.openEndDrawer();
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Account();
              },));
            },
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
              size: 30,
            )),
        backgroundColor: Colors.white10,
        elevation: 0,
      ),
      // endDrawer: const MyDrawer(),
      key: _globalKey,
      body: GridView.builder(
        itemCount: listRat.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 4,
          crossAxisSpacing: 8,
          childAspectRatio: 8 / 8,
        ),
        itemBuilder: (BuildContext context, int i) {
          return ServiseCard(
            icon: listRat[i]['IconData'],
            title: listRat[i]['title']!,
            id: listRat[i]['id']!,
             ontap:() {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                  return listRat[i]['page'];
                },), (route) => false);
             },
          );
        },
      ),
    );
  }
}
