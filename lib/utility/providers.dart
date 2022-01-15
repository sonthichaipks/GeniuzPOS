// import 'package:com_csith_geniuzpos/data/possales/salesitemmodel.dart';
// import 'package:com_csith_geniuzpos/data/possales/tableusagemodel.dart';

import 'package:com_csith_geniuzpos/data/possales/salesitemmodel.dart';
import 'package:com_csith_geniuzpos/data/possales/tableusagemodel.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providerTables = [
  ChangeNotifierProvider<RestTableUsageModel>(
      create: (context) => RestTableUsageModel()),
];

List<SingleChildWidget> providerSalesItem = [
  ChangeNotifierProvider<SalesItemHiveModel>(
      create: (context) => SalesItemHiveModel()),
];

List<SingleChildWidget> providerResturant = [
  ChangeNotifierProvider<SalesItemHiveModel>(
      create: (context) => SalesItemHiveModel()),
  ChangeNotifierProvider<RestTableUsageModel>(
      create: (context) => RestTableUsageModel()),
];
