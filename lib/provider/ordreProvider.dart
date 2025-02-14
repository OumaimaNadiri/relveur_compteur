import 'package:assabil/models/orderdetail.dart';
import 'package:flutter/material.dart';
import 'package:assabil/models/readingorder.dart';

class OrderDetailModel extends ChangeNotifier {
  ReadingOrder? _currentOrder;
  

  ReadingOrder? get currentOrder => _currentOrder;

  void setCurrentOrder(ReadingOrder order) {
    _currentOrder = order;
    notifyListeners();
  }

   Map<String, OrderDetail> _orderDetails = {};

  OrderDetail? getOrderDetail(String orderId) {
    return _orderDetails[orderId];
  }

  void setOrderDetail(OrderDetail detail) {
    _orderDetails[detail.orderId] = detail;
    notifyListeners();
  }
}



