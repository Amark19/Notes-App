import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notesapp/pages/Home.dart';
import 'package:notesapp/pages/createnote.dart';
import 'package:notesapp/pages/editnote.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyD7FE74zUPYwSCKFOUVvID9QsBOjZgB30g",
      appId: "1:839789642688:android:26af499c2c18c74ee4fe25",
      messagingSenderId: "XXX",
      projectId: "notes-app-6d792",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application name
      title: 'Create,save your notes',
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey[850], brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/createnote': (context) => Createnote()
      },
    );
  }
}
