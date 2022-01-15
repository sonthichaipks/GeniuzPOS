class SalesItemSummary {
  SalesItemSummary(
      this.itemcount,
      this.discitemcount,
      this.totalqty,
      this.totaldisc,
      this.totalchagre,
      this.totalamount,
      this.totalvat,
      this.lsalesitem,
      this.ldischgitem,
      this.lreceiptitem);
  // this.totalcharge);
  final int itemcount;
  final int discitemcount;
  final double totalqty;
  final double totaldisc;
  final double totalchagre;
  final double totalamount;
  final double totalvat;
  final int lsalesitem;
  final int ldischgitem;
  final int lreceiptitem;
  //final double totalcharge;
}
