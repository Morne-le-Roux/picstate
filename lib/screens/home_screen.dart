import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.hasData == null &&
                    snapshot.connectionState == ConnectionState.none) {}
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {},
                );
              },
            )),
      ),
    );
  }
}
