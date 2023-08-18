import 'dart:async';
import 'package:firebase_authentication_flutter/main.dart';
import 'package:firebase_authentication_flutter/pages/dashboard1.dart';
import 'package:firebase_authentication_flutter/pages/login_page.dart';
import 'package:firebase_authentication_flutter/pages/user/user_main.dart';
import 'package:firebase_authentication_flutter/views/onboarding_screen1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>SplashScreenPageState();

}

class SplashScreenPageState extends State<SplashScreen>{

  static const String KEYLOGIN="login";
  @override
  void initState() {
    super.initState();
    WhereToGo();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              onEnd: (){print('Complete');},
              curve: Curves.bounceInOut,
              tween: Tween(begin:0.5 ,end: 1.0),
              duration:Duration(seconds: 2) ,
              builder: (BuildContext context,valuj,Mywidget)=>
                  Opacity(
                      opacity: valuj,
                      child: Container(
                          height: 80,
                          width: 80,
                          child: Image.asset("assets/images/word_mark_300_rbg.png"))),
            ),
          ],),
      ),
    );
  }

  void WhereToGo() async{
    var sharepref= await SharedPreferences.getInstance();
    var isLoggedIn=sharepref.getBool(KEYLOGIN);
    Timer(
      Duration(seconds: 1),
          () {
        if(isLoggedIn!=null){
          if(isLoggedIn){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyDashboard(),));
          }
          else{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoardingScreen1(),));
          }

        }
        else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OnBoardingScreen1(),));
        }

      },
    );
  }
}

