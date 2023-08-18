import 'package:firebase_authentication_flutter/pages/login_page.dart';
import 'package:firebase_authentication_flutter/pages/signup_page.dart';
import 'package:firebase_authentication_flutter/pages/user/change_password.dart';
import 'package:firebase_authentication_flutter/pages/user/user_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme_and_color/app_color.dart';

enum _MenuValues { setting, about, logout }

class MyDashboard extends StatelessWidget {
  const MyDashboard({Key? key}) : super(key: key);
  static const colors = AppColors();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Stack(
        children: [
          Container(
            height: size.height * .18,
            decoration: BoxDecoration(
              color: colors.orangeLogo,
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: colors.orangeLogo,
                  toolbarHeight: 70,
                  elevation: 0,
                  title: ListTile(
                      title: Text("Asim Ali"),
                      subtitle: Text("Welcome to Edonlink!"),
                      textColor: Colors.white),
                  actions: [
                    // popup menu button
                    PopupMenuButton<_MenuValues>(
                      itemBuilder: (context) => [
                        // popupmenu item 1
                        PopupMenuItem(
                          value: _MenuValues.setting,
                          // row has two child icon and text.
                          child: Row(
                            children: [
                              Icon(Icons.settings, color: Colors.orangeAccent),
                              SizedBox(
                                // sized box with width 10
                                width: 10,
                              ),
                              Text("Setting")
                            ],
                          ),
                        ),
                        // popupmenu item 2
                        PopupMenuItem(
                          value: _MenuValues.about,
                          // row has two child icon and text
                          child: Row(
                            children: [
                              Icon(
                                Icons.chrome_reader_mode,
                                color: Colors.orangeAccent,
                              ),
                              SizedBox(
                                // sized box with width 10
                                width: 10,
                              ),
                              Text("About")
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: _MenuValues.logout,
                          child: Row(
                            children: [
                              Icon(Icons.logout, color: Colors.orangeAccent),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Logout")
                            ],
                          ),
                        ),
                      ],
                      onSelected:(value) {
                        switch(value){
                          case _MenuValues.setting:Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePassword(),));
                          break;
                          case _MenuValues.about:Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignUp(),));
                          break;
                          case _MenuValues.logout:Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login(),));
                          break;
                        }
                      },
                      offset: Offset(0, 50),
                      color: colors.white,
                      elevation: 10,
                    ),
                  ],
                ),
                Container(
                  height: 60,
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Colors.white),
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.white)),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      hintText: "Find our Product",
                      suffixIcon: PopupMenuButton<int>(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.alarm,
                                  color: Colors.orangeAccent,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Set Alarm")
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 2,
                            // row has two child icon and text
                            child: Row(
                              children: [
                                Icon(
                                  Icons.chrome_reader_mode,
                                  color: Colors.orangeAccent,
                                ),
                                SizedBox(
                                  // sized box with width 10
                                  width: 10,
                                ),
                                Text("About")
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            child: Row(
                              children: [
                                Icon(Icons.logout, color: Colors.orangeAccent),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Logout")
                              ],
                            ),
                          ),
                        ],
                        child: Icon(Icons.menu, color: Colors.grey),
                        offset: Offset(0, 50),
                        elevation: 10,
                      ),
                    ),
                  ),
                  // color: Colors.white,
                ),
                Container(
                    height: size.height * .361,
                    margin: EdgeInsets.only(left: 10, right: 8),
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 45,
                                      child: FloatingActionButton(
                                        elevation: 0,
                                        backgroundColor: Colors.green,
                                        onPressed: () {},
                                        child: Icon(Icons.admin_panel_settings,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Text("ADMIN")
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 45,
                                      child: FloatingActionButton(
                                        elevation: 0,
                                        backgroundColor: Colors.orange.shade700,
                                        onPressed: () {},
                                        child: SizedBox(
                                          height: 25,
                                          width: 30,
                                          child: Image(
                                            image: AssetImage(
                                                "assets/icons/proj_icon1.png"),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text("PROJECTS")
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 45,
                                      child: FloatingActionButton(
                                        elevation: 0,
                                        backgroundColor: colors.lightCyanLogo,
                                        onPressed: () {},
                                        child: SizedBox(
                                          height: 25,
                                          width: 30,
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/icons/leave_icon.png"),
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Text("LEAVE")
                                  ],
                                ),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: 60,
                                      width: 45,
                                      child: FloatingActionButton(
                                        elevation: 0,
                                        backgroundColor:
                                            Colors.lightGreenAccent.shade700,
                                        onPressed: () {},
                                        child: SizedBox(
                                          height: 30,
                                          child: Image(
                                              image: AssetImage(
                                                  "assets/icons/employee_icon.png"),
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    Text("EMPLOYEE")
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Container(
                  height: size.height * .08,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      color: Colors.white),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Text(
                              "Balance",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                " Rs 999.0",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 5, right: 10),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "550 Points",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(colors.orangeLogo),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(21)))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
