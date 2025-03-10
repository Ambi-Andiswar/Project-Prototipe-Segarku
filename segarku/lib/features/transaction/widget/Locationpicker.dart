import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';
import 'package:get/get.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  LatLng _pickedLocation = const LatLng(-6.1751, 106.8650); 
  String _address = "Sedang mencari alamat...";
  // ignore: unused_field
  late GoogleMapController _mapController;

  @override
  void initState() {
    super.initState();
    _determineCurrentLocation();
  }

  // Mendapatkan lokasi pengguna saat ini
  Future<void> _determineCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Periksa apakah layanan lokasi diaktifkan
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _address = "Layanan lokasi tidak diaktifkan.";
      });
      return;
    }

    // Periksa izin lokasi
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _address = "Izin lokasi ditolak.";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _address = "Izin lokasi ditolak secara permanen.";
      });
      return;
    }

    // Ambil lokasi saat ini
    Position position = await Geolocator.getCurrentPosition();
    _pickedLocation = LatLng(position.latitude, position.longitude);

    // Update alamat
    _getAddressFromLatLng(_pickedLocation);

    setState(() {});
  }

  // Mendapatkan alamat dari koordinat
  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks.first;
      setState(() {
        _address =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}";
      });
    } catch (e) {
      setState(() {
        _address = "Gagal mendapatkan alamat.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = context.isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Lokasi"),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _pickedLocation,
              zoom: 15,
            ),
            onMapCreated: (controller) {
              _mapController = controller;
            },
            onTap: (position) {
              setState(() {
                _pickedLocation = position;
                _address = "Sedang mencari alamat...";
              });
              _getAddressFromLatLng(position);
            },
            markers: {
              Marker(
                markerId: const MarkerId("selectedLocation"),
                position: _pickedLocation,
              ),
            },
          ),

          // Overlay Loading Jika Alamat Masih "Sedang mencari alamat..."
          if (_address == "Sedang mencari alamat...") 
            Positioned.fill(
              child: Container(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.3), // Transparan
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text(
                        "Mencari alamat...",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          Positioned(
            bottom: 100,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: dark
                  ? SColors.pureBlack
                  : SColors.pureWhite,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Alamat saat ini:",
                    style: dark
                      ? STextTheme.titleBaseBoldDark
                      : STextTheme.titleBaseBoldLight
                  ),
                  Text(_address),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _address);
              },
              child: Text(
                "Simpan Lokasi",
                style: context.isDarkMode
                  ? STextTheme.titleBaseBoldLight
                  : STextTheme.titleBaseBoldDark),
            ),
          ),
        ],
      )
    );
  }
}
