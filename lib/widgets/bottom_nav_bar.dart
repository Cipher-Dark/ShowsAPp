import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/screens/search_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.black,
          child: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home),
                text: "home",
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              )
            ],
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: const TabBarView(
          children: [
            HomeScreen(),
            SearchScreen(),
          ],
        ),
      ),
    );
  }
}
