import 'package:ecommerce_backend/model/models.dart';
import 'package:ecommerce_backend/services/database_services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  DataBaseServices dataBaseServices = DataBaseServices();
  var products = <Product>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    products.bindStream(dataBaseServices.getProducts());
    super.onInit();
  }

  var newProduct = {}.obs;

  get price => newProduct['price'];
  get quantity => newProduct['quantity'];

  get isRecommended => newProduct['isRecommended'];
  get isPopular => newProduct['isPopular'];

  void updateProductPrice(
    int index,
    Product product,
    double value,
  ) {
    product.price = value;
    products[index] = product;
  }

  void saveNewProductPrice(
    Product product,
    String field,
    double value,
  ) {
    dataBaseServices.updateField(product, field, value);
  }

  void saveNewProductQuantity(
    Product product,
    String field,
    int value,
  ) {
    dataBaseServices.updateField(product, field, value);
  }

  void updateProductQuantity(
    int index,
    Product product,
    int value,
  ) {
    product.quantity = value;
    products[index] = product;
  }
}
