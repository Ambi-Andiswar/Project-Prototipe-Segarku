import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:segarku/utils/constants/colors.dart';

class MidtransPaymentScreen extends StatefulWidget {
  final String snapUrl;
  final String orderId;

  const MidtransPaymentScreen({
    Key? key,
    required this.snapUrl,
    required this.orderId,
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
          error = 'Timeout: Payment process took too long';
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  void _initializeWebView() {
    try {
      print("DEBUG: Setting up WebView controller");
      
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(Colors.white)
        ..setNavigationDelegate(
          NavigationDelegate(
            onPageStarted: (String url) {
              print("DEBUG: Page started loading: $url");
              setState(() {
                isLoading = true;
                error = null;
              });
            },
            onPageFinished: (String url) {
              print("DEBUG: Page finished loading: $url");
              setState(() {
                isLoading = false;
              });
              
              // Check for success/failure URLs
              if (url.contains('payment/success')) {
                Navigator.pop(context, true);
              } else if (url.contains('payment/failed')) {
                Navigator.pop(context, false);
              }
            },
            onWebResourceError: (WebResourceError error) {
              print("DEBUG: WebView error: ${error.description}");
              setState(() {
                this.error = error.description;
                isLoading = false;
              });
            },
            onNavigationRequest: (NavigationRequest request) {
              print("DEBUG: Navigation request to: ${request.url}");
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