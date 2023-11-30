import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_parking/models/member.dart';
import 'package:smart_parking/services/database.dart';

class RemoveSlot extends StatelessWidget {
  final slotNumber;
  final staff;

  RemoveSlot({this.slotNumber, this.staff=false});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Member?>(context) ?? null;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text("Slot Releasing"),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 50.0,),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
              child: Text("Remove Slot No: $slotNumber", style: TextStyle(
                color: Colors.white54,
                fontSize: 32.0
              ),),
            ),
            SizedBox(
              height: 100.0,
            ),
            TextButton(
                onPressed: () async {
                  if (user?.uid != null) {
                    if(staff)
                      await Database(uid: user!.uid)
                          .removeStaffSlot(removedSlot: slotNumber);
                    else
                      await Database(uid: user!.uid)
                          .removeSlot(removedSlot: slotNumber);

                    print("Removed Booking!!!");
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Released Successful!'),
                          duration: Duration(seconds: 2), // Adjust the duration as needed
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {
                            },
                          ),
                        ),
                    );
                    Navigator.pop(context, slotNumber);
                  }
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Adjust the value as needed
                            )),
                    padding: MaterialStateProperty.resolveWith((states) =>
                        EdgeInsets.symmetric(vertical: 25.0, horizontal: 50.0)),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.red)),
                child: Text(
                  "Remove",
                  style: TextStyle(color: Colors.black, fontSize: 32.0),
                ))
          ],
        ),
      ),
    );
  }
}
