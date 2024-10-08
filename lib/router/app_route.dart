import 'package:go_router/go_router.dart';
import 'package:nontradecementadminpanel/local/pref.dart';
import 'package:nontradecementadminpanel/local/pref_names.dart';
import 'package:nontradecementadminpanel/screen/change_password.dart';
import 'package:nontradecementadminpanel/screen/customdate_screen.dart';
import 'package:nontradecementadminpanel/screen/post_assigned_mobileno.dart';
import 'package:nontradecementadminpanel/screen/profile.dart';
import 'package:nontradecementadminpanel/screen/today.dart';
import 'package:nontradecementadminpanel/screen/tomorrow.dart';
import 'package:nontradecementadminpanel/screen/update_data.dart';
import '../screen/home.dart';
import '../screen/login.dart';
import 'routes_names.dart';

bool isUserLogin = Prefs.getValue(PrefNames.isLogin) ?? false;

String getInitialRoute() {
  if (isUserLogin) {
    return RouteNames.home;
  } else {
    return RouteNames.login;
  }
}

final appRoute = GoRouter(initialLocation: getInitialRoute(), routes: [
  GoRoute(
      path: RouteNames.login,
      name: RouteNames.login,
      builder: (context, state) {
        return const Login();
      }),
  GoRoute(
      path: RouteNames.home,
      name: RouteNames.home,
      builder: (context, state) {
        return const Home();
      }),
  GoRoute(
      path: RouteNames.today,
      name: RouteNames.today,
      builder: (context, state) {
        return const Today();
      }),
  GoRoute(
      path: RouteNames.yesterday,
      name: RouteNames.yesterday,
      builder: (context, state) {
        return const Tomorrow();
      }),
  GoRoute(
      path: '/customdatescreen/:pickeddate',
      name: RouteNames.customdatescreen,
      builder: (context, state) {
        return CustomDateScreen(
          selectedDate: state.pathParameters['pickeddate'] ?? '',
        );
      }),
  GoRoute(
      path: RouteNames.update,
      name: RouteNames.update,
      builder: (context, state) {
        return const UpdateData();
      }),
  GoRoute(
      path: RouteNames.changePassword,
      name: RouteNames.changePassword,
      builder: (context, state) {
        return const ChangePassword();
      }),
  GoRoute(
      path: RouteNames.profile,
      name: RouteNames.profile,
      builder: (context, state) {
        return const Profile();
      }),

  GoRoute(
      path: RouteNames.assignedMobileNumber,
      name: RouteNames.assignedMobileNumber,
      builder: (context, state) {
        return const AssignMobileNumber();
      }),
]);
