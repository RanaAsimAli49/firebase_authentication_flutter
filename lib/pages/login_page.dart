import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_flutter/pages/dashboard1.dart';
import 'package:firebase_authentication_flutter/pages/forgot_password.dart';
import 'package:firebase_authentication_flutter/pages/signup_page.dart';
import 'package:firebase_authentication_flutter/pages/user/user_main.dart';
import 'package:firebase_authentication_flutter/splash_screen.dart';
import 'package:firebase_authentication_flutter/theme_and_color/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool _obscureText=true;

  var email = "";
  var password = "";

  static const colors = AppColors();

  final emailController = TextEditingController();
  final passController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
  }

  void userLogin() async {
    try {
      UserCredential userCredential=await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: colors.lightCyanLogo,
          content: Center(
            child: Text(
              "Login Successfully.",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )));
      var sharepref= await SharedPreferences.getInstance();
      sharepref.setBool(SplashScreenPageState.KEYLOGIN,true);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyDashboard(),
          ));
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
      else if(e.code=="wrong-password"){
        print("Wrong Password enter user.");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: colors.lightCyanLogo,
            content: Center(
              child: Text("Wrong Password enter user.",
                style:TextStyle(color: Colors.white,fontSize: 15,) ,),
            )));

      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Login Page"),
        //   centerTitle: true,
        // ),
        body: SafeArea(
      child: Form(
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
                    errorStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
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
                width: 300,
                margin: EdgeInsets.only(top: 10),
                child: TextFormField(
                  controller: passController,
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(color: Colors.blueGrey),
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: GestureDetector(onTap: (){
                        setState(() {
                          _obscureText=!_obscureText;
                        });
                      },child:Icon(_obscureText?Icons.visibility:Icons.visibility_off),
                      ),
                      labelStyle: TextStyle(
                          color: colors.lightCyanLogo,
                          fontWeight: FontWeight.bold),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: colors.darkCyanLogo, width: 2))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter password";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 180),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      ForgotPassword(),
                              transitionDuration: Duration(seconds: 0)));
                    },
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(color: colors.orangeLogo),
                    )),
              ),
              Container(
                  width: 300,
                  margin: EdgeInsets.only(top: 0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          email = emailController.text.toString();
                          password = passController.text.toString();
                        });
                        userLogin();
                      }
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(colors.lightCyanLogo),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21)))),
                  )),
              Container(
                child: TextButton(
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
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          children: <TextSpan>[
                        TextSpan(
                          text: "New user?",
                        ),
                        TextSpan(
                            text: " Sign Up",
                            style: TextStyle(color: colors.orangeLogo))
                      ])),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

}
