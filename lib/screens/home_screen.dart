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

//List of menu buttons to show on main screen
  List<MenuButton> menuButtons = [
    MenuButton(
      heading: "Todo's",
      content: "Jobs to be done",
      color: kButtonColor,
    ),
    MenuButton(
      heading: "Orders",
      content: "Please Order",
      color: kButtonColor,
    ),
    MenuButton(
      heading: "Whatsapp Dialer",
      content: "Open Whatsapp Chat",
      color: kButtonColor,
    ),
    MenuButton(
      heading: "Price Calculator",
      content: "Calculate Odd Pricing",
      color: kButtonColor,
    )
  ];

//currently selected button
  int selectedButton = -1;

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
                childAspectRatio: 2,
                children: List.generate(menuButtons.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedButton = index;
                      });
                    },
                    child: MenuButton(
                      heading: menuButtons[index].heading,
                      content: menuButtons[index].content,
                      color: selectedButton == index
                          ? kSelectedButtonColor
                          : kButtonColor,
                    ),
                  );
                })),

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
