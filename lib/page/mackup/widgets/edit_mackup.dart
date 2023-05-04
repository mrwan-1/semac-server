import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shemac_service_provider/auth/widgets/primary_Bottom.dart/primary_bottom.dart';
import 'package:shemac_service_provider/auth/widgets/text_fild.dart';
import 'package:shemac_service_provider/config.dart';
import 'package:shemac_service_provider/page/trind/trind.dart';

import '../mackup.dart';

class EditMackup extends StatefulWidget {
  EditMackup({super.key, this.title, this.docid,this.list});
 final String? title;
  final String? docid;
  var list;

  @override
  State<EditMackup> createState() => _EditMackupState();
}

class _EditMackupState extends State<EditMackup> {
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  CollectionReference mackupref = FirebaseFirestore.instance.collection('mackup');
  add(BuildContext context) async {
    var formdata = formState.currentState;
if(file == null)
{
    if (formdata!.validate()) {
      EasyLoading.show();
      formdata.save();
        await mackupref.doc(widget.docid).update({
          'name': title,
          'def': prais,
          'doc': doc,
          'userid': FirebaseAuth.instance.currentUser!.uid,
        });
        EasyLoading.dismiss();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return Mackup(
              title: 'تعديل المنتج ',
            );
          },
        ), (route) => false);
 
    }
}else{
    if (formdata!.validate()) {
      EasyLoading.show();
      formdata.save();
      await ref?.putFile(file!);
      imageUrl = await ref?.getDownloadURL();
        await mackupref.doc(widget.docid).update({
          'name': title,
          'def': prais,
          'doc': doc,
          'image': imageUrl,
          'userid': FirebaseAuth.instance.currentUser!.uid,
        });
        EasyLoading.dismiss();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return Mackup(
              title: 'اضافه منتج ',
            );
          },
        ), (route) => false);
 
    }
}

  }

  getimage() async {
    var picked = await ImagePicker().getImage(source: ImageSource.gallery);
    if (picked != null) {
      file = File(picked.path);
      var rend = Random().nextInt(1000);
      var nameImage = "$rend" + basename(picked.path);
      ref = FirebaseStorage.instance.ref('mackup').child('$nameImage');
    }
  }

  File? file;
  Reference? ref;
  String? title, prais, imageUrl, doc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('l'),
        elevation: 0,
      ),
      body: Form(
        key: formState,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () => getimage(),
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: MediaQuery.of(context).size.width / 1.1,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.list["image"])),
                        color: Kbackdrung,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo_outlined,
                            size: 60,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          Text(
                            'تعديل الصوره',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    )),
                //! nameproudect
                Textfild(
                  initialValue:widget.list["name"],
                  // controller: fieldText1,
                  typeData: (p0) {
                    title = p0;
                  },
                  numBeg: 30,
                  numSmoL: 1,
                  password: false,
                  title: 'اسم المنتج',

                  icon: Icon(
                    Icons.production_quantity_limits_outlined,
                    size: 30,
                  ),
                  keyboardType: TextInputType.name,
                  errorBeg: '',
                  errorSmoL: '',
                ),
                //!prais
                Textfild(
                  initialValue:  widget.list["def"],
                  // controller: fieldText1,
                  typeData: (p0) {
                    prais = p0;
                  },
                  title: 'مبلغ المنتج',
                  password: false,
                  numSmoL: 2,
                  numBeg: 10,
                  icon: Icon(
                    Icons.monetization_on_outlined,
                    size: 30,
                  ),
                  keyboardType: TextInputType.number,
                  errorBeg: '',
                  errorSmoL: '',
                ),
                //!docment
                Textfild(
                  initialValue: widget.list["doc"],
                  // controller: fieldText1,
                  typeData: (p0) {
                    doc = p0;
                  },
                  title: 'تفاصيل المنتج',
                  password: false,
                  numSmoL: 6,
                  numBeg: 150,
                  icon: Icon(
                    Icons.document_scanner,
                    size: 30,
                  ),
                  keyboardType: TextInputType.name,
                  errorBeg: '',
                  errorSmoL: '',
                ),
                //! button
                PrimaryButton(
                  text: 'تعديل البيانات',
                  onPressed: () async {
                    await add(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
