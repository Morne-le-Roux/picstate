import 'package:flutter/material.dart';
import 'package:picstate/constants.dart';
import 'package:picstate/custom_widgets/menu_button.dart';
import 'package:picstate/logic_and_streams/order_stream.dart';
import 'package:picstate/logic_and_streams/todo_stream.dart';
import 'package:picstate/logic_and_streams/logic.dart';

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

    //Checks if the app is updated (version number is hosted on supabase)
    checkForUpdate();
  }

  checkForUpdate() async {
    needsUpdate = await Logic().needsUpdate();
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

//build
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
//Menu Buttons
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
                      color: selectedButton == index //is selected?
                          ? kSelectedButtonColor //color if selected
                          : kButtonColor, //color if not selected
                    ),
                  );
                })),

//Shows selected item
            FutureBuilder(
              builder: (context, snapshot) {
                Widget widgetToshow = const SizedBox();

                if (selectedButton == 0) {
                  widgetToshow = const ToDoStream();
                }
                if (selectedButton == 1) {
                  widgetToshow = const OrderStream();
                }

                return widgetToshow;
              },
            ),

//Update Notifier (If not updated, display "Your app needs an update!")
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
          ],
        ),
      ),
    );
  }
}
