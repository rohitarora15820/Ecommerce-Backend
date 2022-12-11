import 'package:ecommerce_backend/controller/order_controller.dart';
import 'package:ecommerce_backend/model/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('Orders'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                  itemCount: orderController.pendindOrders.length,
                  itemBuilder: ((context, index) {
                    return OrderCard(
                        order: orderController.pendindOrders[index]);
                  })),
            ),
          )
        ],
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  OrderCard({super.key, required this.order});
  final OrderController orderController = Get.find();
  final Order order;
  // const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    var products = Product.products
        .where((element) => order.productIds.contains(element.id))
        .toList();
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Card(
        margin: EdgeInsets.all(0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order Id: ${order.id}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    DateFormat('dd-MM-yy').format(order.createdAt),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: Image.network(
                            products[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              products[index].name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 285,
                              child: Text(
                                products[index].description,
                                style: TextStyle(fontSize: 12),
                                overflow: TextOverflow.clip,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }),
                itemCount: products.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "Delivery Fee",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${order.deliveryFee}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${order.total}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  order.isAccepted
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            minimumSize: Size(150, 40),
                          ),
                          onPressed: () {
                            orderController.updateOrder(
                                order, 'isDelivered', !order.isDelivered);
                          },
                          child: Text(
                            "Delivered",
                            style: TextStyle(fontSize: 12),
                          ))
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black,
                            minimumSize: Size(150, 40),
                          ),
                          onPressed: () {
                            orderController.updateOrder(
                                order, 'isAccepted', !order.isAccepted);
                          },
                          child: Text(
                            "Accept",
                            style: TextStyle(fontSize: 12),
                          )),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        minimumSize: Size(150, 40),
                      ),
                      onPressed: () {
                        orderController.updateOrder(
                            order, 'isCancelled', !order.isCancelled);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(fontSize: 12),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
