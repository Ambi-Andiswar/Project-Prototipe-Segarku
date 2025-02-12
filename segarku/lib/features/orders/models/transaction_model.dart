// transaction_history_model.dart
class TransactionHistoryModel {
  final String orderId;
  final String userId;
  final List<ProductHistory> products;
  final double totalAmount;
  final String paymentStatus;
  final String paymentMethod;
  final String deliveryTime;
  final String deliveryDate;
  final String shippingMethod;

  TransactionHistoryModel({
    required this.orderId,
    required this.userId,
    required this.products,
    required this.totalAmount,
    required this.paymentStatus,
    required this.paymentMethod,
    required this.deliveryTime,
    required this.deliveryDate,
    required this.shippingMethod,
  });

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) {
    return TransactionHistoryModel(
      orderId: json['order_id'],
      userId: json['user_id'],
      products: (json['products'] as List)
          .map((product) => ProductHistory.fromJson(product))
          .toList(),
      totalAmount: json['total_amount'].toDouble(),
      paymentStatus: json['payment_status'],
      paymentMethod: json['payment_method'],
      deliveryTime: json['delivery_time'],
      deliveryDate: json['delivery_date'],
      shippingMethod: json['shipping_method'],
    );
  }
}

class ProductHistory {
  final String name;
  final String size;
  final double price;
  final String image;
  final String date;

  ProductHistory({
    required this.name,
    required this.size,
    required this.price,
    required this.image,
    required this.date,
  });

  factory ProductHistory.fromJson(Map<String, dynamic> json) {
    return ProductHistory(
      name: json['name'],
      size: json['size'] ?? '1kg/pack',
      price: json['price'].toDouble(),
      image: json['image'] ?? '',
      date: json['date'],
    );
  }

  Map<String, String> toDisplayMap() {
    return {
      'name': name,
      'size': size,
      'price': 'Rp ${price.toStringAsFixed(0)}',
      'image': image,
      'date': date,
    };
  }
}

