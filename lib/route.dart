import 'package:base/library.dart';
import 'package:base/modules/home/home_screen.dart';
import 'package:base/modules/root/root_screen.dart';
import 'package:base/modules/topic_detail.dart/topic_detail.dart';

import 'modules/initial/initial_screen.dart';

class AppRoute {
  static const init = '/';
  static const home = '/home';
  static const root = '/root';
  static const topic = '/topic_detail';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.init:
        return GetPageRoute(page: () => InitScreen());
      case AppRoute.home:
        return GetPageRoute(page: () => HomeScreen());
      case AppRoute.root:
        return GetPageRoute(page: () => RootScreen());
      case AppRoute.topic:
        var id = (settings.arguments as Map)['id'];
        return GetPageRoute(page: () => TopicScreen(id: id));
      default:
        return GetPageRoute(page: () => Center(child: Text('undefined')));
    }
  }
}
