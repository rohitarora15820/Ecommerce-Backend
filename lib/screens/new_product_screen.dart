import 'package:ecommerce_backend/controller/controller.dart';
import 'package:ecommerce_backend/model/models.dart';
import 'package:ecommerce_backend/services/database_services.dart';
import 'package:ecommerce_backend/services/storage_services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewProductScreen extends StatelessWidget {
  NewProductScreen({super.key});

  final ProductController productController = Get.find();
  StorageService storageServices = StorageService();
  DataBaseServices dataBaseServices = DataBaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: const Text('Add a Product'),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  child: Card(
                    color: Colors.black,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            ImagePicker imagePicker = ImagePicker();
                            final XFile? image = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            if (image == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No image selected'),
                                ),
                              );
                            }

                            if (image != null) {
                              await storageServices.uploadImage(image);
                              var imageUrl = await storageServices
                                  .getDownloadURL(image.name);
                              productController.newProduct.update(
                                  'imageUrl', (value) => imageUrl,
                                  ifAbsent: () => imageUrl);

                              print(productController.newProduct['imageUrl']);
                            }
                          },
                          icon: const Icon(Icons.add_circle),
                          color: Colors.white,
                        ),
                        const Text(
                          'Add an Image',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Product Information',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                _buildTextFormField('Product Id', 'id', productController),
                _buildTextFormField('Product Name', 'name', productController),
                _buildTextFormField(
                    'Product Description', 'description', productController),
                _buildTextFormField(
                    'Product Category', 'category', productController),
                SizedBox(
                  height: 10,
                ),
                _rowSlider(
                  'Price',
                  'price',
                  productController,
                  productController.price,
                ),
                _rowSlider(
                  'Quantity',
                  'quantity',
                  productController,
                  productController.quantity,
                ),
                SizedBox(
                  height: 10,
                ),
                _rowCheckBox('Recommended', 'isRecommended', productController,
                    productController.isRecommended),
                _rowCheckBox('Popular', 'isPopular', productController,
                    productController.isPopular),
                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        dataBaseServices.addProduct(Product(
                            id: int.parse(productController.newProduct['id']),
                            name: productController.newProduct['name'],
                            category: productController.newProduct['category'],
                            description:
                                productController.newProduct['description'],
                            imageUrl: productController.newProduct['imageUrl'],
                            price: productController.newProduct['price'],
                            quantity: productController.newProduct['quantity']
                                .toInt(),
                            isRecommended:
                                productController.newProduct['isRecommended'],
                            isPopular:
                                productController.newProduct['isPopular']));
                        // print(productController.newProduct);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          ),
        ));
  }
}

// class _rowCheckBox extends StatelessWidget {
//   final String title;
//   const _rowCheckBox({
//     Key? key,
//     this.title = 'Featured',
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
Row _rowCheckBox(String title, String name, ProductController productController,
    bool? controllerValue) {
  return Row(
    children: [
      SizedBox(
        width: 100,
        child: Text(
          title,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ),
      Checkbox(
          value: (controllerValue == null) ? false : controllerValue,
          checkColor: Colors.black,
          activeColor: Colors.black12,
          onChanged: (value) {
            productController.newProduct
                .update(name, (_) => value, ifAbsent: (() => value));
          }),
    ],
  );
}
// }

Row _rowSlider(String title, String name, ProductController productController,
    double? controllerValue) {
  return Row(
    children: [
      SizedBox(
        width: 75,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
        child: SizedBox(
          width: 175,
          child: Slider(
            value: (controllerValue == null) ? 0 : controllerValue,
            onChanged: (value) {
              productController.newProduct
                  .update(name, (_) => value, ifAbsent: (() => value));
            },
            min: 0,
            max: 100,
            divisions: 10,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
          ),
        ),
      ),
    ],
  );
}
//   }
// }

TextFormField _buildTextFormField(
    String hintText, String name, ProductController productController) {
  return TextFormField(
    decoration: InputDecoration(
      hintText: hintText,
    ),
    onChanged: (value) {
      productController.newProduct
          .update(name, (_) => value, ifAbsent: (() => value));
    },
  );
}
