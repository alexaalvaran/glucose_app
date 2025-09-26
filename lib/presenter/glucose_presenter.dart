import 'package:firebase_auth/firebase_auth.dart';

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

  void getGlucoseReadings() {
    try {
      model.getGlucoseReadings().then((snapshot) {
        String data = snapshot.docs.map((doc) => doc['reading'].toString()).join(', ');
        view.showGlucoseData(data);
      });
    } on FirebaseException catch (e) {
      if (e.code == 'not-found'){
        view.showError('No glucose data found.');
      } else {
        view.showError('An error occurred while fetching glucose data.');
      }
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