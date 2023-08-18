import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme_and_color/app_color.dart';
import '../login_page.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final currentUser= FirebaseAuth.instance.currentUser;

  var newpassController=TextEditingController();
  static const colors = AppColors();
  var newPassword="";

  final _formKey=GlobalKey<FormState>();

  @override

  void dispose()
  {
    newpassController.dispose();
    super.dispose();
  }

  changePassword() async{
    try{
      await currentUser?.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: colors.lightCyanLogo,
          content:Text("Password has been Change.Please Login Again",
          style: TextStyle(fontSize: 15,color: Colors.white),)));
    }catch(e){

    }


  }
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
        child: Scaffold(
      body: Center(
        child: Column(
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
                          margin: EdgeInsets.only(bottom: 40),
                          child: Image.asset("assets/images/word_mark_300_rbg.png")))
              ,),
            Container(
              width: 300,
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: newpassController,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(color: Colors.blueGrey),
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(
                        color: colors.lightCyanLogo,
                        fontWeight: FontWeight.bold),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: colors.darkCyanLogo, width: 2)),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 15
                )),
                validator: (value) {
                  if(value==null || value.isEmpty){
                    return "Enter new password";
                  }
                  return null;
                },
              ),

            ),
            Container(
              margin: EdgeInsets.only(top: 30),
                width: 300,
                child: ElevatedButton(onPressed: (){
                  if(_formKey.currentState!.validate()){
                    setState(() {
                      newPassword=newpassController.text.toString();
                    });
                    changePassword();
                  }
                }, child: Text("Change Password",style:
                  TextStyle(color: Colors.white),),
                style: ButtonStyle(backgroundColor:MaterialStateProperty.all(colors.lightCyanLogo),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)))),))
          ],
        ),
      ),
    ));
  }
}
