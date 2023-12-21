import 'package:chatapp/colors.dart';
import 'package:chatapp/common/utils/util.dart';
import 'package:chatapp/common/widgets/custom_button.dart';
import 'package:chatapp/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;
  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        // ignore: no_leading_underscores_for_local_identifiers
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(AuthControllerProvider)
          .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
    } else {
      showSnackBar(context: context, content: 'Fill in all details');
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter your phone number'),
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const Text('App will need to verify your phone number'),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: pickCountry,
                  child: const Text('Pick Country'),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    if (country != null) Text('+${country!.phoneCode}'),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: size.width * 0.7,
                      child: TextField(
                        controller: phoneController,
                        decoration: const InputDecoration(
                          hintText: 'phone nunmber',
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 120,
              height: 50,
              child: CustomButton(
                text: 'NEXT',
                onPressed: sendPhoneNumber,
              ),
            )
          ],
        ),
      ),
    );
  }
}
