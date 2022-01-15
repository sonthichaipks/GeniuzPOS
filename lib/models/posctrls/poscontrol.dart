import 'package:hive/hive.dart';

part 'poscontrol.g.dart';

@HiveType(typeId: 2)
class PosControl {
  @HiveField(0)
  final String posctrlkey;
  @HiveField(1)
  final String posctrlinfo;
  @HiveField(2)
  final String posctrldata;

  PosControl({this.posctrlkey, this.posctrlinfo, this.posctrldata});
}

class PosCtrl {
  PosCtrl(
      {this.itemcode,
      this.description,
      this.groupcode,
      this.valuetext, // product Group,
      this.valueint, // group name,
      this.valuedbl,
      this.image});

  final String itemcode;
  final String description;
  final String groupcode;
  final String valuetext;
  final int valueint;
  final double valuedbl;
  final String image;
}
