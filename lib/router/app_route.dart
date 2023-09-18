import 'package:go_router/go_router.dart';
import '../screen/home.dart';
import '../screen/login.dart';
import 'routes_names.dart';

bool isUserLogin =
//Prefs.getBool(PrefNames.isLogin) ??
    false;

String getInitialRoute() {
  switch (isUserLogin) {
    case false:
      return RouteNames.login;
    default:
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
 
]);
