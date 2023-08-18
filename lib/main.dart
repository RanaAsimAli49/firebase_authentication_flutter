import 'package:firebase_authentication_flutter/splash_screen.dart';
import 'package:firebase_authentication_flutter/theme_and_color/app_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  static const colors = AppColors();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        //check for errors
        if (snapshot.hasError) {
          print("Somrthing went wrong.");
        }
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Center(child: CircularProgressIndicator());
        // }
        return MaterialApp(
          title: "Edon Link ERP",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch:Colors.blue),
          home:SplashScreen(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Authentication"),
        centerTitle: true,
      ),
      body: Column(),
    );
  }
}
