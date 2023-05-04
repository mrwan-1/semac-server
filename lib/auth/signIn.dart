
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shemac_service_provider/auth/signUp.dart';
import 'package:shemac_service_provider/auth/widgets/massege.dart';
import 'package:shemac_service_provider/auth/widgets/primary_Bottom.dart/primary_bottom.dart';
import 'package:shemac_service_provider/auth/widgets/text_bottom.dart';
import 'package:shemac_service_provider/auth/widgets/text_fild.dart';
import '../home/home_screen.dart';

class Sign extends StatefulWidget {
  static const raytsSignin = 'signin';
  const Sign({super.key});

  @override
  State<Sign> createState() => _SignState();
}

class _SignState extends State<Sign> {
  GlobalKey<FormState> formState = new GlobalKey<FormState>();

  var name,username, password,phone;
  final fieldText = TextEditingController();
  final fieldText1 = TextEditingController();

  signin() async {
    var formdata = formState.currentState;

    if (formdata!.validate()) {
      setState(() {
        showSpener = true;
      });
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: username, password: password);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          setState(() {
            showSpener = false;
          });
          awesome(
            context,
            username,
            'يرجئ التاكد من كتابت الايميل  بشكل صحيح',
            DialogType.error,
            Colors.red,
            'OK',
            () {},
          );
        } else if (e.code == 'wrong-password') {
          setState(() {
            showSpener = false;
          });
          awesome(
            context,
            'خطاء في كتابه كلمه السر ',
            'تم توفير كلمة مرور خاطئة لهذا المستخدم',
            DialogType.error,
            Colors.red,
            'OK',
          );
        } else if (e.email != username && password != null) {
          setState(() {
            showSpener = false;
          });
          awesome(context, '', 'يرجئ انشاء حساب اولا', DialogType.info,
              Colors.blue, 'انشاء حساب', () {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) {
                  return SignUp();
                },), (route) => false);
          });
        }
      }
    }
  }

  bool showSpener = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpener,
        child: ListView(
          children: [
            Form(
              key: formState,
              child: Column(
                children: [
                  // SvgPicture.asset(
                  //   'assets/icon/Mobile login-cuate.svg',
                  //   height: 370,
                  // ),
                  Image.asset('assets/image/sheimage.png',height: 320,),
                  //! userNamw
                  Textfild(
                    controller: fieldText,
                    typeData: (p0) {
                      username = p0;
                    },
                    title: 'Email@gmail.com',
                    password: false,
                    numSmoL: 4,
                    numBeg: 40,
                    icon: Icon(
                      Icons.account_circle,
                      size: 30,

                    ),
                    keyboardType: TextInputType.emailAddress,
                    errorBeg: '',
                    errorSmoL: '',
                  ),
                  //! password
                  Textfild(
                    controller: fieldText1,
                    typeData: (p1) {
                      password = p1;
                    },
                    title: 'Password',
                    password: true,
                    numSmoL: 6,
                    numBeg: 40,
                    icon: Icon(
                      Icons.lock_person_rounded,
                      size: 30,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    errorBeg: '',
                    errorSmoL: '',
                  ),
                  PrimaryButton(
                    onPressed: () async {
                      UserCredential? userCredential = await signin();

                      if (userCredential != null) {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                              return HomeScreen();
                          },), (route) => false);
                        setState(() {
                          showSpener = false;
                          // EasyLoading.dismiss();
                        });
                      } else if (username == null && password == null) {
                        EasyLoading.dismiss();
                        awesome(context, '', 'يرجئ تعبائه الحقول',
                            DialogType.error, Colors.red, 'OK');
                      }
                    }, text: 'تسجيل دخول',
                  ),
                  TextButtonWedgets(
                      title: 'انشاء حساب جديد ؟',
                      suptitle: 'انقر هنا',
                      onPressed: () async {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                          return SignUp();
                        },), (route) => false);
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
