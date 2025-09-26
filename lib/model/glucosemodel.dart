
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class GlucoseModel {

  final FirebaseFirestore _glucose = FirebaseFirestore.instance;

  Future<void> addGlucoseReading(double reading) async {
    await _glucose.collection('glucose_readings').add({
      'reading': reading,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<QuerySnapshot> getGlucoseReadings() async {
    return await _glucose.collection('glucose_readings').orderBy('timestamp', descending: true).get();
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