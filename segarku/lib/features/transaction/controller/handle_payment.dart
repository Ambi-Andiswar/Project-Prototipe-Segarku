import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:segarku/features/carts/controllers/cart_provider.dart';
import 'package:segarku/features/personalizations/controller/user/user_service.dart';
import 'package:segarku/features/transaction/controller/transaction_api.dart';
import 'package:segarku/features/transaction/models/midtrans_payment_screen.dart';
import 'package:segarku/features/transaction/models/transaction_models.dart';
import 'package:segarku/utils/local_storage/user_storage.dart';
import 'package:flutter/material.dart';

Future<bool> handlePayment(BuildContext context, bool isDelivery, DateTime deliveryTime) async {
  final cartController = Get.find<CartController>();

  try {
    // 1. Cek API Key dan UID
    final String? apiKey = await UserStorage.getApiKey();
    final String? uid = await UserStorage.getUid();
    
    print("DEBUG: API Key: ${apiKey ?? 'null'}");
    print("DEBUG: UID: ${uid ?? 'null'}");

    if (apiKey == null || uid == null) {
      print("Error: API Key atau UID tidak ditemukan.");
      return false;
    }

    // 2. Cek User Profile dan Address
    final userProfile = await UserApiService.getCustomerProfile(uid);
    final userAddress = await UserApiService.getCustomerAddress(uid);
    
    print("DEBUG: User Profile: $userProfile");
    print("DEBUG: User Address: $userAddress");

    if (userProfile.isEmpty || userAddress.isEmpty) {
      print("Error: Data user atau alamat tidak ditemukan.");
      return false;
    }

    // 3. Cek data alamat
     final addressData = (userAddress['addresses'] as List).first;
    
      String recipientName = addressData['nama_penerima'];
      String recipientPhone = addressData['telepon'];
      String addressDetail = addressData['alamat'];
      String addressNote = addressData['catatan'];

      print("DEBUG: Recipient Name: $recipientName");
      print("DEBUG: Recipient Phone: $recipientPhone");
      print("DEBUG: Address Detail: $addressDetail");
      print("DEBUG: Address Note: $addressNote");

    // 4. Cek data produk
    final products = cartController.getSelectedProducts();
    print("DEBUG: Selected Products: ${products.length} items");
    print("DEBUG: Products Detail: ${products.map((p) => p.toJson()).toList()}");

    final subtotal = cartController.calculateSubtotal();
    final tax = subtotal * 0.05;

    // Tambahkan logika untuk ongkir berdasarkan minimum pembelian
    final deliveryFee = isDelivery ? (subtotal < 35000 ? 6000.0 : 0.0) : 0.0;
    final totalAmount = subtotal + tax + deliveryFee;


    print("DEBUG: Subtotal: $subtotal");
    print("DEBUG: Tax: $tax");
    print("DEBUG: Delivery Fee: $deliveryFee");
    print("DEBUG: Total Amount: $totalAmount");

    String orderId = "TRX-${DateTime.now().millisecondsSinceEpoch}";
    print("DEBUG: Generated Order ID: $orderId");

    // 6. Buat objek TransactionModel
    TransactionModel transaction = TransactionModel(
    orderId: orderId,
    userId: uid,
    products: [
      ...products.map((product) => {
        "id": product.id,
        "price": product.harga,
        "quantity": product.qty,
        "name": product.nama
      }).toList(),
      // Menambahkan pajak sebagai item
      {
        "id": "TAX",
        "price": tax,
        "quantity": 1,
        "name": "Pajak (5%)"
      },
      // Menambahkan biaya pengiriman jika ada dan subtotal di bawah 35000
      if (isDelivery && subtotal < 35000) {
        "id": "DELIVERY",
        "price": deliveryFee,
        "quantity": 1,
        "name": "Biaya Pengiriman"
      }
    ],
    totalAmount: totalAmount,
      shippingAddress: {
        "name": recipientName, 
        "address": addressDetail, 
        "note": addressNote 
      },
      phone: recipientPhone,
      shippingMethod: isDelivery ? "delivery" : "pickup",
      deliveryTime: DateFormat('dd/MM/yyyy HH:mm').format(deliveryTime),
    );

    print("DEBUG: Transaction Object: ${transaction.toJson()}");

    // 7. Kirim ke API dan dapatkan snapToken
    print("DEBUG: Mengirim request ke API...");
    String? snapToken = await ApiServiceTransaction.createTransaction(transaction);
    print("DEBUG: Received Snap Token: ${snapToken ?? 'null'}");

    // Perbaikan di handlePayment()
    if (snapToken != null && snapToken.isNotEmpty) {
      if (context.mounted) {
        // Gunakan format URL yang benar
        final snapUrl = "https://app.sandbox.midtrans.com/snap/v3/redirection/$snapToken";
        
        try {
          final success = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MidtransPaymentScreen(
                snapUrl: snapUrl,
                orderId: orderId,
              ),
            ),
          );
          
          // Tambahkan logging untuk debugging
          print("DEBUG: Payment screen result: $success");
          return success ?? false;
        } catch (e) {
          print("Error launching payment screen: $e");
          return false;
        }
      }
    }
    return false;
  } catch (e, stackTrace) {
    print("ERROR DETAIL:");
    print("Exception: $e");
    print("Stack Trace: $stackTrace");
    return false;
  }
}