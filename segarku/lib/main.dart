import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:segarku/app.dart';
import 'package:segarku/features/carts/controllers/cart_controller.dart';

void main() {
  // Inisialisasi GetX Controller
  Get.put(CartController());
  // Add Widgets Binding
  // Init Local Storage
  // Await Native Splash
  // Initialize Firebase
  // Initialize Authentication

  runApp(const App());
}
