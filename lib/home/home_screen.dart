import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_parking/booking/remove_slot.dart';
import 'package:smart_parking/models/member.dart';
import 'package:smart_parking/services/database.dart';
import 'package:smart_parking/styles/authstyles.dart';
import 'package:smart_parking/styles/common_styles.dart';
class HomeScreen extends StatefulWidget {
  final uid;
  const HomeScreen({this.uid});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: (db.length > 0)?
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
                        height: 30.0,
                      ),
                      Text((db['booked'].isEmpty)?"No Slots Booked":"Booked Slots:", style: TextStyle(
                          color: Colors.white60,
                          fontSize: 27.0
                      )),
                      SizedBox(
                        height: 20.0,
                      ),
                      GridView.count(crossAxisCount: 2,
                        mainAxisSpacing: 15.0,
                        childAspectRatio: 1.7,
                        crossAxisSpacing: 10.0,
                        shrinkWrap: true,
                        primary: false,
                        children: [...db['booked'].map((key){
                          return GridTile(child:
                          Container(
                            padding: EdgeInsets.all(5.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: TextButton(
                              onPressed: () async{
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => RemoveSlot(slotNumber: key, staff: key.contains('s'),)),
                                );
                                setState((){
                                  result;
                                  fillData();
                                });
                              },
                              child: Text("$key",style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 21.0
                              ),),
                            ),
                          ),);
                        })],)
                    ],
                  ):Container()
            ),
      ),
    );
  }
}
