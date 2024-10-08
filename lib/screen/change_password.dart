import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nontradecementadminpanel/riverpod/login_notifier.dart';
import 'package:nontradecementadminpanel/utils/colors.dart';
import 'package:nontradecementadminpanel/widget/textformfield_widget.dart';

class ChangePassword extends ConsumerWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refRead = ref.read(homeNotifierProvider.notifier);
    final refWatch = ref.watch(homeNotifierProvider);
    return Scaffold(
      backgroundColor: whiteBackgroundColor,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
            PointerDeviceKind.unknown,
            PointerDeviceKind.invertedStylus,
            PointerDeviceKind.stylus
          },
        ),
        child: SafeArea(
            child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Change Credentials',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 20),
            CustomTextFormField(
                labelText: 'Email id',
                hintText: 'Enter email id',
                controller: refWatch.value?.changeEmailController,
                keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 20),
            CustomTextFormField(
                labelText: 'Change Password:',
                hintText: 'Change Password',
                controller: refWatch.value?.changePasswordController,
                keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            CustomTextFormField(
                labelText: 'Confirm Change Password:',
                hintText: 'Confirm Change Password:',
                controller: refWatch.value?.changeConfirmPasswordController,
                keyboardType: TextInputType.number),
            const SizedBox(height: 40),
            Center(
              child: InkWell(
                onTap: () {
                  refRead.onChangePasswordSubmit(context);
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 52,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: const Center(
                      child: Text(
                        'Submit',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    )),
              ),
            ),
          ]),
        )),
      ),
    );
  }
}
