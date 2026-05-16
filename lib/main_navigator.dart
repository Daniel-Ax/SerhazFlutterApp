import 'beer_card.dart';
import 'beer_page.dart';
import 'custom_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'main.dart';
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() =>
      _MainNavigationPageState();
}

class _MainNavigationPageState
    extends State<MainNavigationPage> {

  int currentIndex = 0;

  final pages = [

    Home(),

    BeersPage(),

    Placeholder(),

    Placeholder(),

    Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: pages[currentIndex],

      bottomNavigationBar: CustomBottomNav(

        currentIndex: currentIndex,

        onTap: (index) {

          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}