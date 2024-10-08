import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nontradecementadminpanel/riverpod/login_notifier.dart';
import 'package:nontradecementadminpanel/utils/colors.dart';
import 'package:nontradecementadminpanel/widget/textformfield_widget.dart';

class Profile extends ConsumerWidget {
  const Profile({super.key});

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
              'Profile',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('changepassword')
                        .get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      var alldata = snapshot.data?.docs;
                      log(alldata?[0]['changepassword'].toString() ??
                          'data not found');

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

                      return Column(
                        children: [
                          CustomTextFormField(
                              readOnly: true,
                              labelText: 'Email id',
                              hintText: 'Enter email id',
                              controller: TextEditingController(
                                  text: alldata?[0]['email'].toString()),
                              keyboardType: TextInputType.emailAddress),
                          const SizedBox(height: 20),
                          // CustomTextFormField(
                          //     readOnly: true,
                          //     labelText: 'Password:',
                          //     hintText: 'Password',
                          //     controller: TextEditingController(
                          //         text:
                          //             alldata?[0]['changepassword'].toString()),
                          //     keyboardType: TextInputType.number),
                          // const SizedBox(height: 20),
                        ],
                      );
                    }),
                FutureBuilder(
                    future:
                        FirebaseFirestore.instance.collection('update').get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      var alldata = snapshot.data?.docs;
                      log(alldata?[1]['mobile'].toString() ?? 'data not found');

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

                      return Column(
                        children: [
                          CustomTextFormField(
                              readOnly: true,
                              labelText: 'Mobile Number:',
                              hintText: 'Mobile Number',
                              controller: TextEditingController(
                                  text: alldata?[1]['mobile'].toString()),
                              keyboardType: TextInputType.number),
                          const SizedBox(height: 20),
                          CustomTextFormField(
                              readOnly: true,
                              labelText: 'Address:',
                              hintText: 'Address',
                              controller: TextEditingController(
                                  text: alldata?[1]['address'].toString()),
                              keyboardType: TextInputType.number),
                        ],
                      );
                    }),
                const SizedBox(height: 40),
                const Text(
                  'Assigned Mobile Number',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                const SizedBox(height: 20),
                FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('popupmobilenumber')
                        .get(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      var alldata = snapshot.data?.docs;
                      log(alldata?[0]['mobile_number'].toString() ??
                          'data not found');

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

                      return Column(
                        children: [
                          CustomTextFormField(
                              readOnly: true,
                              labelText: 'Mobile Number:',
                              hintText: 'Mobile Number',
                              controller: TextEditingController(
                                  text:
                                      alldata?[0]['mobile_number'].toString()),
                              keyboardType: TextInputType.number),
                        ],
                      );
                    }),
              ],
            ),
          ]),
        )),
      ),
    );
  }
}
