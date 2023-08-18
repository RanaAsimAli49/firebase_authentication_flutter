import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_authentication_flutter/pages/login_page.dart';
import 'package:firebase_authentication_flutter/pages/user/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../splash_screen.dart';
import '../../theme_and_color/app_color.dart';
import 'change_password.dart';
import 'dashboard.dart';

class UserMain extends StatefulWidget {
  const UserMain({Key? key}) : super(key: key);

  @override
  State<UserMain> createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {

  static const colors = AppColors();

  int _selectedIndex=0;

  static List<Widget>_widgetOptions=<Widget>[
    Dashboard(),
    Profile(),
    ChangePassword()
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex=index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Welcome User"),
            ElevatedButton(onPressed: () async{
              await FirebaseAuth.instance.signOut();
              var sharepref= await SharedPreferences.getInstance();
              sharepref.setBool(SplashScreenPageState.KEYLOGIN,false);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login(),),(route) => false,);
            }, child: Text("Logout"),style: ElevatedButton.styleFrom(primary: colors.orangeLogo),)
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items:const <BottomNavigationBarItem> [
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.person),
          label: "My Profile"),
          BottomNavigationBarItem(icon: Icon(Icons.settings),
          label: "Change Password"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: colors.orangeLogo,
        onTap:_onItemTapped ,
      ),
    );
  }
}
