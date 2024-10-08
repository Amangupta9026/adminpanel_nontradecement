// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:nontradecementadminpanel/local/pref.dart';
import 'package:nontradecementadminpanel/local/pref_names.dart';
import 'package:path/path.dart';
import '../router/routes_names.dart';
import '../utils/colors.dart';

final homeNotifierProvider =
    AsyncNotifierProvider.autoDispose<HomeNotifier, HomeMode>(() {
  return HomeNotifier();
});

class HomeMode {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController updateemailController = TextEditingController();

  TextEditingController changePasswordController = TextEditingController();
  TextEditingController changeConfirmPasswordController =
      TextEditingController();
  TextEditingController changeEmailController = TextEditingController();

  TextEditingController assignedMobileNumberController =
      TextEditingController();
}

class HomeNotifier extends AutoDisposeAsyncNotifier<HomeMode> {
  final HomeMode _adminMode = HomeMode();

  void login(BuildContext context, String email, String password) {
    if (_adminMode.emailController.text.isEmpty ||
        _adminMode.passwordController.text.isEmpty) {
      toast('Please enter email id and password');
    } else {
      if (_adminMode.emailController.text == email &&
          _adminMode.passwordController.text == password) {
        Prefs.setValue(PrefNames.isLogin, true);
        context.pushNamed(RouteNames.home);
        toast('Login success');
      } else {
        toast('Invalid Credentials');
      }
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _adminMode.selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != _adminMode.selectedDate) {
      _adminMode.selectedDate = picked;
      // ignore: unnecessary_null_comparison
      if (picked != null) {
        //  pickedSelectedDate = picked;
        context.pushNamed(RouteNames.customdatescreen,
            pathParameters: {'pickeddate': picked.toString()});
      }

      // log(picked.toString());
    }
    state = AsyncData(_adminMode);
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

  // Update
  void onSubmit(BuildContext context) async {
    EasyLoading.show(status: 'loading...');

    if (_adminMode.mobileController.text.isEmpty &&
        _adminMode.mobileController.text.isEmpty &&
        _adminMode.mobileController.text.isEmpty) {
      toast("Please fill the all records");
    } else {
      var quotesSnapShot = await FirebaseFirestore.instance
          .collection('update')
          .where('id', isEqualTo: 1)
          .get();
      var docID = quotesSnapShot.docs.first.id;
      FirebaseFirestore.instance.collection('update').doc(docID).update({
        'id': 1,
        'mobile': _adminMode.mobileController.text,
        'address': _adminMode.addressController.text,
        'email': _adminMode.emailController.text,
        'servertime': FieldValue.serverTimestamp(),
      });

      EasyLoading.dismiss();
      toast("Update Successfully");
      context.pushNamed(RouteNames.home);
    }
    EasyLoading.dismiss();
  }

  // Change Password
  void onChangePasswordSubmit(BuildContext context) async {
    EasyLoading.show(status: 'loading...');

    if (_adminMode.changePasswordController.text.isEmpty &&
        _adminMode.changeConfirmPasswordController.text.isEmpty &&
        _adminMode.changeEmailController.text.isEmpty) {
      toast("Please fill the all records");
    } else if (_adminMode.changePasswordController.text.isNotEmpty &&
        _adminMode.changeConfirmPasswordController.text.isNotEmpty &&
        _adminMode.changeEmailController.text.isNotEmpty) {
      if (_adminMode.changePasswordController.text ==
          _adminMode.changeConfirmPasswordController.text) {
        var quotesSnapShot = await FirebaseFirestore.instance
            .collection('changepassword')
            .where('id', isEqualTo: 1)
            .get();
        var docID = quotesSnapShot.docs.first.id;
        FirebaseFirestore.instance
            .collection('changepassword')
            .doc(docID)
            .update({
          'id': 1,
          'changepassword': _adminMode.changePasswordController.text,
          'confirmchangepassword':
              _adminMode.changeConfirmPasswordController.text,
          'email': _adminMode.changeEmailController.text,
          'servertime': FieldValue.serverTimestamp(),
        });

        EasyLoading.dismiss();
        toast("Update Successfully");
        context.pushNamed(RouteNames.home);
      } else if (_adminMode.changePasswordController.text !=
          _adminMode.changeConfirmPasswordController.text) {
        toast("Password and Confirm Password not match");
      }
    }
    EasyLoading.dismiss();
  }

  // excel
  Future onExcelSubmit() async {
    EasyLoading.show(status: 'loading...');

    var excel = Excel.createExcel(); //create an excel sheet
    Sheet sheetObject = excel['formData']; //create an sheet object

    QuerySnapshot<Map<String, dynamic>> qs = await FirebaseFirestore.instance
        .collection('queryForm')
        .orderBy('servertime', descending: true)
        .get();

    // log(qs);

    for (int i = 0; i < qs.docs.length; i++) {
      DateTime date = DateTime.fromMicrosecondsSinceEpoch(
          (qs.docs[i].data()['servertime'] as Timestamp)
              .microsecondsSinceEpoch);

      final datetrim = date.toString();
      String trimDateTime(String datetrim) {
        final timestamp = DateTime.parse(datetrim);
        final trimmedDateTime = DateTime(timestamp.year, timestamp.month,
            timestamp.day, timestamp.hour, timestamp.minute);
        final trimmedTimestamp = Timestamp.fromDate(trimmedDateTime);
        return trimmedTimestamp.toDate().toString();
      }

      CellStyle cellStyle = CellStyle(
          backgroundColorHex: '#1AFF1A',
          fontFamily: getFontFamily(FontFamily.Calibri));

      cellStyle.underline = Underline.Single;

      // var cell1 = sheetObject.cell(CellIndex.indexByColumnRow(
      //   columnIndex: 0,
      //   rowIndex: 0,
      // ));
      // cell1.value = 'Name';

      var cell1 = sheetObject.cell(CellIndex.indexByString(
          'A${i + 1}')); //i+1 means when the loop iterates every time it will write values in new row, e.g A1, A2, ...
      cell1.value = qs.docs[i].data()['name']; // Insert value to selected cell;

      var cell2 = sheetObject.cell(CellIndex.indexByString('B${i + 1}'));
      cell2.value = qs.docs[i].data()['email'];

      var cell3 = sheetObject.cell(CellIndex.indexByString('C${i + 1}'));
      cell3.value = qs.docs[i].data()['number'];

      var cell4 = sheetObject.cell(CellIndex.indexByString('D${i + 1}'));
      cell4.value = qs.docs[i].data()['quantity'];

      var cell5 = sheetObject.cell(CellIndex.indexByString('E${i + 1}'));
      cell5.value = qs.docs[i].data()['selected_company'];

      var cell6 = sheetObject.cell(CellIndex.indexByString('F${i + 1}'));
      cell6.value = trimDateTime(datetrim);

      //qs.docs[i].data()['servertime'];
    }
    EasyLoading.dismiss();
    //  print(cell.toString());

    // Save the Changes in file

    String outputFile =
        "/Users/jaishreekrishna/Desktop/git_projects/formdata.xlsx";

    List<int>? fileBytes = excel.save(fileName: 'CementExportData.xlsx');
    //print('saving executed in ${stopwatch.elapsed}');
    if (fileBytes != null) {
      File(join(outputFile))
        ..createSync(recursive: true)
        ..writeAsBytesSync(fileBytes);
    }
    EasyLoading.dismiss();
  }

  // Assigneed Mobile Number

  void onAssignedMobileNumberSubmit(BuildContext context) async {
    EasyLoading.show(status: 'loading...');

    if (_adminMode.assignedMobileNumberController.text.isEmpty) {
      toast("Please fill the all records");
    } else if (_adminMode.assignedMobileNumberController.text.isNotEmpty) {
      var quotesSnapShot = await FirebaseFirestore.instance
          .collection('popupmobilenumber')
          .where('id', isEqualTo: 1)
          .get();
      var docID = quotesSnapShot.docs.first.id;
      FirebaseFirestore.instance
          .collection('popupmobilenumber')
          .doc(docID)
          .update({
        'id': 1,
        'mobile_number': _adminMode.assignedMobileNumberController.text,
        'servertime': FieldValue.serverTimestamp(),
      });

      EasyLoading.dismiss();
      toast("Update Successfully");
      context.pushNamed(RouteNames.home);
    }
  }

  @override
  build() {
    return _adminMode;
  }
}
