import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nontradecementadminpanel/widget/responsive_devices.dart';
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
        body: FutureBuilder(
            future:
                FirebaseFirestore.instance.collection('changepassword').get(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var alldata = snapshot.data?.docs;
              log(alldata?[0]['email'].toString() ?? 'data not found');

              if (!snapshot.hasData) {
                return const Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 60),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }

              return SafeArea(
                  child: SingleChildScrollView(
                      child: Column(
                children: [
                  if (Responsive.isDesktop(context))
                    Padding(
                      padding: const EdgeInsets.all(60.0),
                      child: Column(
                        children: [
                          Center(
                            child: Image.asset('assets/images/p2.jpg',
                                width: MediaQuery.of(context).size.width * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                fit: BoxFit.fill),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: textColor),
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            labelText: 'UserId',
                            hintText: 'Enter user id',
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
                              // refRead.onExcelSubmit(context);
                              refRead.login(
                                  context,
                                  alldata?[0]['email'].toString() ?? '',
                                  alldata?[0]['changepassword'].toString() ??
                                      '');
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
                    ),
                  if (Responsive.isMobile(context) ||
                      Responsive.isTablet(context))
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        children: [
                          Center(
                            child: Image.asset('assets/images/p2.jpg',
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                fit: BoxFit.fill),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: textColor),
                          ),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                            labelText: 'UserId',
                            hintText: 'Enter UserId',
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
                              refRead.login(
                                  context,
                                  alldata?[0]['email'].toString() ?? '',
                                  alldata?[0]['changepassword'].toString() ??
                                      '');
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
                    ),
                ],
              )));
            }));
  }
}
