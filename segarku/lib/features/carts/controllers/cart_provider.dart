import 'package:get/get.dart';
import 'package:segarku/features/shop/products/data/product.dart';
import 'package:segarku/utils/constants/colors.dart';

class CartController extends GetxController {
  var cartItems = <SProduct>[].obs; // Produk dalam keranjang
  var selectedItems = <bool>[].obs; // Status pilihan tiap item
  var selectAll = false.obs; // Status "Pilih Semua"

  @override
  void onInit() {
    super.onInit();
    selectedItems.assignAll(List.filled(cartItems.length, false));
  }

  // 🛒 Tambahkan produk ke keranjang
  void addToCart(SProduct product) {
  // Cari produk yang sudah ada di keranjang
    int index = cartItems.indexWhere((item) => item.id == product.id);

    if (index != -1) {
      // Jika produk sudah ada, hitung total qty yang akan ditambahkan
      int totalQty = cartItems[index].qty + product.qty;

      // Periksa apakah total qty melebihi stok yang tersedia
      if (totalQty <= product.qty) {
        // Jika tidak melebihi, update jumlahnya
        cartItems[index] = cartItems[index].copyWith(qty: totalQty);
      } else {
        // Jika melebihi, tampilkan pesan error (opsional)
        Get.snackbar(
          "Stok Tidak Cukup",
          "Stok produk ${product.nama} tidak mencukupi.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: SColors.danger500,
          colorText: SColors.pureWhite,
        );
        return; // Hentikan proses penambahan
      }
    } else {
      // Jika produk belum ada, periksa apakah qty yang diminta melebihi stok
      if (product.qty <= product.qty) {
        // Jika tidak melebihi, tambahkan produk ke keranjang
        cartItems.add(product);
        selectedItems.add(false);
      } else {
        // Jika melebihi, tampilkan pesan error (opsional)
        Get.snackbar(
          "Stok Tidak Cukup",
          "Stok produk ${product.nama} tidak mencukupi.",
          snackPosition: SnackPosition.TOP,
          backgroundColor: SColors.danger500,
          colorText: SColors.pureWhite,
        );
        return; // Hentikan proses penambahan
      }
    }

    update(); // Perbarui UI
  }


  // 🗑 Hapus produk dari keranjang
  void removeFromCart(int index) {
    cartItems.removeAt(index);
    selectedItems.removeAt(index);
  }
  List<int> get itemQuantities => cartItems.map((item) => item.qty).toList();
  // 🔄 Update kuantitas produk tertentu
  void updateQuantity(int index, int delta) {
    int newQty = (cartItems[index].qty + delta).clamp(1, 100);
    cartItems[index] = cartItems[index].copyWith(qty: newQty);
  }

  // 💰 Hitung total harga barang yang dipilih
  int calculateTotalPrice() {
    int total = 0;
    for (int i = 0; i < cartItems.length; i++) {
      if (selectedItems[i]) {
        total += cartItems[i].harga * cartItems[i].qty;
      }
    }
    return total;
  }
  

  // 🔘 Pilih semua item di keranjang
  void toggleSelectAll(bool? value) {
    selectAll.value = value ?? false;
    selectedItems.assignAll(List.filled(cartItems.length, selectAll.value));
  }

  // ✅ Pilih item tertentu
  void toggleItemSelection(int index, bool? value) {
    selectedItems[index] = value ?? false;
    selectAll.value = selectedItems.every((item) => item);
  }

  // 🚮 Hapus semua item yang dipilih
  void deleteSelectedItems() {
    for (int i = selectedItems.length - 1; i >= 0; i--) {
      if (selectedItems[i]) {
        removeFromCart(i);
      }
    }
    selectAll.value = false;
  }
}
