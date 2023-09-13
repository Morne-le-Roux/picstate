import 'package:flutter/material.dart';
import 'package:picstate/supabase_stuff.dart';
import 'package:simplified_flutter_animations/generic_fade_transition.dart';
import 'new_order.dart';
import 'rounded_button.dart';
import 'order.dart';

class OrderStream extends StatefulWidget {
  const OrderStream({super.key});

  @override
  State<OrderStream> createState() => _OrderStreamState();
}

class _OrderStreamState extends State<OrderStream> {
  List<OrderWidget> orders = []; //list of tasks that the listView uses
  final SupaBaseStuff _supaBaseStuff = SupaBaseStuff();
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
                    //TODO: This is not working. Try and find a resolution.
                    return FutureBuilder(
                      future:
                          Future.delayed(Duration(milliseconds: index * 1000)),
                      builder: (context, snapshot) {
                        return GenericFadeTransition(
                            curve: Curves.easeInOutCubicEmphasized,
                            duration: const Duration(milliseconds: 2000),
                            builder: (context) {
                              return orders[index];
                            });
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
