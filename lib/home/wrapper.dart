import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_parking/auth/authenticate.dart';
import 'package:smart_parking/home/home.dart';
import 'package:smart_parking/models/member.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Member?>(context);
    print(user);
    if(user == null) {
      return Authenticate();
    } else {
      return const Home();
    }
  }
}
