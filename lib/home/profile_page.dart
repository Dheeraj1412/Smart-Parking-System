import 'package:flutter/material.dart';
import 'package:smart_parking/services/database.dart';
class ProfilePage extends StatefulWidget {
  final uid;
  ProfilePage({this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var db = {};
  @override
  initState(){
    super.initState();
    fillData();
  }
  void fillData() async{
    var data = await Database(uid: widget.uid).retrieveUserDetails();
    setState((){
      this.db = (data==null)?{}:data;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Profile Data", style: TextStyle(
              color: Colors.white60,
              fontSize: 42.0
          ),),
          (db.length > 0)?
              Column(
                children: [
                  SizedBox(
                    height: 25.0,
                  ),
                  Text("Name: ${db['name']}", style: TextStyle(
                      color: Colors.white60,
                      fontSize: 28.0
                  )),
                  SizedBox(
                    height: 25.0,
                  ),
                  Text("Phone: ${db['phone']}", style: TextStyle(
                      color: Colors.white60,
                      fontSize: 28.0
                  )),
                  SizedBox(
                    height: 30.0,
                  ),
                ],
              ):Container()
        ],
      ),
    );
  }
}
