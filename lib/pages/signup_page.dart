import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_flutter/pages/login_page.dart';
import 'package:firebase_authentication_flutter/theme_and_color/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static const colors = AppColors();

  bool _obscureText=true;

  var email = "";
  var password = "";
  var confirmPassword = "";

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPasswController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    confirmPasswController.dispose();
    super.dispose();
  }

  void registration() async {
    if (password == confirmPassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: colors.lightCyanLogo,
            content: Center(
              child: Text(
                "Registration Successfully.",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            )));
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ));
      } on FirebaseAuthException catch (e) {
        if (e.code == "weak-password") {
          print("Password provided is too week.");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: colors.lightCyanLogo,
              content: Center(
                child: Text(
                    "Password provided is too week.",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              )));
        } else if (e.code == "email-already-in-use") {
          print("Account aleardy exists.");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: colors.lightCyanLogo,
              content: Center(
                child: Text(
                    "Account aleardy exists.",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              )));
        }
      }
    } else {
      print("Password and Confirm Password doesn't match.");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: colors.lightCyanLogo,
          content: Center(
            child: Text(
              "Password and Confirm Password doesn't match.",
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          )));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: Text("Login Page"),
        //   centerTitle: true,
        // ),
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
                          margin: EdgeInsets.only(bottom: 20),
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
                      color: colors.lightCyanLogo, fontWeight: FontWeight.bold),
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
                        borderSide:
                            BorderSide(color: colors.darkCyanLogo, width: 2))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter password";
                  }
                  return null;
                },
              ),
            ),
            Container(
              width: 300,
              margin: EdgeInsets.only(top: 10),
              child: TextFormField(
                controller: confirmPasswController,
                keyboardType: TextInputType.visiblePassword,
                style: TextStyle(color: Colors.blueGrey),
                obscureText: _obscureText,
                decoration: InputDecoration(
                    labelText: "Confirm Password",
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
                        borderSide:
                            BorderSide(color: colors.darkCyanLogo, width: 2))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Confirm password";
                  }
                  return null;
                },
              ),
            ),
            Container(
                width: 300,
                margin: EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        email = emailController.text.toString();
                        password = passController.text.toString();
                        confirmPassword =
                            confirmPasswController.text.toString();
                      });
                      registration();
                    }
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: colors.white),
                  ),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(colors.lightCyanLogo),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21)))),
                )),
            Container(
              margin: EdgeInsets.only(top: 5),
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Login(),
                          transitionDuration: Duration(seconds: 0)));
                },
                child: RichText(
                    text: TextSpan(
                        style: TextStyle(
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        children: <TextSpan>[
                      TextSpan(
                        text: "Already hava an Account?",
                      ),
                      TextSpan(
                          text: " Login",
                          style: TextStyle(color: colors.orangeLogo))
                    ])),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
