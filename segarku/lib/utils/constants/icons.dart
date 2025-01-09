// Untuk mengakses Icon

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:iconsax/iconsax.dart';
import 'package:segarku/utils/constants/colors.dart';

class SIcons {
  // Universal Arrow
  static const IconData arrowLeft = HugeIcons.strokeRoundedArrowLeft01;
  static const IconData arrowRight = HugeIcons.strokeRoundedArrowRight01;
  static const IconData arrowUp = HugeIcons.strokeRoundedArrowUp01;
  static const IconData arrowDown = HugeIcons.strokeRoundedArrowDown01;
  static const IconData left = HugeIcons.strokeRoundedArrowLeft02;
  static const IconData right = HugeIcons.strokeRoundedArrowRight02;
  static const IconData up = HugeIcons.strokeRoundedArrowUp02;
  static const IconData down = HugeIcons.strokeRoundedArrowDown02;
  static const IconData delet = HugeIcons.strokeRoundedDelete02;

  // Security
  static const IconData eye = Iconsax.eye;
  static const IconData eyeSlash = Iconsax.eye_slash;

  // Navigation_Menu
  static const IconData home = HugeIcons.strokeRoundedHome03;
  static const IconData cart = HugeIcons.strokeRoundedShoppingBasket03;
  static const IconData history = HugeIcons.strokeRoundedTask02;
  static const IconData profile = HugeIcons.strokeRoundedUser;

  // General 
  static const IconData search = HugeIcons.strokeRoundedSearch01;
  static const IconData chat = HugeIcons.strokeRoundedBubbleChat;
  static const IconData addToCart = HugeIcons.strokeRoundedShoppingBasketAdd01;
  static const IconData add = HugeIcons.strokeRoundedAdd01;
  static const IconData location = HugeIcons.strokeRoundedLocation06;
  static const IconData voucher = HugeIcons.strokeRoundedCouponPercent;
  static const IconData editProfile = HugeIcons.strokeRoundedPencilEdit02;
  static const IconData password = HugeIcons.strokeRoundedLockPassword;
  static const IconData view = HugeIcons.strokeRoundedView;
  static const IconData viewOff = HugeIcons.strokeRoundedViewOffSlash;
  static const IconData email = HugeIcons.strokeRoundedMail02;
  static const IconData phone = HugeIcons.strokeRoundedSmartPhone01;
  static const IconData username = HugeIcons.strokeRoundedUser;
  static const IconData close = HugeIcons.strokeRoundedCancel01;
  static const IconData download = HugeIcons.strokeRoundedDownload04;
  static const IconData notification = HugeIcons.strokeRoundedNotification01;
  static const IconData delivery = HugeIcons.strokeRoundedTruckDelivery;
  static const IconData pickUp = HugeIcons.strokeRoundedStore04;
  static const IconData share = HugeIcons.strokeRoundedShare05;

  // Button Icon
  static Widget notificationIcon(bool dark) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.transparent, // Latar belakang transparan
        shape: BoxShape.circle, // Membuat bentuk bulat
        border: Border.all(
          color: dark ? SColors.green50 : SColors.softBlack50, // Warna garis sesuai mode
          width: 1, // Ketebalan garis
        ),
      ),
      child: Center(
        child: Icon(
          SIcons.notification, // Ikon yang digunakan
          color: dark ? SColors.green500 : SColors.softBlack300, // Warna ikon sesuai mode
        ),
      ),
    );
  }
}
