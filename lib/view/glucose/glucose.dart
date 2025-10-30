import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/glucosemodel.dart';
import '../../presenter/glucose_presenter.dart';
import '../home/home.dart';
import 'glucoseform.dart';

class GlucosePage extends StatefulWidget {
  const GlucosePage({super.key});

  @override
  State<GlucosePage> createState() => _GlucosePageState();
}

class _GlucosePageState extends State<GlucosePage> implements GlucoseView {
  late GlucosePresenter presenter;
  int currentPageIndex = 0;
  List<Map<String, dynamic>> _readings = [];
  bool _loading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    presenter = GlucosePresenter(view: this, model: GlucoseModel());
    loadReadings();
  }

  Future<void> loadReadings() async {
  setState(() => _loading = true);
  try {
    final data = await presenter.getGlucoseReadings();
    setState(() {
      _readings = data;
      _loading = false;
    });
  } catch (e) {
    setState(() {
      _error = e.toString();
      _loading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Glucose Readings'),
        automaticallyImplyLeading: false,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : _readings.isEmpty
                  ? const Center(child: Text('No glucose readings found'))
                  : RefreshIndicator(
                      onRefresh: loadReadings,
                      child: ListView.builder(
                        itemCount: _readings.length,
                        itemBuilder: (context, index) {
                          final reading = _readings[index]['reading'];
                          final id = _readings[index]['id'];
               
                          return Card(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            child: ListTile(
                              
                              title: Text('$reading mmol/L',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                              trailing: IconButton(onPressed: (){
                                presenter.deleteGlucoseReading(id);
                                loadReadings();
                              }, icon: Icon(Icons.delete)),
                            ),
                          );
                        },
                      ),
                    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GlucoseForm()),
            );
        },
        child: const Icon(Icons.add),
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
