import 'package:ecommerce_backend/controller/order_stats_controller.dart';
import 'package:ecommerce_backend/model/order_stats_model.dart';
import 'package:ecommerce_backend/screens/orders_screen.dart';
import 'package:ecommerce_backend/screens/screens.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  OrderStatsController _orderStatsController = Get.put(OrderStatsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text('My eCommerece'),
        ),
        body: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder(
                  future: _orderStatsController.stats.value,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                          height: 250,
                          padding: EdgeInsets.all(10),
                          child: CustomBarChart(orderStats: snapshot.data));
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
              // Container(
              //     height: 250,
              //     padding: EdgeInsets.all(10),
              //     child: CustomBarChart(orderStats: OrderStats.data)),
              Container(
                  width: double.infinity,
                  height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => ProductsScreen());
                    },
                    child: const Card(
                      child: Center(child: Text('Go to Products')),
                    ),
                  )),
              Container(
                  width: double.infinity,
                  height: 150,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      Get.to(() => OrdersScreen());
                    },
                    child: const Card(
                      child: Center(child: Text('Go to Orders')),
                    ),
                  )),
            ],
          ),
        ));
  }
}

class CustomBarChart extends StatelessWidget {
  const CustomBarChart({super.key, required this.orderStats});

  final List<OrderStats> orderStats;

  @override
  Widget build(BuildContext context) {
    List<charts.Series<OrderStats, String>> series = [
      charts.Series(
          id: 'orders',
          data: orderStats,
          domainFn: (series, _) =>
              DateFormat.d().format(series.dateTime).toString(),
          // series.index.toString(),
          measureFn: (series, _) => series.orders,
          colorFn: (series, _) => series.barColor!)
    ];
    return series.isEmpty
        ? Container()
        : charts.BarChart(series, animate: true);
  }
}
