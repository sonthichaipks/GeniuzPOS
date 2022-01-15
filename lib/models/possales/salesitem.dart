import 'package:hive/hive.dart';

part 'salesItem.g.dart';

@HiveType(typeId: 0)
class SalesItem {
  @HiveField(0)
  final String saleskey;
  @HiveField(1)
  final String salesinfo;
  @HiveField(2)
  final String salesdata;

  SalesItem({this.saleskey, this.salesinfo, this.salesdata});
}
