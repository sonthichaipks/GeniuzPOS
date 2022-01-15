import 'package:hive/hive.dart';

part 'hive_tableusages.g.dart';

@HiveType(typeId: 1)
class TableUsage {
  @HiveField(0)
  final String tablekey;
  @HiveField(1)
  final String tableinfo;
  @HiveField(2)
  final String tabledata;

  TableUsage({this.tablekey, this.tableinfo, this.tabledata});

  // @HiveField(0)
  // final String zoneno;
  // @HiveField(1)
  // final String tableno;
  // @HiveField(2)
  // final String label;
  // @HiveField(3)
  // final String seatcount;
  // @HiveField(4)
  // final String imageUrl;
  // @HiveField(5)
  // final String cmdCode;
  // @HiveField(6)
  // final String kybCode;
  // @HiveField(7)
  // final String kybTBLR;
  // @HiveField(8)
  // final String btnColor;
  // @HiveField(9)
  // final String btnPosXStart;
  // @HiveField(10)
  // final String btnPosYStart;
  // @HiveField(11)
  // final String btnXwid;
  // @HiveField(12)
  // final String btnYheight;
  // @HiveField(13)
  // final String btnFSize;
  // @HiveField(14)
  // final String isViewed;

  // TableUsage(
  //     {
  //   this.zoneno,
  // this.tableno,
  // this.label,
  // this.seatcount,
  // this.imageUrl,
  // this.cmdCode,
  // this.kybCode,
  // this.kybTBLR,
  // this.btnColor,
  // this.btnPosXStart,
  // this.btnPosYStart,
  // this.btnXwid,
  // this.btnYheight,
  // this.btnFSize,
  // this.isViewed
  // });
}
