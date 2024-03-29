import 'package:flutter/material.dart';
import 'package:picstate/features/main_screen/domain/usecases/needs_update.dart';
import 'package:picstate/features/main_screen/presentation/widgets/side_view.dart';
import 'package:picstate/features/main_screen/state.dart';
import 'package:picstate/features/whatsapp_dialing/whatsapp_chat.dart';
import 'package:picstate/config/constants.dart';
import 'package:picstate/features/todo_list/presentation/widgets/todo_stream.dart';
import 'package:provider/provider.dart';

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

//List of Destinations
  List<BottomNavigationBarItem> destinations = [
    const BottomNavigationBarItem(icon: Icon(Icons.check), label: "Job List"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.phone), label: "Whatsapp Dialer")
  ];

//currently selected button
  int _currentIndex = 0;
  int? selectedTask;
  Widget _pageToView = const ToDoStream();

//build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kBackgroundColor,
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.amber,
        items: destinations,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
            if (_currentIndex == 1) {
              _pageToView = const WhatsappChatDialer();
            } else {
              _pageToView = const ToDoStream();
            }
          });
        },
      ),
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        top: false,
        child: ChangeNotifierProvider(
          create: (context) => TaskSelectedProvider(),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                flex: MediaQuery.of(context).size.width > 1200 ? 1 : 2,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    _pageToView,

                    //Update Notifier (If not updated, display "Your app needs an update!")
                    Visibility(
                      replacement: const SizedBox.shrink(),
                      visible: needsUpdate,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Your app needs an update! Ask Morné, he probably forgot.",
                              style: kTaskTextStyle.copyWith(
                                  color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
