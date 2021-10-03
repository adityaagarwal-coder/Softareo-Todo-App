import 'package:flutter/material.dart';
import 'package:flutter_application_7/pages/homepage.dart';
import 'package:flutter_application_7/routes/routes.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      MyRoutes.homeroute: (context) => Home(),
    });
  }
}
