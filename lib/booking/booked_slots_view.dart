import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_parking/booking/book_slot.dart';
import 'package:smart_parking/models/member.dart';
import 'package:smart_parking/services/database.dart';
class BookedSlotsView extends StatefulWidget {
  final uid;
  BookedSlotsView({this.uid});

  @override
  State<BookedSlotsView> createState() => _BookedSlotsViewState();
}

class _BookedSlotsViewState extends State<BookedSlotsView> {
  Map<String, dynamic> data = {};
  @override
  void initState() {
    super.initState();
    fillData();
  }
  void fillData() async{
    Map<String, dynamic> data = await Database(uid: widget.uid).retrieveSlots("regularslots");
    setState((){
      this.data = data;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 25.0),
        child: GridView.count(crossAxisCount: 2,
        mainAxisSpacing: 15.0,
        childAspectRatio: 1.7,
        crossAxisSpacing: 10.0,
        shrinkWrap: true,
        primary: false,
        children: data.entries.map((entry){
          var key = entry.key;
          var val = entry.value;
          return GridTile(child:
          Container(
            padding: EdgeInsets.all(5.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: (val == "")?Colors.blue:Colors.grey,
              borderRadius: BorderRadius.circular(5.0)
            ),
            child: TextButton(
              onPressed: () async{
                if(val == ""){
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BookSlot(slotNumber: key,)),
                  );
                  setState((){
                    val = result;
                    fillData();
                  });
                }else{
                  print("Already Booked!!!");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Alredy Booked!'),
                      duration: Duration(seconds: 2), // Adjust the duration as needed
                      action: SnackBarAction(
                        label: 'Close',
                        onPressed: () {
                        },
                      ),
                    ),
                  );
                }
              },
              child: Text("$key",style: TextStyle(
                color: Colors.black,
                fontSize: 21.0
              ),),
            ),
          ),);
        }).toList(),),
      )
    );
  }
}
