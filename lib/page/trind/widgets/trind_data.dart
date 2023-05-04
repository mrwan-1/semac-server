import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shemac_service_provider/auth/widgets/primary_Bottom.dart/primary_bottom.dart';
import 'package:shemac_service_provider/auth/widgets/text_fild.dart';
import 'package:shemac_service_provider/config.dart';
import 'package:shemac_service_provider/page/trind/trind.dart';

class TrindData extends StatefulWidget {
  TrindData({super.key, this.title});
  String? title;
  @override
  State<TrindData> createState() => _TrindDataState();
}

class _TrindDataState extends State<TrindData> {
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  CollectionReference trindref = FirebaseFirestore.instance.collection('trind');
  add(BuildContext context) async {
    var formdata = formState.currentState;
if (file == null)return         
        Get.snackbar(
            'يرجئ اختيار صوره', "لم يتم اختيار  صوره قم بختيار صور المنتج"); 
    if (formdata!.validate()) {
      EasyLoading.show();
      formdata.save();
      await ref?.putFile(file!);
      imageUrl = await ref?.getDownloadURL();
        await trindref.add({
          'name': title,
          'def': prais,
          'doc': doc,
          'image': imageUrl,
          'userid': FirebaseAuth.instance.currentUser!.uid,
        });
        EasyLoading.dismiss();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
          builder: (context) {
            return Trind(
              title: 'اضافه منتج ',
            );
          },
        ), (route) => false);
 
    }
  }

  getimage() async {
    var picked = await ImagePicker().getImage(source: ImageSource.gallery);
    if (picked != null) {
      file = File(picked.path);
      var rend = Random().nextInt(1000);
      var nameImage = "$rend" + basename(picked.path);
      ref = FirebaseStorage.instance.ref('trind').child('$nameImage');
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
                        // image: DecorationImage(image: AssetImage(widget.image)),
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
                            'اضافه صوره المنتج',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                    )),
                //! nameproudect
                Textfild(
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
                  text: 'حفظ البيانات',
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
