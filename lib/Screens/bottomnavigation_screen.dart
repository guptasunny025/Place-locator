
import 'package:flutter/material.dart';
import 'package:place/Screens/homescreen.dart';

class BottomNavigationScreen extends StatefulWidget {
  @override
  _BottomNavigationScreenState createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
 

  @override
  void initState() {
    super.initState();
    _index = 0;
  }

  bool selectedText = false;
  int _index = 0;

  @override
  Widget build(BuildContext context) {
        final devicesize = MediaQuery.of(context).size;
     List _bottomnavigation = [
    {
      'icon': Image.asset('assets/Frame.png',width: devicesize.width/4/4,height: devicesize.height/4/4/2,),
      'label': 'Feed',
    },
    {
      'icon': Image.asset('assets/Frame-1.png',width: devicesize.width/4/4,height: devicesize.height/4/4/2,),
      'label': 'Companies',
    },
    {
      'icon': Image.asset('assets/Frame-3.png',width: devicesize.width/4/4,height: devicesize.height/4/4/2,),
      'label': 'Jobs',
    },
     {
      'icon': Image.asset('assets/Frame-2.png',width: devicesize.width/4/4,height: devicesize.height/4/4/2,),
      'label': 'Projects',
    },
     {
      'icon': Image.asset('assets/Frame-4.png',width: devicesize.width/4/4,height: devicesize.height/4/4/2,),
      'label': 'Forum',
    },
  ];
    late Widget _child;
    switch (_index) {
      case 0:
        _child = HoemScreen();
        break;
      case 1:
        _child = HoemScreen();
        break;
      case 2:
        _child = HoemScreen();
        break;
         case 3:
        _child = HoemScreen();
        break;
         case 4:
        _child = HoemScreen();
        break;
    }
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      body: SafeArea(child: _child),  
      bottomNavigationBar: BottomNavigationBar(
        elevation: 3,
        selectedItemColor: Color(0xFF8BC441),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
       // onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        items: [
          ..._bottomnavigation.map(
            (bottomitem) => BottomNavigationBarItem(
              icon: bottomitem['icon'],
              backgroundColor:
                  selectedText == false ? Colors.grey : Color(0xFF8BC441),
              label: bottomitem['label'],
            ),
          )
        ],
      ),
    );
  }
}
