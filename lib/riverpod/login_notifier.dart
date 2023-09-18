import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import '../router/routes_names.dart';
import '../utils/colors.dart';

final homeNotifierProvider =
    AsyncNotifierProvider.autoDispose<HomeNotifier, HomeMode>(() {
  return HomeNotifier();
});

class HomeMode {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
}

class HomeNotifier extends AutoDisposeAsyncNotifier<HomeMode> {
  final HomeMode _adminMode = HomeMode();

  void login(BuildContext context) {
    if (_adminMode.emailController.text.isEmpty &&
        _adminMode.passwordController.text.isEmpty) {
      toast('Please enter email id and password');
    } else {
      // if (_adminMode.emailController.text == 'nontrade@gmail.com' &&
      //     _adminMode.passwordController.text == 'nontrade@123') {
      context.pushNamed(RouteNames.home);
      //   toast('Login success');
      // }
    }
  }

  void toast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      textColor: textColor,
      fontSize: 16.0,
    );
  }

  @override
  build() {
    return _adminMode;
  }
}
