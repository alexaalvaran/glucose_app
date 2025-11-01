
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GlucoseModel {

  final FirebaseFirestore _glucose = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addGlucoseReading(double reading) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) throw Exception('User not logged in');
  final uid = user.uid;

  await _glucose
      .collection('users')
      .doc(uid)
      .collection('glucose_readings')
      .add({
    'reading': reading,
    'timestamp': Timestamp.now(),
  });

  }

  Future<List<Map<String, dynamic>>> getGlucoseReadings() async {
  
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) throw Exception('User not logged in');
  final uid = user.uid;
  
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _glucose
        .collection('users')
        .doc(uid)
        .collection('glucose_readings')
        .orderBy('timestamp', descending: true)
        .get();

    List<Map<String, dynamic>> documents = [];
    for (var doc in querySnapshot.docs) {
      documents.add({
        'id': doc.id, 
        ...doc.data(),
      });
    }
    return documents;
  } catch (e) {
    print("Error getting documents: $e");
    return [];
  }
}

  Future<void> updateGlucoseReading(String id, double newReading) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) throw Exception('User not logged in');
  final uid = user.uid;

    await _glucose
    .collection('users')
    .doc(uid)
    .collection('glucose_readings').doc(id).update({
      'reading': newReading,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteGlucoseReading(String id) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) throw Exception('User not logged in');
  final uid = user.uid;

    await _glucose
    .collection('users')
    .doc(uid)
    .collection('glucose_readings').doc(id).delete();
  }
}