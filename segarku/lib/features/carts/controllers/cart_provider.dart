import 'package:get/get.dart';
import 'package:segarku/features/shop/products/data/product.dart';

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
    int index = cartItems.indexWhere((item) => item.id == product.id);
    
    if (index != -1) {
      // Jika produk sudah ada, tambahkan jumlahnya
      cartItems[index] = cartItems[index].copyWith(qty: cartItems[index].qty + product.qty);
    } else {
      // Jika produk baru, tambahkan ke daftar
      cartItems.add(product);
      selectedItems.add(false);
    }
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
