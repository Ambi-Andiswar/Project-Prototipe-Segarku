import 'package:flutter/material.dart';
import 'package:segarku/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:segarku/features/carts/controllers/cart_provider.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';


void main()async {
  Get.put(CartController());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}
