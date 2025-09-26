import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../glucose/glucose.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<Widget> pages = [
    Center(child: Text('Home Page')),
    Center(child: Text('Glucose Page')),
  ];

  void onItemTapped(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}