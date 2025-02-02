import 'package:get/get.dart';
import 'package:segarku/features/shop/products/data/product.dart';
import 'package:segarku/utils/constants/colors.dart';

class CartController extends GetxController {
  var cartItems = <SProduct>[].obs;
  var selectedItems = <bool>[].obs;
  var selectAll = false.obs;

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
}