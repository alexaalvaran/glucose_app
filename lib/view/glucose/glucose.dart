import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/glucosemodel.dart';
import '../../presenter/glucose_presenter.dart';
import '../home/home.dart';
import 'glucoseform.dart';

class GlucosePage extends StatefulWidget {
  GlucosePage({super.key});

  @override
  State<GlucosePage> createState() => _GlucosePageState();
}

class _GlucosePageState extends State<GlucosePage> implements GlucoseView {
  late GlucosePresenter presenter;
  int currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    presenter = GlucosePresenter(view: this, model: GlucoseModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glucose Readings'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
           showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(15),
                   ),
                backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Add Glucose Reading"),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
        content: SizedBox(
          height: 250,
          width: double.maxFinite,
          child: GlucoseForm(), 
        ),
      );
    },
  );
          },
          child: const Text('+ Add Glucose Reading'),
          ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
            if (index == 0)
            {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
            } else if (index == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => GlucosePage()));  
            }
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Glucose',
          ),
        ],
      ),



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
