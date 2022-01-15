import 'package:com_csith_geniuzpos/resources/fnccal.dart';

class SalesItems {
  SalesItems(this.salesitem, this.plu, this.qty, this.price, this.disccode,
      this.disc, this.amount, this.vatcode, this.unit, this.refline);
  final String salesitem;
  final String plu;
  final double qty;
  final double price;
  final String disccode;
  final double disc;
  final double amount;
  final String vatcode;
  final String unit;
  final int refline;
  bool selected = false;

  String getIndex(int index) {
    switch (index) {
      case 0:
        return vatcode;
      case 1:
        return salesitem.padRight(30).substring(0, 29);
      case 2:
        return oCcy.format(qty).padLeft(10, " ");
      case 3:
        return unit;
      case 4:
        return oCcy.format(price).padLeft(12, " ");
      case 5:
        return oCcy.format(disc).padLeft(12, " ");
      case 6:
        return oCcy.format(amount).padLeft(16, " ");
    }
    return '';
  }
}
