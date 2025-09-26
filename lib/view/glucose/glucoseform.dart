import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/glucosemodel.dart';
import '../../presenter/glucose_presenter.dart';

class GlucoseForm extends StatefulWidget {
  const GlucoseForm({super.key});

  @override
  State<GlucoseForm> createState() => _GlucoseFormState();
}

class _GlucoseFormState extends State<GlucoseForm> implements GlucoseView {
  late GlucosePresenter presenter;

  final TextEditingController glucoseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    presenter = GlucosePresenter(view: this, model: GlucoseModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      
      body: Center(
        child: SizedBox (
          height: double.infinity,
          width: double.infinity,

          child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 5, right:5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                const SizedBox(height: 20),
                const Text('Blood Glucose'),
                TextField(
                  controller: glucoseController,
                  decoration: const InputDecoration(
                    labelText: '80 mg/dL',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 40)),

                SizedBox(
                  width:  double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      String  glucose = glucoseController.text.trim();
                      if (glucose.isNotEmpty) {
                        presenter.addGlucoseReading(double.parse(glucose));
                      } else {
                        showError("Please enter a valid glucose reading.");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Submit',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
    );
  }


@override
void showGlucoseData(String data) {
    Fluttertoast.showToast(msg: "Glucose Readings: $data");                
  }

@override
void showError(String message) {
    Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
  }
}