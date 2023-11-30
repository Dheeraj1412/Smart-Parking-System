import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_parking/services/app_storage.dart';


class Database{
  final CollectionReference collection = FirebaseFirestore.instance.collection("users");
  final CollectionReference slotsCollection = FirebaseFirestore.instance.collection('slots');
  final uid;
  final appStorage = AppStorage();
  Database({required this.uid});


//  update image of the user
  Future updateImg(File image) async{
    var imageUrl = await appStorage.uploadImg(image, uid.toString());
    await collection.doc(uid).update({"profilePic": imageUrl});
  }

  Future updateDatabase({required userData}) async{
    return await collection.doc(uid).set(userData);
  }

  Future bookNewSlot({newSlots}) async{
    await collection.doc(uid).update({
      'booked': FieldValue.arrayUnion([newSlots]),
    });
    await slotsCollection.doc("regularslots").update({
      newSlots: uid.toString()
    });
  }

  Future bookNewStaffSlot({newSlots}) async{
    await collection.doc(uid).update({
      'booked': FieldValue.arrayUnion([newSlots+"s"]),
    });
    await slotsCollection.doc("staffslots").update({
      newSlots: uid.toString()
    });
  }

  Future removeSlot({removedSlot}) async{
    await collection.doc(uid).update({
      'booked': FieldValue.arrayRemove([removedSlot]),
    });
    await slotsCollection.doc("regularslots").update({
      removedSlot: ""
    });
  }
  Future removeStaffSlot({removedSlot}) async{
    await collection.doc(uid).update({
      'booked': FieldValue.arrayRemove([removedSlot]),
    });
    await slotsCollection.doc("staffslots").update({
      removedSlot.substring(0, removedSlot.length - 1): ""
    });
  }

  Future<Map<String, dynamic>> retrieveUserDetails() async{
    try {
      // Get the document reference
      DocumentSnapshot documentSnapshot = await collection.doc(uid).get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Access the data
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        // Print or use the data as needed
        return data;
      } else {
        print('No Data Found.');
        return {};
      }
    } catch (e) {
      print('Error retrieving data: $e');
      return {};
    }
  }
  //Retrieve slots
  Future<Map<String, dynamic>> retrieveSlots(String documentName) async {
    try {
      // Get the document reference
      DocumentSnapshot documentSnapshot = await slotsCollection.doc(documentName).get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Access the data
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        // Print or use the data as needed
        // print('Data for $documentName: $data');
        return data;
      } else {
        print('$documentName does not exist.');
        return {};
      }
    } catch (e) {
      print('Error retrieving data: $e');
      return {};
    }
  }
}