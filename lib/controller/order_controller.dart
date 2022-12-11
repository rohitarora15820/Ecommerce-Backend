import 'package:ecommerce_backend/model/models.dart';
import 'package:ecommerce_backend/services/database_services.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  DataBaseServices dataBaseServices = DataBaseServices();

  var orders = <Order>[].obs;
  var pendindOrders = <Order>[].obs;

  @override
  void onInit() {
    orders.bindStream(dataBaseServices.getOrder());
    pendindOrders.bindStream(dataBaseServices.getPendingOrder());
    super.onInit();
  }

  void updateOrder(Order order, String field, dynamic newValue) {
    dataBaseServices.updateOrder(order, field, newValue);
  }
}
