import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';
import 'package:picstate/custom_widgets/task.dart';
import 'package:picstate/supabase_stuff.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskWidget> tasks = [];
  final SupaBaseDoStuff _supaBaseDoStuff = SupaBaseDoStuff();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: StreamBuilder(
              stream: _supaBaseDoStuff.listenToTasks(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

//DECODE JSON DATA
                var taskData = jsonDecode(snapshot.data.toString());
                print(taskData);

                return ListView(
                  children: const [],
                );
              },
            )),
      ),
    );
  }
}
