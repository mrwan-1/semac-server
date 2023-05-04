import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shemac_service_provider/auth/widgets/massege_full.dart';
import 'package:shemac_service_provider/config.dart';

import '../../widgets/botton.dart';
import 'edit_skin_care.dart';

class SkinCard extends StatefulWidget {
  SkinCard(
      {super.key, required this.url, required this.title, required this.price,required this.docid,required this.list});
  String url;
  String title;

  String price;
    String docid;
var list;

  @override
  State<SkinCard> createState() => _SkinCardState();
}

class _SkinCardState extends State<SkinCard> {
     CollectionReference parfanref =
      FirebaseFirestore.instance.collection('skinCare');

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300,
        width: MediaQuery.of(context).size.width / 1.1,
        decoration: BoxDecoration(
            color: Ktitle, borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                widget.url,
                width: double.infinity,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 4,
              ),
            ),
            Spacer(),
            Text(widget.title),
            Spacer(),
            Text(widget.price),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               Buttonkey(
                color: Colors.red,
                onPressed: () async{
                // ignore: await_only_futures
                await  awesome(context, '', 'هل انت متاكد من قيامك بحذف المنتج', DialogType.info,
                      Colors.green, 'الغاء', () {}, () async{
                    setState(() {
                      parfanref.doc(widget.docid).delete();
                      FirebaseStorage.instance
                          .refFromURL(widget.list['image'])
                          .delete()
                          .then((value) =>
                              Get.snackbar('تمت عمليه الحذف بنجاح', 'يرجئ تحديث الصفحه'));
                    });
                  }, 'حذف');
                },
                text: 'حذف',
              ),
              Buttonkey(
                color: Colors.blue,
                onPressed: () {
                  Get.to(EditSkin(
                    docid: widget.docid,
                    list: widget.list,
                  ));
                },
                text: 'تعديل',
              ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
