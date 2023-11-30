import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_parking/models/member.dart';
import 'package:smart_parking/services/database.dart';
import 'package:smart_parking/styles/common_styles.dart';

class BookSlot extends StatelessWidget {
  final slotNumber;
  final staff;
  BookSlot({this.slotNumber, this.staff=false});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Member?>(context)??null;
    return Scaffold(
      appBar: AppBar(
        title: Text("Slot Booking"),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 50.0,),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
              child: CommonStyles.CardText("Booking Slot No: $slotNumber", 32.0),
            ),
            SizedBox(
              height: 100.0,
            ),
            TextButton(onPressed: () async{
              if(user?.uid != null){
                if(!staff)
                  await Database(uid: user!.uid).bookNewSlot(newSlots: slotNumber);
                else
                  await Database(uid: user!.uid).bookNewStaffSlot(newSlots: slotNumber);
                print("Booked");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Booking Successful!'),
                    duration: Duration(seconds: 2), // Adjust the duration as needed
                    action: SnackBarAction(
                      label: 'Close',
                      onPressed: () {
                      },
                    ),
                  ),
                );
                Navigator.pop(context, user.uid);
              }
            },
            style: ButtonStyle(
              shape: MaterialStateProperty.resolveWith((states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), // Adjust the value as needed
              )),
              padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(
                vertical: 25.0,
                horizontal: 50.0
              )),
              backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue)
            ),
            child: Text("Book", style: TextStyle(
              color: Colors.black,
              fontSize: 32.0
            ),))
          ],
        ),
      ),
    );
  }
}
