
import 'package:elite_provider/loginpages/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {


        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ELITE',
            theme: ThemeData(primarySwatch: Colors.grey),
            home: SplashScreen(),
//      home: JobsScreen(),
            //home: HireGuardScreen(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container();
      },
    );

  }
}
