import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/screens/home_screen.dart';
import 'package:com_csith_geniuzpos/services/response/posresponse.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'data/posfunctions/posAcmModel.dart';
import 'data/posfunctions/poscontrolmodel.dart';
import 'data/possales/bdcitemmodel.dart';
import 'data/possales/rcpitemmodel.dart';
import 'data/possales/salesitemmodel.dart';
import 'data/possales/tableusagemodel.dart';
import 'utility/os.dart';

main() {
  runApp(MyApp());
  (OS.deviceinfo() == 'Windows')
      ? doWhenWindowReady(() {
          final win = appWindow;
          final double inW = Palette.windowswidth();
          final double inH = Palette.windowsheight();
          final initialSize = Size(inW, inH);
          win.minSize = initialSize;
          win.size = initialSize;
          win.alignment = Alignment.topCenter;
          win.title = "GeniuzPOS";
          win.show();
        })
      : Container();
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> implements HiveInitCallBack {
  HiveInitCallResponse _hiveinit;
  @override
  void initState() {
    _hiveinit = new HiveInitCallResponse(this);
    _hiveinit.doInitial();

    super.initState();
  }

  void dispose() {
    super.dispose();
    debugPrint('Main:hive.close: OK ');
    Hive.close();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<RestTableUsageModel>(
              create: (context) => RestTableUsageModel()),
          ChangeNotifierProvider<SalesItemHiveModel>(
              create: (context) => SalesItemHiveModel()),
          ChangeNotifierProvider<PosControlModel>(
              create: (context) => PosControlModel()),
          ChangeNotifierProvider<BillDCItemHiveModel>(
              create: (context) => BillDCItemHiveModel()),
          ChangeNotifierProvider<ReceiptItemHiveModel>(
              create: (context) => ReceiptItemHiveModel()),
          ChangeNotifierProvider<PosAcmModel>(
              //---CsParam - poscycleName (by Daye)
              create: (context) => PosAcmModel()),
        ],
        child: MaterialApp(
          title: 'GeniuzPOS',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            dividerColor: Colors.white,
          ),
          home: HomeScreen(0),
        ));
  }

  // @override
  // void onCallHiveCloseError(String error) {}

  // @override
  // void onCallHiveCloseSuccess(String result) {
  //   Hive.close();
  // }

  @override
  void onCallHiveInitError(String error) {}

  @override
  void onCallHiveInitSuccess(String result) {}
}
