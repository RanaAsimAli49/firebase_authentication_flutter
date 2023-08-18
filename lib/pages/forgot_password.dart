import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_flutter/pages/login_page.dart';
import 'package:firebase_authentication_flutter/pages/signup_page.dart';
import '../theme_and_color/app_color.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  static const colors = AppColors();

  final _formKey = GlobalKey<FormState>();

  var email = "";

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print("Sent email");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: colors.lightCyanLogo,
          content: Center(
            child: Text("Password Reset Email has been sent!.",
              style: TextStyle(color: Colors.white, fontSize: 15),),
          )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No user found for that Email.");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: colors.lightCyanLogo,
            content: Center(
              child: Text(
                "No user found for that Email.",
                style: TextStyle(fontSize: 15, color: colors.white),
              ),
            )));
      }
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
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
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Colors.blueGrey),
                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                          color: colors.lightCyanLogo,
                          fontWeight: FontWeight.bold),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                          BorderSide(color: colors.darkCyanLogo, width: 2)),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 15)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter an email";
                    } else if (!value.contains("@edonlink.com")) {
                      return "Enter valid email";
                    }
                    else if(value.contains(" ")){
                      return "Enter valid email";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 160),
                child: TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                  Login(),
                              transitionDuration: Duration(seconds: 0)),
                              (route) => false);
                    },
                    child: RichText(
                        text: TextSpan(
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(text: "Already Account?"),
                              TextSpan(
                                  text: " Login",
                                  style: TextStyle(color: colors.orangeLogo))
                            ]))),
              ),
              Container(
                width: 300,
                margin: EdgeInsets.only(top: 0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        email = emailController.text.toString();
                      });
                      resetPassword();
                    }
                  },
                  child:
                  Text("Send Email", style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(colors.lightCyanLogo),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21)))),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                SignUp(),
                            transitionDuration: Duration(seconds: 0)),
                            (route) => false);
                  },
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(text: "Don't have an Account?"),
                            TextSpan(
                                text: " Sign Up",
                                style: TextStyle(color: colors.orangeLogo))
                          ])))
            ],
          ),
        ),
      ),
    );
  }
}




