import 'package:flutter/material.dart';
import 'package:segarku/utils/constants/colors.dart';
import 'package:segarku/utils/constants/icons.dart';
import 'package:segarku/utils/constants/sizes.dart';
import 'package:segarku/utils/constants/text_strings.dart';
import 'package:segarku/utils/theme/custom_themes/text_theme.dart';

class InputFields {
  static Widget emailField(BuildContext context, bool dark, TextEditingController emailController) {
    final FocusNode focusNode = FocusNode();
    bool isFocused = false;

    return StatefulBuilder(
      builder: (context, setState) {
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              STexts.email,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),
            TextFormField(
              focusNode: focusNode,
              controller: emailController,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: SSizes.md2,
                  vertical: SSizes.md,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(
                    top: SSizes.md,
                    bottom: SSizes.md,
                    left: SSizes.md2,
                    right: SSizes.sm2,
                  ),
                  child: Icon(
                    SIcons.email,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
                labelText: STexts.emailField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.emailField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(
                    color: SColors.softBlack50,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(
                    color: SColors.green500,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email tidak boleh kosong';
                }
                if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value)) {
                  return 'Masukkan email yang valid';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }



  static Widget passwordField(BuildContext context, bool dark, TextEditingController passwordController) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();
    bool isFocused = false;
    bool isPasswordVisible = false;

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text Password
            Text(
              STexts.password,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field Password
            TextFormField(
              controller: passwordController, // Mengikat passwordController
              focusNode: focusNode,
              obscureText: !isPasswordVisible, // Mengatur apakah password disembunyikan
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
                // Menambahkan Icon di dalam field
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: SSizes.md, bottom: SSizes.md, left: SSizes.md2, right: SSizes.sm2),
                  child: Icon(
                    SIcons.password,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
                // Menambahkan Icon untuk toggle password visibility
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: SSizes.md, bottom: SSizes.md, left: SSizes.sm2, right: SSizes.md2),
                    child: Icon(
                      isPasswordVisible ? SIcons.eye : SIcons.eyeSlash,
                      color: isFocused
                          ? (dark ? SColors.green500 : SColors.green500)
                          : (dark ? SColors.softBlack50 : SColors.softBlack300),
                    ),
                  ),
                ),
                // Text Password field
                labelText: STexts.passwordField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.passwordField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
              validator: (value) {
                // Validasi password
                if (value == null || value.isEmpty) {
                  return 'Password tidak boleh kosong';
                }
                if (value.length < 6) {
                  return 'Password harus minimal 6 karakter';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }



  static Widget confirmPasswordField(BuildContext context, bool dark, TextEditingController passwordController) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();
    bool isFocused = false;
    bool isPasswordVisible = false;

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text Confirm Password
            Text(
              STexts.confirmPassword,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field Confirm Password
            TextFormField(
              focusNode: focusNode,
              obscureText: !isPasswordVisible, // Mengatur apakah password disembunyikan
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
                // Menambahkan Icon di dalam field
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: SSizes.md, bottom: SSizes.md, left: SSizes.md2, right: SSizes.sm2),
                  child: Icon(
                    SIcons.password,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
                // Menambahkan Icon untuk toggle password visibility
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: SSizes.md, bottom: SSizes.md, left: SSizes.sm2, right: SSizes.md2),
                    child: Icon(
                      isPasswordVisible ? SIcons.eye : SIcons.eyeSlash,
                      color: isFocused
                          ? (dark ? SColors.green500 : SColors.green500)
                          : (dark ? SColors.softBlack50 : SColors.softBlack300),
                    ),
                  ),
                ),
                // Text Confirm Password field
                labelText: STexts.confirmPasswordField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.confirmPasswordField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
              validator: (value) {
                // Validasi confirm password
                if (value == null || value.isEmpty) {
                  return 'Konfirmasi password tidak boleh kosong';
                }
                if (value != passwordController.text) {
                  return 'Konfirmasi password harus sama dengan password';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }

  //-------------------- Username Field --------------------//
  static Widget usernameField(BuildContext context, bool dark, TextEditingController nameController) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();
    bool isFocused = false;

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text username
            Text(
              STexts.username,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field Username
            TextFormField(
              controller: nameController,
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
                // Menambahkan Icon di dalam field
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: SSizes.md, bottom: SSizes.md, left: SSizes.md2, right: SSizes.sm2),
                  child: Icon(
                    SIcons.username,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
                // Text Username field
                labelText: STexts.usernameField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.usernameField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username tidak boleh kosong';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }


  //-------------------- No Phone Field --------------------//
  static Widget noHandphoneField(BuildContext context, bool dark, TextEditingController phoneController) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();
    bool isFocused = false;

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text No Phone
            Text(
              STexts.noPhone,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field no Phone
            TextFormField(
              focusNode: focusNode,
              controller: phoneController,
              keyboardType: TextInputType.phone, 
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
                // Menambahkan Icon di dalam field
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top:SSizes.md, bottom: SSizes.md, left: SSizes.md2, right: SSizes.sm2),
                  child: Icon(
                    SIcons.phone,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
                // Text No Phone field
                labelText: STexts.noPhoneField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.noPhoneField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nomor HP tidak boleh kosong';
                }
                // RegExp untuk validasi nomor telepon dengan +62 atau 08
                final RegExp phoneRegExp = RegExp(r'^(\+62|08)[0-9]{8,13}$');
                if (!phoneRegExp.hasMatch(value)) {
                  return 'Masukkan nomor Handphone yang valid';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }

  //-------------------- No Phone Field --------------------//
  static Widget noHandphoneAddressField(BuildContext context, bool dark) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text No Phone
            Text(
              STexts.noPhone,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field no Phone
            TextFormField(
              focusNode: focusNode,
              keyboardType: TextInputType.phone, 
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),

                // Text No Phone field
                labelText: STexts.noPhoneField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.noPhoneField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nomor HP tidak boleh kosong';
                }
                // RegExp untuk validasi nomor telepon dengan +62 atau 08
                final RegExp phoneRegExp = RegExp(r'^(\+62|08)[0-9]{8,13}$');
                if (!phoneRegExp.hasMatch(value)) {
                  return 'Masukkan nomor Handphone yang valid';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }

  //-------------------- Alamat Field --------------------//
  static Widget addressField(BuildContext context, bool dark) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();
    final TextEditingController controller = TextEditingController();

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {});
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label di luar field (judul/heading)
            Text(
              STexts.address,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // TextFormField dengan labelText di dalam bagian atas field
            TextFormField(
              focusNode: focusNode,
              controller: controller,
              maxLines: 3, // Multiline input
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: SSizes.md2,
                  vertical: SSizes.md,
                ),
                labelText: STexts.fieldAddress,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never, // Tidak mengapung
                alignLabelWithHint: true, // Membuat label berada di atas dalam field
                hintText: STexts.fieldAddress, // Placeholder opsional
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Alamat tidak boleh kosong';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }


  //-------------------- Catatan Alamat Field --------------------//
  static Widget addressRecordsField(BuildContext context, bool dark) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text No Phone
            Text(
              STexts.addressRocordFieldTitle,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field no Phone
            TextFormField(
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
                
                // Text No Phone field
                labelText: STexts.addressRocordField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.addressRocordField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  //-------------------- Nama Penerima Field --------------------//
  static Widget recipientNameField(BuildContext context, bool dark) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text No Phone
            Text(
              STexts.recipientsNameFieldTitle,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field no Phone
            TextFormField(
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
               
                // Text No Phone field
                labelText: STexts.recipientsNameField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.recipientsNameField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Harap masukan nama penerima';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }

  //-------------------- Username Field --------------------//
  static Widget editUsernameField(BuildContext context, bool dark) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();
    bool isFocused = false;

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text username
            Text(
              STexts.editUsername,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field Username
            TextFormField(
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
                // Menambahkan Icon di dalam field
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top:SSizes.md, bottom: SSizes.md, left: SSizes.md2, right: SSizes.sm2),
                  child: Icon(
                    SIcons.username,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
                // Text Username field
                labelText: STexts.usernameField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.usernameField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username tidak boleh kosong';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }


  //-------------------- Name Field --------------------//
  static Widget editNameField(BuildContext context, bool dark) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();
    bool isFocused = false;

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text username
            Text(
              STexts.editName,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field Username
            TextFormField(
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
                // Menambahkan Icon di dalam field
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top:SSizes.md, bottom: SSizes.md, left: SSizes.md2, right: SSizes.sm2),
                  child: Icon(
                    SIcons.username,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
                // Text Username field
                labelText: STexts.usernameField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.usernameField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nama tidak boleh kosong';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }

    //-------------------- Username Field --------------------//
  static Widget usernameProfileField(BuildContext context, bool dark, {TextEditingController? controller, String? initialValue}) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();
    bool isFocused = false;

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text username
            Text(
              STexts.username,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field Username
            TextFormField(
              controller: controller,
              initialValue: initialValue,
              focusNode: focusNode,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
                // Menambahkan Icon di dalam field
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: SSizes.md, bottom: SSizes.md, left: SSizes.md2, right: SSizes.sm2),
                  child: Icon(
                    SIcons.username,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
                // Text Username field
                labelText: STexts.usernameField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.usernameField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Username tidak boleh kosong';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }


  //-------------------- Email Field --------------------//
  static Widget editEmailField(BuildContext context, bool dark, {TextEditingController? controller, String? initialValue}) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();
    bool isFocused = false;

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text username
            Text(
              STexts.editEmail,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field Username
            TextFormField(
              controller: controller,
              focusNode: focusNode,
              initialValue: initialValue,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
                // Menambahkan Icon di dalam field
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top:SSizes.md, bottom: SSizes.md, left: SSizes.md2, right: SSizes.sm2),
                  child: Icon(
                    SIcons.email,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
                // Text emailField field
                labelText: STexts.emailField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.emailField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
              validator: (value) {
                // Validasi email
                if (value == null || value.isEmpty) {
                  return 'Email tidak boleh kosong';
                }
                // Regex untuk validasi email
                final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$');
                if (!emailRegex.hasMatch(value)) {
                  return 'Format email tidak valid';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }


  //-------------------- editNoPhone Field --------------------//
  static Widget editNoPhoneField(BuildContext context, bool dark, {TextEditingController? controller, String? initialValue}) {
    // FocusNode untuk mendeteksi fokus
    final FocusNode focusNode = FocusNode();
    bool isFocused = false;

    return StatefulBuilder(
      builder: (context, setState) {
        // Listener untuk fokus
        focusNode.addListener(() {
          setState(() {
            isFocused = focusNode.hasFocus;
          });
        });

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text edit no phone
            Text(
              STexts.editnoPhone,
              style: dark
                  ? STextTheme.titleCaptionBoldDark
                  : STextTheme.titleCaptionBoldLight,
            ),
            const SizedBox(height: SSizes.xs),

            // Text & Icons Form Field edit no HP
            TextFormField(
              controller: controller,
              focusNode: focusNode,
              keyboardType: TextInputType.phone, 
              initialValue: initialValue,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: SSizes.md2, vertical: SSizes.md),
                // Menambahkan Icon di dalam field
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top:SSizes.md, bottom: SSizes.md, left: SSizes.md2, right: SSizes.sm2),
                  child: Icon(
                    SIcons.phone,
                    color: isFocused
                        ? (dark ? SColors.green500 : SColors.green500)
                        : (dark ? SColors.softBlack50 : SColors.softBlack300),
                  ),
                ),
                // Text Edit no Phone field
                labelText: STexts.noPhoneField,
                labelStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintText: STexts.noPhoneField,
                hintStyle: dark
                    ? STextTheme.bodyBaseRegularLight
                    : STextTheme.bodyBaseRegularDark,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.softBlack50),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SSizes.borderRadiussm),
                  borderSide: const BorderSide(color: SColors.green500),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Nomor HP tidak boleh kosong';
                }
                // RegExp untuk validasi nomor telepon dengan +62 atau 08
                final RegExp phoneRegExp = RegExp(r'^(\+62|08)[0-9]{8,13}$');
                if (!phoneRegExp.hasMatch(value)) {
                  return 'Masukkan nomor Handphone yang valid';
                }
                return null;
              },
            ),
          ],
        );
      },
    );
  }

}
