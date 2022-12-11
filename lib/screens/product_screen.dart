import 'package:ecommerce_backend/controller/product_controller.dart';
import 'package:ecommerce_backend/model/models.dart';
import 'package:ecommerce_backend/screens/screens.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsScreen extends StatelessWidget {
  ProductsScreen({super.key});

  final ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text('Products'),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: Card(
                  color: Colors.black,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(() => NewProductScreen());
                        },
                        icon: const Icon(Icons.add_circle),
                        color: Colors.white,
                      ),
                      Text(
                        'Add a New Product',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                      itemCount: productController.products.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                            height: 210,
                            child: ProductCard(
                                productController.products[index], index));
                      }),
                ),
              )
            ],
          ),
        ));
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  final int index;

  ProductCard(this.product, this.index, {super.key});

  final ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              'Price',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 175,
                            child: Slider(
                              value: product.price,
                              onChanged: (value) {
                                productController.updateProductPrice(
                                    index, product, value);
                              },
                              onChangeEnd: (value) {
                                productController.saveNewProductPrice(
                                    product, 'price', value);
                              },
                              min: 0,
                              max: 25,
                              divisions: 10,
                              activeColor: Colors.black,
                              inactiveColor: Colors.grey,
                            ),
                          ),
                          Text(
                            '\$${product.price.toStringAsFixed(1)}',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 50,
                            child: Text(
                              'Quantity',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 175,
                            child: Slider(
                              value: product.quantity.toDouble(),
                              onChanged: (value) {
                                productController.updateProductQuantity(
                                    index, product, value.toInt());
                              },
                              onChangeEnd: (value) {
                                productController.saveNewProductQuantity(
                                    product, 'quantity', value.toInt());
                              },
                              min: 0,
                              max: 100,
                              divisions: 10,
                              activeColor: Colors.black,
                              inactiveColor: Colors.grey,
                            ),
                          ),
                          Text(
                            product.quantity.toInt().toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
