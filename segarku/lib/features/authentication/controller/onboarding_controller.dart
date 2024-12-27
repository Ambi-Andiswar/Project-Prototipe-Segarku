import 'dart:async'; // Tambahkan jika belum ada
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:segarku/navigation_menu.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  /// Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
  Timer? _autoScrollTimer; // Timer untuk auto-scroll

  /// Update Current Index when Page Scroll
  void updatePageIndicator(index) {
    currentPageIndex.value = index;

    // Mulai ulang auto-scroll jika pengguna menggulir secara manual
    startAutoScroll();
  }

  /// Jump to the specific dot selected page.
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpToPage(index);

    // Mulai ulang auto-scroll saat pindah halaman manual
    startAutoScroll();
  }

  /// Update Current Index & jump to next page
  void nextPage() {
    if (currentPageIndex.value < 2) { // Cek batas maksimum
      int page = currentPageIndex.value + 1;
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    } else {
      // Pindah ke NavigationMenu jika di halaman terakhir
      Get.offAll(() => const NavigationMenu());
      stopAutoScroll(); // Hentikan auto-scroll di halaman terakhir
    }
  }

  /// Update Current Index & jump to previous page
  void previousPage() {
    if (currentPageIndex.value > 0) { // Cek batas minimum
      int page = currentPageIndex.value - 1;
      pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  /// Start Auto-Scroll Timer
  void startAutoScroll() {
    // Hentikan timer yang berjalan sebelumnya
    stopAutoScroll();

    // Mulai timer baru
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (currentPageIndex.value < 2) {
        nextPage(); // Pindah ke halaman berikutnya
      } else {
        stopAutoScroll(); // Hentikan auto-scroll di halaman terakhir
      }
    });
  }

  /// Stop Auto-Scroll Timer
  void stopAutoScroll() {
    _autoScrollTimer?.cancel();
  }

  @override
  void onClose() {
    _autoScrollTimer?.cancel(); // Hentikan timer saat controller ditutup
    super.onClose();
  }
}
