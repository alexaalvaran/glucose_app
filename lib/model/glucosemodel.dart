
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_core/firebase_core.dart';


class GlucoseModel {

  final FirebaseFirestore _glucose = FirebaseFirestore.instance;

  Future<void> addGlucoseReading(double reading) async {
    await _glucose.collection('glucose_readings').add({
      'reading': reading,
      'timestamp': Timestamp.now(),
    });
  }

  Future<List<Map<String, dynamic>>> getGlucoseReadings() async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _glucose.collection('glucose_readings')
        .orderBy('timestamp', descending: true)
        .get();

    List<Map<String, dynamic>> documents = [];
    for (var doc in querySnapshot.docs) {
      documents.add({
        'id': doc.id, // 🔹 Include the document ID
        ...doc.data(), // 🔹 Spread the actual Firestore data
      });
    }
    return documents;
  } catch (e) {
    print("Error getting documents: $e");
    return [];
  }
}


  Future<void> updateGlucoseReading(String id, double newReading) async {
    await _glucose.collection('glucose_readings').doc(id).update({
      'reading': newReading,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteGlucoseReading(String id) async {
    await _glucose.collection('glucose_readings').doc(id).delete();
  }
}