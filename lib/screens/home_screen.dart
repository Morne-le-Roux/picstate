import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';
import 'package:picstate/supabase_stuff.dart';
import 'package:picstate/custom_widgets/top_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool needsUpdate = false;

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  checkForUpdate() async {
    needsUpdate = await SupaBaseStuff().needsUpdate();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(
          children: [
            const TopBar(), //yellow border line thingy.

//Update Notifier
            Visibility(
              replacement: const SizedBox.shrink(),
              visible: needsUpdate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 80,
                    decoration: const BoxDecoration(color: Colors.red),
                    child: Text(
                      "Your app needs an update!",
                      style: kTaskTextStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
