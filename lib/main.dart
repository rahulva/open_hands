import 'package:flutter/material.dart';
import 'package:open_hands/app/profile/user_registration_view.dart';
import 'app/home/my_home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: 'Open Hands',
      // theme:  ThemeData(
      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   primarySwatch: Colors.green,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      //   useMaterial3: true,
      // ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: UserRegistrationView(),
    );
  }
}
