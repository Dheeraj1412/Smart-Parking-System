import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_parking/home/wrapper.dart';
import 'package:smart_parking/models/member.dart';
import 'package:smart_parking/services/auth.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Member?>.value(
        value: Auth().user,
        initialData: null,
        child: MaterialApp(
          title: "SmartParking",
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        )
    );
  }
}