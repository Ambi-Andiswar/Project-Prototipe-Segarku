import 'package:get/get.dart';

class UserController extends GetxController {
  var userName = ''.obs;
  var userEmail = ''.obs;
  var userPhone = ''.obs;
  var userPhotoUrl = ''.obs;

  void setUserData(String name, String email, String phone, String photoUrl) {
    userName.value = name;
    userEmail.value = email;
    userPhone.value = phone;
    userPhotoUrl.value = photoUrl;
  }
}