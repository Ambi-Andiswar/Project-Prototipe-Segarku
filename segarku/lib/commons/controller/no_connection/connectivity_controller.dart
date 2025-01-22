import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  var isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _checkConnectivity();
    _setupConnectivityListener();
  }

  // Tetap private
  Future<void> _checkConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  // Metode public untuk refresh koneksi
  Future<void> refreshConnection() async {
    await _checkConnectivity();
  }

  void _setupConnectivityListener() {
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResults) {
    if (connectivityResults.contains(ConnectivityResult.none)) {
      isConnected.value = false;
    } else {
      isConnected.value = true;
    }
  }
}