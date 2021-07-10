import 'package:e_commerce/constant.dart';
import 'package:e_commerce/models/order.dart';
import 'package:e_commerce/screens/admin/order_details.dart';
import 'package:e_commerce/services/store.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static String id = "OrderScreen";
  final Store _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text('there is no orders'),
            );
          } else {
            List<Order> orders = [];
            for (var doc in snapshot.data.doc) {
              orders.add(Order(
                  documentId: doc.id,
                  totalPrice: doc.data[kTotalPrice],
                  address: doc.data[kAddress]));
            }
            return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, OrderDetails.id,
                              arguments: orders[index].documentId);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          color: kSecondryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Total Price =${orders[index].totalPrice}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Address is ${orders[index].address}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
          }
        },
      ),
    );
  }
}
