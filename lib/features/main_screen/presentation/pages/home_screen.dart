import 'package:flutter/material.dart';
import 'package:picstate/features/main_screen/domain/usecases/needs_update.dart';
import 'package:picstate/features/main_screen/presentation/widgets/side_view.dart';
import 'package:picstate/features/price_calc/presentation/widgets/price_calculator_list.dart';
import 'package:picstate/features/whatsapp_dialing/whatsapp_chat.dart';
import 'package:picstate/config/constants.dart';
import 'package:picstate/features/main_screen/presentation/widgets/menu_button.dart';
import 'package:picstate/features/todo_list/presentation/widgets/todo_stream.dart';

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
    needsUpdate = await UpdateChecker().needsUpdate();
    setState(() {});
  }

//List of menu buttons to show on main screen
  List<MenuButton> menuButtons = [
    const MenuButton(
      heading: "Todo's",
      content: "Jobs to be done",
      color: LinearGradient(colors: []),
    ),
    // const MenuButton(
    //   heading: "Orders",
    //   content: "Please Order",
    //   color: LinearGradient(colors: []),
    // ),
    const MenuButton(
      heading: "Whatsapp Dialer",
      content: "Open Whatsapp Chat",
      color: LinearGradient(colors: []),
    ),
    const MenuButton(
      heading: "Price Calculator",
      content: "Calculate Odd Pricing",
      color: LinearGradient(colors: []),
    )
  ];

//currently selected button
  int selectedButton = -1;
  int? selectedTask;
  bool desktopMode = false;

//build
  @override
  Widget build(BuildContext context) {
    //Checks selected Button
    Widget widgetToshow = const SizedBox();

    if (selectedButton == 0) {
      widgetToshow = const ToDoStream();
    }
    if (selectedButton == 1) {
      widgetToshow = const WhatsappChatDialer();
    }
    if (selectedButton == 2) {
      widgetToshow = const PriceCalculatorList();
    }

    //gets screen width and ajusts columns
    double screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 700) {
      desktopMode = true;
    }
    if (screenWidth <= 699) {
      desktopMode = false;
    }

    //return
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: false,
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: MediaQuery.of(context).size.width > 1200 ? 1 : 2,
              child: Column(
                children: [
                  //Menu Buttons
                  GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
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
                                : const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                        Colors.white,
                                        Colors.white
                                      ]), //color if not selected
                          ),
                        );
                      })),

                  const SizedBox(
                    height: 20,
                  ),
                  //Shows selected item
                  widgetToshow,

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
            Visibility(
                visible: desktopMode,
                child: Expanded(
                  flex: 2,
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.1,
                              color: const Color.fromARGB(255, 59, 59, 59))),
                      child: const SideView()),
                )),
          ],
        ),
      ),
    );
  }
}
