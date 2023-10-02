import 'package:flutter/material.dart';
import 'package:picstate/features/whatsapp_dialing/whatsapp_chat.dart';
import 'package:picstate/config/constants.dart';
import 'package:picstate/custom_widgets/menu_button.dart';
import 'package:picstate/logic/order_stream.dart';
import 'package:picstate/logic/todo_stream.dart';
import 'package:picstate/logic/logic.dart';

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
  int buttonRowCount = 2;

//build
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 500) {
      buttonRowCount = 4;
    }
    if (screenWidth <= 499) {
      buttonRowCount = 2;
    }
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
                crossAxisCount: buttonRowCount,
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
                          ? kSelectedMenuButtonColor //color if selected
                          : kMenuButtonColor, //color if not selected
                    ),
                  );
                })),

            const SizedBox(
              height: 20,
            ),
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

                if (selectedButton == 2) {
                  widgetToshow = const WhatsappChatDialer();
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
