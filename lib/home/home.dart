import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:smart_parking/booking/booked_slots_view.dart';
import 'package:smart_parking/booking/staff_slots_view.dart';
import 'package:smart_parking/home/profile_page.dart';
import 'package:smart_parking/models/member.dart';
import 'package:smart_parking/services/auth.dart';
import 'package:smart_parking/services/database.dart';
import 'package:smart_parking/styles/authstyles.dart';

import 'home_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var user = null;
  var name = "";
  bool staff = false;
  final List<BottomNavigationBarItem> items = [
  ];
  int selectedPage = 0;
  var currIndex = 0;
  @override
  Widget build(BuildContext context) {
    this.user = Provider.of<Member?>(context)??null;
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: Text("Smart Parking"),
        actions: [
          TextButton.icon(
              onPressed: () async {
                await Auth().signOut();
              },
              icon: Icon(
                Icons.logout,
                color: Colors.red,
              ),
              label: Text("Logout", style: TextStyle(color: Colors.white)))
        ],
      ),
      body: Container(
        child: getBody(selectedPage),
      ),
      drawer: Drawer(
        backgroundColor: Colors.redAccent,
        child: ListView(
          children: [
            DrawerHeader(child: Text((user!=null)?getName():"Nav Bar", style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w800
            ),)),
            ListTile(
              title: Text("Profile page", style: AuthStyle().textStyle(),),
              onTap: ()=>setState((){
                selectedPage = 3;
                Navigator.pop(context);
              }),
            ),
            ListTile(
              title: Text("Home", style: AuthStyle().textStyle(),),
              onTap: ()=>setState((){
                selectedPage = 0;
                Navigator.pop(context);
              }),
            ),
            ListTile(
              title: Text("Book Slots View", style: AuthStyle().textStyle(),),
              onTap: ()=>setState((){
                selectedPage = 1;
                Navigator.pop(context);
              }),
            ),
            (staff)?ListTile(
              title: Text("Staff Slots View", style: AuthStyle().textStyle(),),
              onTap: ()=>setState((){
                selectedPage = 2;
                Navigator.pop(context);
              }),
            ):Container()
          ],
        ),
      ),
    );
  }

  Widget getBody(int index){
    switch(index){
      case 0: return HomeScreen(uid: user?.uid);
      case 1: return BookedSlotsView(uid: user?.uid,);
      // case 1: return Profile();
      case 2: return StaffSlotsView(uid: user?.uid);
      case 3: return ProfilePage(uid: user?.uid);
      default: return HomeScreen(uid: user?.uid);
    }
  }
  void updateName(uid) async{
    Map<String, dynamic> res = await Database(uid: uid).retrieveUserDetails();
    name = (res.isEmpty)?"":res['name'];
    staff = (res.isEmpty)?false:res['staff'];
    setState((){});
  }

  String getName(){
    if(name == ""){
      updateName(user?.uid);
      return "";
    }else{
      return name;
    }
  }
}
