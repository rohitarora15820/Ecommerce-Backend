import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_backend/model/models.dart';
import 'package:ecommerce_backend/model/models.dart' as orderModel;
import 'package:ecommerce_backend/model/order_stats_model.dart';
// import 'package:ecommerce_backend/model/models.dart';

class DataBaseServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<OrderStats>> getOrderStats() async {
    return await _firestore
        .collection('order_stats')
        .orderBy('dateTime')
        .get()
        .then((querySnapShot) => querySnapShot.docs.asMap().entries.map((e) {
              return OrderStats.fromSnapshot(e.value, e.key);
            }).toList());
  }

  Stream<List<orderModel.Order>> getOrder() {
    return _firestore.collection('orders').snapshots().map((snapshot) =>
        snapshot.docs
            .map((doc) => orderModel.Order.fromSnapshot(doc))
            .toList());
  }

  Stream<List<orderModel.Order>> getPendingOrder() {
    return _firestore
        .collection('orders')
        .where('isDelivered', isEqualTo: false)
        .where('isCancelled', isEqualTo: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => orderModel.Order.fromSnapshot(doc))
            .toList());
  }

  Stream<List<Product>> getProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Product.fromSnapshots(doc)).toList());
  }

  Future<void> addProduct(Product product) async {
    await _firestore.collection('products').add(product.toMap());
  }

  Future<void> updateField(
      Product product, String field, dynamic newValue) async {
    await _firestore
        .collection('products')
        .where('id', isEqualTo: product.id)
        .get()
        .then((querySnapShot) =>
            querySnapShot.docs.first.reference.update({field: newValue}));
  }

  Future<void> updateOrder(
      orderModel.Order order, String field, dynamic newValue) async {
    await _firestore
        .collection('orders')
        .where('id', isEqualTo: order.id)
        .get()
        .then((querySnapShot) =>
            querySnapShot.docs.first.reference.update({field: newValue}));
  }
}
