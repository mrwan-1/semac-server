// ignore_for_file: prefer_typing_uninitialized_variables


import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shemac_service_provider/auth/widgets/massege.dart';
import 'package:shemac_service_provider/auth/widgets/primary_Bottom.dart/primary_bottom.dart';
import 'package:shemac_service_provider/auth/widgets/text_bottom.dart';
import 'package:shemac_service_provider/auth/widgets/text_fild.dart';
import 'signIn.dart';

class SignUp extends StatefulWidget {
  static const rautsSignUp = 'signup';
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var username, password, passwordag;
  var phone;
  String? name;
  final fieldText = TextEditingController();
  final fieldText1 = TextEditingController();
  final fieldText2 = TextEditingController();
  final fieldText3 = TextEditingController();

   
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  signUp() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      formData.save();
      try {
        setState(() {
          showSpener = true;
        });
        // EasyLoading.show();

        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: username,
          password: password,
        );
      
         
        setState(() {
          showSpener = false;
          // EasyLoading.dismiss();
        });
        fieldText.clear();
        fieldText1.clear();
        fieldText2.clear();
        fieldText3.clear();
          FirebaseFirestore.instance.collection('users').add({
          'name': name,
          'username': username,
          'password': password,
          'phone': phone,
          'userid':FirebaseAuth.instance.currentUser!.uid,
        });
        // ignore: use_build_context_synchronously
        // ignore: use_build_context_synchronously
        awesome(context, '', 'تم انشاء حساب بنجاح', DialogType.success,
            Colors.green, 'تسجيل الدخول', () {
          fieldText.clear();
          fieldText1.clear();
          fieldText2.clear();
          fieldText3.clear();

          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (context) {
                return Sign();
              },), (route) => false);
        });
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          awesome(
            context,
            '',
            '${password.toString().length}كلمة المرور المقدمة ضعيفة للغاية.',
            DialogType.error,
            Colors.red,
            'OK',
          );
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            showSpener = false;
          });
          awesome(
            context,
            username,
            'الحساب موجود بالفعل لهذا البريد الإلكتروني.',
            DialogType.error,
            Colors.red,
            'OK',
          );
        } else {
          setState(() {
            showSpener = false;
          });
          awesome(
            context,
            'Email : $username',
            'يرجئ كتابه الايميل بشكل صحيح',
            DialogType.error,
            Colors.red,
            'OK',
          );
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('dd');
    }
  }

  bool showSpener = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ModalProgressHUD(
          inAsyncCall: showSpener,
          child: ListView(
            children: [
              Form(
                key: formState,
                child: Column(
                  children: [
                    // SvgPicture.asset(
                    //   'assets/icon/Sign up-rafiki.svg',
                    //   height: 250,
                    // ),
                    Image.asset('assets/image/sheimage.png',height: 210,),
                    
                    //!name
                    Textfild(
                      controller: fieldText,
                      keyboardType: TextInputType.name,
                      typeData: (p0) {
                        name = p0;
                      },
                      title: 'Name',
                      password: false,
                      numSmoL: 2,
                      numBeg: 40,
                      icon: Icon(
                        Icons.person_outlined,
                        size: 30,
                      ),
                      errorSmoL: 'اختر اسم اطول',
                      errorBeg: 'الاسم كبير جدا',
                    ),
                    //userNmae
                    Textfild(
                      controller: fieldText1,
                      keyboardType: TextInputType.emailAddress,
                      typeData: (p1) {
                        username = p1;
                      },
                      title: 'Emile@gmail.com',
                      password: false,
                      numSmoL: 6,
                      numBeg: 40,
                      icon: Icon(
                        Icons.account_circle,
                        size: 30,
                      ),
                      errorSmoL: 'اسم المستخدم قصير',
                      errorBeg: 'اسم المستخدم كبير جدا',
                    ),
                    //!password
                    Textfild(
                      controller: fieldText2,
                      keyboardType: TextInputType.emailAddress,
                      typeData: (p2) {
                        password = p2;
                      },
                      title: 'Password',
                      password: true,
                      numSmoL: 6,
                      numBeg: 30,
                      icon: Icon(
                        Icons.lock_person_rounded,
                        size: 30,
                      ),
                      errorSmoL: 'كلمه السر ضعيفه جدا',
                      errorBeg: 'كلمه السر كبير جدا',
                    ),
                    //phone
                    Textfild(
                      maxLength: 9,
                      controller: fieldText3,
                      keyboardType: TextInputType.phone,
                      typeData: (p3) {
                        phone = p3;
                      },
                      title: 'Phone',
                      password: false,
                      numSmoL: 9,
                      numBeg: 9,
                      icon: Icon(
                        Icons.phone,
                        size: 30,
                      ),
                      errorSmoL: 'رقم الهاتف غير صحيح',
                      errorBeg: 'رقم الهاتف غير صحصح',
                    ),
                    PrimaryButton(
                        onPressed: () async {
                           await signUp();
                          print(FirebaseAuth.instance.currentUser?.uid);
                          print(username);
                          print(password);
                          print(phone);
                        }, text: 'انشاء حساب',),
                    TextButtonWedgets(
                        title: 'هل يوجد لديك حساب من قبل ؟',
                        suptitle: "تسجيل الدخول",
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,MaterialPageRoute(builder: (context) {
                                return  Sign();
                              },), (route) => false);
                        }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
