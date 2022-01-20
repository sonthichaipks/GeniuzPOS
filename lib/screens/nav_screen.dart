import 'package:com_csith_geniuzpos/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'fullsales/full_salespage.dart';
import 'home_screen.dart';

class NavScreen extends StatefulWidget {
  final int screenmenu;
  const NavScreen({Key key, this.screenmenu}) : super(key: key);
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  final List<Widget> _screens = [
    HomeScreen(0),
    FullSalesPages(),
    ResturantSalesPages(),
    RetailSalesPages(),
    ResturantSeatPages(),
  ];
  final List<IconData> _icons = const [
    Icons.home,
    Icons.ondemand_video,
    MdiIcons.accountCircleOutline,
    MdiIcons.accountGroupOutline,
    MdiIcons.bellOutline,
    Icons.menu,
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _icons.length,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: IndexedStack(
            index: widget.screenmenu,
            children: _screens,
          ),
        ),
      ),
    );
  }
}
