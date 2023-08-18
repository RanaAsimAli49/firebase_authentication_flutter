import 'package:firebase_authentication_flutter/pages/login_page.dart';
import 'package:firebase_authentication_flutter/views/assets.dart';
import 'package:firebase_authentication_flutter/views/labels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../theme_and_color/app_color.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class onBoardingItem{
  final String image;
  final String title;
  final String description;
  const onBoardingItem(
      {required this.image, required this.title, required this.description});
}

class OnBoardingScreen1 extends HookWidget {
  const OnBoardingScreen1({Key? key}) : super(key: key);

  static const colors = AppColors();

  static const List<onBoardingItem> _items = [
    onBoardingItem(
        image: Assets.screen1,
        title: Labels.title1,
        description: Labels.description1),
    onBoardingItem(
        image: Assets.screen2,
        title: Labels.title2,
        description: Labels.description2),
    onBoardingItem(
        image: Assets.screen3,
        title: Labels.title3,
        description: Labels.description3)
  ];




  @override
  Widget build(BuildContext context) {

    void done(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login(),));

    }
    final controller = useTabController(initialLength: _items.length);

    final index=useState(0);
    controller.addListener(() {
      if(index.value!=controller.index){
        index.value=controller.index;
      }

    });

    return Scaffold(

      // floatingActionButton:Container(
      //   margin: EdgeInsets.only(bottom: 600),
      //   child: IconButton(onPressed: done,icon:Icon(Icons.cancel_outlined,color:colors.lightCyanLogo),iconSize: 30),
      // ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:
              List<Widget>.generate(_items.length,(ind) {
                return AnimatedContainer(duration: const Duration(
                  microseconds: 1 ,),
                  height: 3,
                  width: index.value==ind?25:8,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 1 ,
                  ),
                  decoration: ShapeDecoration(
                    shape: StadiumBorder(),
                    color:index.value==ind? Colors.orangeAccent:Colors.grey,
                  ),
                );
              },),
            ),

            // Row(
            //   //indicator
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   //ind means index
            //   children: List.generate(_items.length, (ind) => Container(
            //     height: 3,
            //     width: index.value==ind?45:16,
            //     margin: EdgeInsets.symmetric(horizontal: 1),
            //     decoration: ShapeDecoration(
            //       shape: StadiumBorder(),
            //       color:index.value==ind? Colors.orangeAccent:Colors.grey,
            //     ),
            //   )),
            // ),
            MaterialButton(
                onPressed: () {
                  if(controller.index<2){
                    controller.animateTo(controller.index+1);
                    index.value++;
                  }
                  else
                    {
                      done();
                    }
                },
                child: Text(index.value==2?
                  "DONE":"NEXT",
                  style: TextStyle(color: Colors.white),
                ),
                color: colors.darkCyanLogo,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18))),
          ],
        ),
      ),

      body: TabBarView(
          controller: controller,
          children: _items
              .map(
                (e) => Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20,left: 290),
                          child: TextButton(onPressed: (){
                            done();
                          }, child: Text("SKIP",style: TextStyle(color: colors.orangeLogo),))),
                      Expanded(flex: 32, child: Image.asset(e.image)),
                      Text(e.title,
                          style: TextStyle(
                              fontSize: 20,
                              color: colors.darkCyanLogo,
                              fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text(e.description,
                          style: TextStyle(
                              fontSize: 15,fontWeight: FontWeight.w500, color: colors.lightCyanLogo)),
                      Spacer(flex: 6,),
                      Spacer(flex: 4,),
                    ],
                  ),
                ),
              )
              .toList()),
    );
  }
}
