import 'package:flutter/material.dart';
import 'package:picstate/logic/logic.dart';
import 'package:simplified_flutter_animations/generic_slide_transition.dart';
import '../custom_widgets/new_order.dart';
import '../custom_widgets/rounded_button.dart';
import '../custom_widgets/order.dart';

class OrderStream extends StatefulWidget {
  const OrderStream({super.key});

  @override
  State<OrderStream> createState() => _OrderStreamState();
}

class _OrderStreamState extends State<OrderStream> {
  List<OrderWidget> orders = []; //list of tasks that the listView uses
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
                visible: true,
              ),
            );
          }

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
                      future: Future.delayed(delay),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return GenericSlideTransition(
                            initialOffset: const Offset(-5, 0),
                            curve: Curves.easeInOutCubicEmphasized,
                            duration: const Duration(milliseconds: 1000),
                            builder: (context) {
                              return orders[index];
                            },
                          );
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
