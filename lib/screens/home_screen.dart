import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';
import 'package:picstate/custom_widgets/menu_button.dart';
import 'package:picstate/supabase_stuff.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PRINT&IMAGE CENTRE',
          style: kTaskTextStyle.copyWith(
              fontStyle: FontStyle.italic, color: Colors.white60, fontSize: 30),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            // const TopBar(), //yellow border line thingy.

            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              children: const [
                MenuButton(
                  heading: "Todo's",
                  content: "Jobs to be done",
                ),
                MenuButton(heading: "Orders", content: "Please Order"),
                MenuButton(
                    heading: "Whatsapp Dialer", content: "Open Whatsapp Chat"),
                MenuButton(
                    heading: "Price Calculator",
                    content: "Calculate Odd Pricing")
              ],
            ),

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
            ),

            //BOTTOM NAVBAR
          ],
        ),
      ),
    );
  }
}
