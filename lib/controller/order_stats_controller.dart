import 'package:ecommerce_backend/model/order_stats_model.dart';
import 'package:ecommerce_backend/services/database_services.dart';
import 'package:get/get.dart';

class OrderStatsController extends GetxController {
  final DataBaseServices _dataBase = DataBaseServices();

  var stats = Future.value(<OrderStats>[]).obs;

  @override
  void onInit() {
    stats.value = _dataBase.getOrderStats();
    super.onInit();
  }
}
