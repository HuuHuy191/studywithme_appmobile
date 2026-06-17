import 'package:flutter/material.dart';

import 'my_class_screen.dart';
import 'join_class_screen.dart';

class ClassScreen extends StatelessWidget {
  const ClassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(

      length: 2,

      child: Scaffold(

        appBar: AppBar(
          title: const Text("Class"),

          bottom: const TabBar(
            tabs: [
              Tab(text: "My Class"),
              Tab(text: "Join Class"),
            ],
          ),
        ),

        body: const TabBarView(
          children: [
            MyClassScreen(),
            JoinClassScreen(),
          ],
        ),
      ),
    );
  }
}