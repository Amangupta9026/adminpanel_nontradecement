import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../riverpod/login_notifier.dart';
import '../utils/colors.dart';
import '../widget/textformfield_widget.dart';

class Login extends ConsumerWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refWatch = ref.watch(homeNotifierProvider);
    final refRead = ref.read(homeNotifierProvider.notifier);
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Padding(
      padding: const EdgeInsets.all(60.0),
      child: Column(
        children: [
          const Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            labelText: 'Email id',
            hintText: 'Enter email id',
            controller: refWatch.value?.emailController,
          ),
          const SizedBox(height: 20),
          CustomTextFormField(
            labelText: 'Password',
            hintText: 'Enter password',
            controller: refWatch.value?.passwordController,
          ),
          const SizedBox(height: 40),
          InkWell(
            onTap: () {
              refRead.login(context);
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Submit',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ))));
  }
}
