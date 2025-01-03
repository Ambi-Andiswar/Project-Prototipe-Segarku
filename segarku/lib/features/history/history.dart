import 'package:flutter/material.dart';
import 'package:segarku/features/history/widget/no_history.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          // Konten di tengah-tengah layar
          Expanded(
            child: Center(
              child: NoHistoryScreen(), // Ganti dengan widget yang relevan
            ),
          ),
        ],
      ),
    );
  }
}
