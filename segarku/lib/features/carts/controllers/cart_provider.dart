import 'package:get/get.dart';
import 'package:segarku/features/shop/products/data/product.dart';
import 'package:segarku/utils/constants/colors.dart';

class CartController extends GetxController {
  var cartItems = <SProduct>[].obs;
  var selectedItems = <bool>[].obs;
  var selectAll = false.obs;
  // Track items being processed for purchase
  var processingItems = <SProduct>[].obs;

  @override
  void onInit() {
    super.onInit();
    selectedItems.assignAll(List.filled(cartItems.length, false));
  }

  void addToCart(SProduct product) {
    int index = cartItems.indexWhere((item) => item.id == product.id);

    if (index != -1) {
      int totalQty = cartItems[index].qty + product.qty;

      if (totalQty <= cartItems[index].maxQuantity) {
        cartItems[index] = cartItems[index].copyWith(qty: totalQty);
      } else {
        Get.snackbar(
          "Stok Tidak Cukup",
          "Stok produk ${product.nama} tidak mencukupi.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: SColors.danger500,
          colorText: SColors.pureWhite,
        );
        return;
      }
    } else {
      if (product.qty <= product.maxQuantity) {
        cartItems.add(product);
        selectedItems.add(false);
      } else {
        Get.snackbar(
          "Stok Tidak Cukup",
          "Stok produk ${product.nama} tidak mencukupi.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: SColors.danger500,
          colorText: SColors.pureWhite,
        );
        return;
      }
    }

    update();
  }

  void removeFromCart(int index) {
    cartItems.removeAt(index);
    selectedItems.removeAt(index);
  }

  List<int> get itemQuantities => cartItems.map((item) => item.qty).toList();

  void updateQuantity(int index, int delta) {
    int newQty = (cartItems[index].qty + delta).clamp(1, cartItems[index].maxQuantity);
    cartItems[index] = cartItems[index].copyWith(qty: newQty);
  }

  int calculateTotalPrice() {
    int total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      if (selectedItems[i]) {
        total += cartItems[i].harga * cartItems[i].qty;
      }
    }
    return total;
  }

  void toggleSelectAll(bool? value) {
    selectAll.value = value ?? false;
    selectedItems.assignAll(List.filled(cartItems.length, selectAll.value));
  }

  void toggleItemSelection(int index, bool? value) {
    selectedItems[index] = value ?? false;
    selectAll.value = selectedItems.every((item) => item);
  }

  void deleteSelectedItems() {
    for (int i = selectedItems.length - 1; i >= 0; i--) {
      if (selectedItems[i]) {
        removeFromCart(i);
      }
    }
    selectAll.value = false;
  }

    // Modified to store processing items
    List<SProduct> getSelectedProducts() {
      List<SProduct> selectedProducts = [];
      for (int i = 0; i < cartItems.length; i++) {
        if (selectedItems[i]) {
          selectedProducts.add(cartItems[i]);
        }
      }
      // Store the items being processed
      processingItems.assignAll(selectedProducts);
      return selectedProducts;
    }

  double calculateSubtotal() {
    double subtotal = 0.0;
    for (var i = 0; i < cartItems.length; i++) {
      if (selectedItems[i]) {
        subtotal += cartItems[i].harga * itemQuantities[i];
      }
    }
    return subtotal;
  }

    // New method to handle successful purchase
  void handleSuccessfulPurchase() {
    try {
      // Remove all items that were being processed
      for (var purchasedItem in processingItems) {
        int index = cartItems.indexWhere((item) => item.id == purchasedItem.id);
        if (index != -1) {
          cartItems.removeAt(index);
          selectedItems.removeAt(index);
        }
      }
      
      // Clear processing items
      processingItems.clear();
      
      // Reset selection state
      selectAll.value = false;
      
      // Notify UI of changes
      update();
      
      // Show success message
      Get.snackbar(
        "Berhasil",
        "Produk yang dibeli telah dihapus dari keranjang",
        snackPosition: SnackPosition.TOP,
        backgroundColor: SColors.green500,
        colorText: SColors.pureWhite,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      print("Error removing purchased items: $e");
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat memperbarui keranjang",
        snackPosition: SnackPosition.TOP,
        backgroundColor: SColors.danger500,
        colorText: SColors.pureWhite,
      );
    }
  }

  // Modified to clear processing items if purchase is cancelled
  void clearProcessingItems() {
    processingItems.clear();
    update();
  }
}