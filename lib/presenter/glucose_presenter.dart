import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../model/glucosemodel.dart';

abstract class GlucoseView {
  void showGlucoseData(String data);
  void showError(String message);
}

class GlucosePresenter {
  final GlucoseView view;
  final GlucoseModel model;

  GlucosePresenter({required this.view, required this.model});

  void addGlucoseReading(double reading){
   try {
      model.addGlucoseReading(reading);
   } catch (e) {
      view.showError('Failed to add glucose reading');
   }
  }

   Future<List<Map<String, dynamic>>> getGlucoseReadings() async {
    try {
      final readings = await model.getGlucoseReadings();
      return readings;
    } catch (e) {
      view.showError("Failed to fetch glucose readings: $e");
      return [];
    }
  }


  void updateGlucoseReading(String id, double newReading) {
    try {
      model.updateGlucoseReading(id, newReading);
    } catch (e) {
      view.showError('Failed to update glucose reading');
    }
  }

  void deleteGlucoseReading(String id) {
    try {
      model.deleteGlucoseReading(id);
    } catch (e) {
      view.showError('Failed to delete glucose reading');
    }
  }

}