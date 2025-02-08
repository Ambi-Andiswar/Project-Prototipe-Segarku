class TransactionModel {
  String orderId; // Tambahkan orderId
  String userId;
  List<Map<String, dynamic>> products;
  double totalAmount;
  Map<String, dynamic> shippingAddress;
  String phone;
  String shippingMethod;
  String deliveryTime;

  TransactionModel({
    required this.orderId, // Tambahkan orderId di constructor
    required this.userId,
    required this.products,
    required this.totalAmount,
    required this.shippingAddress,
    required this.phone,
    required this.shippingMethod,
    required this.deliveryTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "order_id": orderId, // Tambahkan orderId di JSON
      "user_id": userId,
      "products": products,
      "total_amount": totalAmount,
      "shipping_address": shippingAddress,
      "phone": phone,
      "shipping_method": shippingMethod,
      "delivery_time": deliveryTime,
    };
  }
}
