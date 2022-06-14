import 'package:auto_size_text/auto_size_text.dart';
import 'package:clientapp/Page.dart';
import 'package:clientapp/classe1.dart';
import 'package:clientapp/database/database.dart';
import 'package:clientapp/shared/Loading.dart';
import 'package:clientapp/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:clientapp/Home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'auth/auth.dart';

class Login extends StatefulWidget {

   Login({Key? key}) : super(key: key);

  @override

  _LoginState createState() => _LoginState();
}
 String _verificationCode="";
class _LoginState extends State<Login> {
  String code ="";
  String a="",b="",c="",d="",e="",f="";
  String _phoneNumber="";
  bool verifier = false ;
    String text ='' ;
bool loading =false ;
bool read = true ;
  TextEditingController value = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading():
      SafeArea(
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/BG.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 18.h,
                                ),
                                Container(
                                  width: 110.w,
                                  height: 40.h,
                                  child: OutlinedButton(
                                    child: AutoSizeText(
                                      "Découvrir",
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xffF54749),
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: Color(0xffF54749),
                                          width: 3,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(30))),
                                    onPressed: () {
                                      AuthService().signeInAnon();
                                      Classe1.classe=Home();
                                      Main_Page.currentindex=0;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>Main_Page()));
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                          ],
                        ),
                        Container(
                          height: 170.h,
                          width: 360.w,
                          child: Center(
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'images/man.png',
                                      ))),
                            ),
                          ),
                        ),

                        Container(
                          // width: 340.w,
                          //  height: 400.h,
                          child: Center(
                            child: Column(
                              children: [
                                Container(
                                  child: Center(
                                    child: AutoSizeText(
                                      'Connexion',
                                      textScaleFactor: 0.96.sp,
                                      style: TextStyle(
                                          fontSize: 40.sp,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30.h,),
                                Container(
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            height: 50.h,
                                            width: 288.w,
                                            color: Colors.transparent,
                                            child: Container(
                                                  height: 48.h,
                                                  width: 250.w,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Color(0xffF54749),
                                                          width: 2.5.w,
                                                          style: BorderStyle.solid),
                                                      borderRadius: BorderRadius.circular(12.sp)),
                                                  child:Row(
                                                  children:[
                                                    SizedBox(width: 10.w,),
                                                    Form(
                                                    onChanged: (){
                                                      setState(() {
                                                        text = value.text ;
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 48.h,
                                                      width: 200.w,
                                                      child: Center(
                                                        child: TextFormField(
                                                          readOnly: !read ,
                                                          textAlign:
                                                        TextAlign.left,

                                                          enabled: true,
                                                          controller: value,
                                                          decoration: InputDecoration(
                                                            counterText: "",
                                                            border: InputBorder.none,
                                                            hintText: 'Numéro de téléphone',
                                                            hintStyle: TextStyle(
                                                                color: Color(0xffa7a7a7),
                                                                fontSize: 13.sp,
                                                                fontFamily: 'poppins'),
                                                            filled: true,
                                                            fillColor: Colors.transparent,
                                                            isCollapsed: true,
                                                          ),
                                                          keyboardType: TextInputType.phone,
                                                          textInputAction: TextInputAction.done,
                                                          maxLength: 10,

                                                        ),
                                                      ),
                                                    ),

                                                  ),
                                                    text.length == 10 ?
                                                    TextButton(
                                                      onPressed: ()async {
                                                        await AuthService().singeOut();
                                                        await _signeInWithPhoneNumbre();
                                                        setState(() {


                                                          loading = true ; } );
                                                        /*   Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                Login()));*/
                                                      },
                                                      child: AutoSizeText(
                                                        'Envoyer',
                                                        style: TextStyle(
                                                          color: Color(0xffF54749),
                                                          fontSize: 14.sp,
                                                        ),
                                                      ),
                                                    ): Container() ,
                                                    ]
                                                  ),

                                                )



                                            ),
                                         ] ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                            ),
                                            width: 288.w,
                                            height: 150.h,
                                            child: Column(
                                              children: [
                                                SizedBox(height: 50.h,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .center,
                                                  children: [
                                                    _textFieldOTP(
                                                        read: read,
                                                      nemero: 0,
                                                        first: true,
                                                        last: false),
                                                    SizedBox(width: 8.w,),
                                                    _textFieldOTP(
                                                        read: read,
                                                        nemero: 1,
                                                        first: false,
                                                        last: false),
                                                    SizedBox(width: 8.w,),
                                                    _textFieldOTP(
                                                        read: read,
                                                        nemero: 2,
                                                        first: false,
                                                        last: false),
                                                    SizedBox(width: 8.w,),
                                                    _textFieldOTP(
                                                        read: read,
                                                        nemero: 3,
                                                        first:false,
                                                        last: false),
                                                    SizedBox(width: 8.w,),
                                                    _textFieldOTP(
                                                       read: read,
                                                        nemero: 4,
                                                        first: false,
                                                        last: false),
                                                    SizedBox(width: 8.w,),
                                                    _textFieldOTP(
                                                        read: read,
                                                        nemero: 5,
                                                        first: false,
                                                        last: true),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 90.h,),

                                      Container(
                                        color: Colors.transparent,
                                        child: SizedBox(
                                          width: 195.w,
                                          height: 42.h,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              code=a+b+c+d+e+f;
                                              setState(() =>
                                              loading = true);
                                               try{
                                                 UserCredential result =await FirebaseAuth.instance.signInWithCredential(PhoneAuthProvider.credential(verificationId: _verificationCode, smsCode: code));
                                                 if (result.user != null){
                                                   DatabaseService(uid: result.user!.uid).updatUserdata();
                                                   Navigator.pushReplacement(
                                                       context,
                                                       MaterialPageRoute(
                                                           builder: (context) => Wrapper()));
                                                 }
                                               }catch(e){
                                                   Navigator.pushReplacement(
                                                       context,
                                                       MaterialPageRoute(
                                                           builder: (context) => Login()));
                                               }
                                            },
                                            child: AutoSizeText(
                                              'Connexion',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.sp,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                shadowColor: Colors.grey,
                                                primary: Color(0xffF54749),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(5),
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              physics: NeverScrollableScrollPhysics(), // so it stops scrolling
            ),
          )
        ]));
  }

  Widget _textFieldOTP({bool? first, last,required int nemero , required bool read  }) {
    return Container(
      height: 45.h,
      width: 40.w,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(

          autofocus: false,
          onChanged: (value) {
            if (nemero==0){a=value;}else if (nemero==1){b=value;}else if(nemero==2){c=value;}else if(nemero==3){d=value;}else if(nemero==4){e=value;}else if(nemero==5){f=value;}
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: read,
          textAlign: TextAlign.center,
          textAlignVertical: TextAlignVertical.center,
          style: TextStyle(
            fontSize: 18.sp,
          ),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2.w, color: Colors.black12),
                borderRadius: BorderRadius.circular(5.r)),
            focusedBorder:read ?
            OutlineInputBorder(
                borderSide: BorderSide(width: 2.w, color:  Colors.black12),
                borderRadius: BorderRadius.circular(5.r))
            :OutlineInputBorder(
                borderSide: BorderSide(width: 2.w, color: Color(0xffF54749)),
                borderRadius: BorderRadius.circular(5.r)),
          ),
        ),
      ),
    );
  }

  Future _signeInWithPhoneNumbre() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "+213${_phoneNumber}",
          verificationCompleted: (PhoneAuthCredential credential) async{
            await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
            });
            setState(() {
              loading=false;
              read = false ;
            });
          },
          verificationFailed:(FirebaseException e){

            setState(() {
              loading=false;
              read=true ;
            });
            print("_____________________________________________________");
            print(e.message);
            Fluttertoast.showToast(
                msg:"Numéro téléphone invalide" ,

                fontSize: 15.sp,
                backgroundColor:Colors.white ,
                textColor: Colors.black);
          },
          codeSent: (String verifictaionID, int? resendToken) {

            setState(() {

              _verificationCode = verifictaionID;

            });
          },
          codeAutoRetrievalTimeout: (String verifictaionID) {
            setState(() {
              _verificationCode= verifictaionID;
            });
          }
          ,
          timeout: Duration(seconds: 60));

    } catch (e) {


    }
  }

}
