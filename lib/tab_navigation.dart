import 'package:flutter/material.dart';

class TabNavigation extends StatelessWidget {
  TabNavigation({@required this.tabIndex, this.body});

  final Widget body;

  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
          return;
        },
        child: Scaffold(
            body: this.body,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: tabIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.list), label: 'list'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.assignment), label: 'assignment'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'profile')
              ],
            )));
  }
}
