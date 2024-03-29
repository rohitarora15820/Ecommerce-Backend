import 'package:ecommerce_backend/screens/orders_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My eCommerece Backend',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        getPages: [
          GetPage(name: '/home', page: () => HomeScreen()),
          GetPage(name: '/products', page: () => ProductsScreen()),
          GetPage(
              name: '/products/new-product', page: () => NewProductScreen()),
          GetPage(name: '/orders', page: () => OrdersScreen()),
        ]);
  }
}
