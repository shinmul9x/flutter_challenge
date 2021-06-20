import 'package:base/library.dart';
import 'package:base/modules/home/home_screen.dart';

enum RootTab {
  home,
  notification,
  profile,
}

class RootScreen extends StatefulWidget {
  final listTab = RootTab.values;

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late RootTab _current;

  @override
  void initState() {
    super.initState();
    _current = widget.listTab.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: List.from(widget.listTab.map((tab) => _tabItem(tab))),
        currentIndex: _current.index,
        elevation: 0,
        onTap: (index) {
          _current = widget.listTab[index];

          setState(() {});
        },
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _screen(_current),
          divider(color: AppColors.athensGray),
        ],
      ),
    );
  }

  BottomNavigationBarItem _tabItem(RootTab tab) {
    switch (tab) {
      case RootTab.home:
        if (_current == RootTab.home)
          return BottomNavigationBarItem(
            icon: SvgAssetIcon(
              AppImages.icHome,
              color: Get.theme.primaryColor,
            ),
            label: '',
          );
        return BottomNavigationBarItem(
          icon: SvgAssetIcon(AppImages.icHome),
          label: '',
        );
      case RootTab.notification:
        if (_current == RootTab.notification)
          return BottomNavigationBarItem(
            icon: SvgAssetIcon(
              AppImages.icBell,
              color: Get.theme.primaryColor,
            ),
            label: '',
          );
        return BottomNavigationBarItem(
          icon: SvgAssetIcon(AppImages.icBell),
          label: '',
        );
      case RootTab.profile:
        if (_current == RootTab.profile)
          return BottomNavigationBarItem(
            icon: SvgAssetIcon(
              AppImages.icPerson,
              color: Get.theme.primaryColor,
            ),
            label: '',
          );
        return BottomNavigationBarItem(
          icon: SvgAssetIcon(AppImages.icPerson),
          label: '',
        );
      default:
        return BottomNavigationBarItem(
          icon: Icon(Icons.circle),
          label: '',
        );
    }
  }

  Widget _screen(RootTab tab) {
    switch (tab) {
      case RootTab.home:
        return HomeScreen();
      // case RootTab.notification:
      //   return NotificationScreen();
      // case RootTab.profile:
      //   return ProfileScreen();
      default:
        return Scaffold(
          body: Center(
            child: Text(
              'Undefined Tab',
              style: AppTextTheme.t24W400(),
            ),
          ),
        );
    }
  }
}
