import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme_and_color/app_color.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static const colors = AppColors();

  final uid=FirebaseAuth.instance.currentUser?.uid;
  final emial=FirebaseAuth.instance.currentUser?.email;
  final creationTime=FirebaseAuth.instance.currentUser?.metadata.creationTime;

  User? user=FirebaseAuth.instance.currentUser;

  void verifyByEmail() async {
    if(user!=null && !user!.emailVerified){
      await user!.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: colors.lightCyanLogo,
          content:Text("Verification Email has been Sent.",
            style: TextStyle(fontSize: 15,color: Colors.white),)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("User ID : $uid",
            style: TextStyle(
              fontSize: 18
            ),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Email : $emial",
                style: TextStyle(fontSize: 18),),
                user!.emailVerified?Text("Verifed User")
                :
                TextButton(onPressed: (){
                  verifyByEmail();
                }, child: Text("Verify Email"))
              ],
            ),
            Text("Created :$creationTime ")
          ],
        ),
      ),
    ));
  }
}
