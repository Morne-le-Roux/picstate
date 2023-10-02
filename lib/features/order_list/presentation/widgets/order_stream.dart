import 'package:flutter/material.dart';
import 'package:picstate/logic/logic.dart';
import 'package:simplified_flutter_animations/generic_slide_transition.dart';
import 'new_order.dart';
import '../../../../core/widgets/rounded_button.dart';
import 'order.dart';

class OrderStream extends StatefulWidget {
  const OrderStream({super.key});

  @override
  State<OrderStream> createState() => _OrderStreamState();
}

class _OrderStreamState extends State<OrderStream> {
  List<OrderWidget> orders = []; //list of tasks that the listView uses
  List<bool> ordersAnimated =
      []; //List to check if the task was animated before

  final Logic _supaBaseStuff = Logic();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: _supaBaseStuff.orderStream(),
        builder: (context, snapshot) {
          //clears task list before building new list
          orders = [];
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.amber,
            ));
          }
          //DECODE JSON DATA //wait... its not JSON!!!

          //task list builder:

          for (var order in snapshot.data) {
            orders.add(
              OrderWidget(
                id: order["id"],
                orderName: order["order_name"],
                description: order["description"],
                state: order["state"],
                index: orders.length,
                createdAt: order["created_at"],
                createdBy: order["created_by"],
                visible: true,
              ),
            );

            //adds a bool in tasksAnimated List to display animation or not.
            ordersAnimated.add(
              false,
            );
          }

          //adds extra bool for last "SpaceHolder"
          ordersAnimated.add(false);

          //sort

          int customCompare(OrderWidget a, OrderWidget b) {
            final statesOrder = ["todo", "waiting", "order", "done"];
            return statesOrder
                .indexOf(a.state)
                .compareTo(statesOrder.indexOf(b.state));
          }

          orders.sort(customCompare);

          orders.add(const OrderWidget(
              id: -1,
              orderName: "",
              state: "",
              index: 999999,
              description: "",
              createdAt: "2023-09-22T13:11:46.768585",
              createdBy: "temp",
              visible: false));

          //return

          return Stack(alignment: Alignment.bottomCenter, children: [
            ShaderMask(
              shaderCallback: (bounds) {
                return const LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black,
                    Colors.black,
                    Colors.black,
                    Colors.black,
                    Colors.black,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Container(
                margin: const EdgeInsets.only(),
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    final delay = Duration(
                        milliseconds: index * 100); //delay between widgets

                    return FutureBuilder(
                      future: Future.delayed(ordersAnimated[
                              index] //checks if task was animated before
                          ? const Duration(milliseconds: 0)
                          : delay),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (!ordersAnimated[index]) {
                            //if task was not animated b4
                            return GenericSlideTransition(
                              initialOffset: const Offset(-5, 0),
                              curve: Curves.easeInOutCubicEmphasized,
                              duration: const Duration(milliseconds: 1000),
                              builder: (context) {
                                ordersAnimated[index] =
                                    true; //Marks the widget as animated
                                return orders[index];
                              },
                            );
                          } else {
                            //if task was animated b4
                            return orders[index];
                          }
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
                  },
                ),
              ),
            ),
            //add task button
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RoundedButton(
                text: "Add Order",
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return const NewOrder();
                      });
                },
              ),
            ),
          ]);
        },
      ),
    );
  }
}
