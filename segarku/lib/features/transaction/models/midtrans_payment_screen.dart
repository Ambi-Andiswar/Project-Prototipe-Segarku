import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:segarku/features/carts/controllers/cart_provider.dart';
import 'package:segarku/features/transaction/transaction_success.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:intl/intl.dart';

class MidtransPaymentScreen extends StatefulWidget {
  final String snapUrl;
  final String orderId;
  final double totalAmount;
  final String deliveryTime;
  final String shippingMethod;

  const MidtransPaymentScreen({
    Key? key,
    required this.snapUrl,
    required this.orderId,
    required this.totalAmount,
    required this.deliveryTime,
    required this.shippingMethod,
  }) : super(key: key);

  @override
  _MidtransPaymentScreenState createState() => _MidtransPaymentScreenState();
}

class _MidtransPaymentScreenState extends State<MidtransPaymentScreen> {
  late final WebViewController _controller;
  bool isLoading = true;
  String? error;
  Timer? _timeoutTimer;

  @override
  void initState() {
    super.initState();
    print("DEBUG: Initializing MidtransPaymentScreen");
    print("DEBUG: Snap URL: ${widget.snapUrl}");
    _initializeWebView();
    _startTimeoutTimer();
  }

  void _startTimeoutTimer() {
    _timeoutTimer = Timer(const Duration(minutes: 5), () {
      if (mounted) {
        setState(() {
          error = 'Timeout: Proses pembayaran terlalu lama';
          isLoading = false;
        });
      }
    });
  }

  void _handlePaymentSuccess(String transactionStatus, String paymentType) {
    final cartController = Get.find<CartController>();
    final DateTime deliveryDateTime = DateTime.parse(widget.deliveryTime);

    // Get detailed payment type from URL or response
    String detailedPaymentType = paymentType;
    
    // If the URL contains specific VA info, use that
    if (paymentType == 'bank_transfer') {
      if (widget.snapUrl.contains('bca')) {
        detailedPaymentType = 'bca_va';
      } else if (widget.snapUrl.contains('bri')) {
        detailedPaymentType = 'bri_va';
      } else if (widget.snapUrl.contains('bni')) {
        detailedPaymentType = 'bni_va';
      } else if (widget.snapUrl.contains('mandiri')) {
        detailedPaymentType = 'mandiri_va';
      } else if (widget.snapUrl.contains('permata')) {
        detailedPaymentType = 'permata_va';
      }
    }

    // Only remove items from cart if payment is actually completed
    if (transactionStatus == 'settlement' || transactionStatus == 'capture') {
      // Remove purchased items from cart
      cartController.handleSuccessfulPurchase();
    } else {
      // Clear processing items if payment is not completed
      cartController.clearProcessingItems();
    }
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionSuccess(
          orderId: widget.orderId,
          totalAmount: widget.totalAmount,
          paymentStatus: transactionStatus == 'settlement' ? 'Selesai' : 'Pending',
          paymentMethod: _formatPaymentMethod(detailedPaymentType),
          deliveryTime: DateFormat('HH:mm').format(deliveryDateTime),
          deliveryDate: DateFormat('dd/MM/yyyy').format(deliveryDateTime),
          shippingMethod: widget.shippingMethod,
        ),
      ),
    );
  }

  String _formatPaymentMethod(String paymentType) {
    switch (paymentType.toLowerCase()) {
      case 'bank_transfer':
        return 'Transfer Bank';
      case 'gopay':
        return 'GoPay';
      case 'shopeepay':
        return 'ShopeePay';
      case 'qris':
        return 'QRIS';
      case 'credit_card':
        return 'Kartu Kredit';
      case 'bca_va':
        return 'BCA Virtual Account';
      case 'bni_va':
        return 'BNI Virtual Account';
      case 'bri_va':
        return 'BRI Virtual Account';
      case 'mandiri_va':
        return 'Mandiri Virtual Account';
      case 'permata_va':
        return 'Permata Virtual Account';
      default:
        return paymentType;
    }
  }

  void _initializeWebView() {
    try {
      print("DEBUG: Setting up WebView controller");
      
      _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (String url) {
            print("DEBUG: Page finished loading: $url");
            setState(() {
              isLoading = false;
            });
              
              if (url.contains('status_code=')) {
              // Parse URL dengan lebih detail
              final uri = Uri.parse(url);
              print("DEBUG: Full URL parameters: ${uri.queryParameters}");
              
              final statusCode = uri.queryParameters['status_code'];
              final transactionStatus = uri.queryParameters['transaction_status'];
              
              // Dapatkan payment type dengan lebih detail
              String paymentType = 'Unknown';
              
              // Cek berbagai parameter yang mungkin berisi informasi pembayaran
              if (uri.queryParameters['payment_type'] != null) {
                  paymentType = uri.queryParameters['payment_type']!;
                } else if (uri.queryParameters['payment_method'] != null) {
                  paymentType = uri.queryParameters['payment_method']!;
                } else if (url.contains('gopay')) {
                  paymentType = 'gopay';
                } else if (url.contains('shopeepay')) {
                  paymentType = 'shopeepay';
                } else if (url.contains('qris')) {
                  paymentType = 'qris';
                }
                
                print("DEBUG: Payment Type detected: $paymentType");

                if (statusCode == '200' && transactionStatus != null) {
                  _handlePaymentSuccess(transactionStatus, paymentType);
                }
              }
            },

            onNavigationRequest: (NavigationRequest request) {
              print("DEBUG: Navigation request to: ${request.url}");
              final url = request.url.toLowerCase();
              
              if (url.contains('status_code=') && url.contains('transaction_status=')) {
                final uri = Uri.parse(url);
                final statusCode = uri.queryParameters['status_code'];
                final transactionStatus = uri.queryParameters['transaction_status'];
                final paymentType = uri.queryParameters['payment_type'] ?? 'Unknown';

                if (statusCode == '200' && transactionStatus != null) {
                  _handlePaymentSuccess(transactionStatus, paymentType);
                  return NavigationDecision.prevent;
                }
              }
              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(widget.snapUrl));

      print("DEBUG: WebView controller initialized successfully");
    } catch (e) {
      print("ERROR: WebView initialization failed - $e");
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }
  

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    final cartController = Get.find<CartController>();
    cartController.clearProcessingItems();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool shouldPop = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Batalkan Pembayaran?'),
            content: const Text('Apakah Anda yakin ingin membatalkan proses pembayaran?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Tidak'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Ya'),
              ),
            ],
          ),
        );
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pembayaran"),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              bool shouldClose = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Batalkan Pembayaran?'),
                  content: const Text('Apakah Anda yakin ingin membatalkan proses pembayaran?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Tidak'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Ya'),
                    ),
                  ],
                ),
              );
              if (shouldClose) {
                Navigator.pop(context, false);
              }
            },
          ),
        ),
        body: Stack(
          children: [
            if (error != null)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Error: $error"),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          error = null;
                          isLoading = true;
                        });
                        _initializeWebView();
                      },
                      child: const Text("Coba Lagi"),
                    ),
                  ],
                ),
              )
            else
              WebViewWidget(controller: _controller),
              
            if (isLoading && error == null)
              Container(
                color: Colors.white70,
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(SColors.green500),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}