import 'package:com_csith_geniuzpos/data/posfunctions/posbdcctrl.dart';

import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/data/possales/bdcitemmodel.dart';

import 'package:com_csith_geniuzpos/models/possales/salesitem.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:com_csith_geniuzpos/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:provider/provider.dart';

class BillDisChgItem extends StatefulWidget {
  final int lastsalesitem;
  const BillDisChgItem({
    Key key,
    this.lastsalesitem,
  }) : super(key: key);
  @override
  _BillDisChgItem createState() => _BillDisChgItem();
}

class _BillDisChgItem extends State<BillDisChgItem> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<BillDCItemHiveModel>().getItem();
    return Consumer<BillDCItemHiveModel>(builder: (context, model, child) {
      return Row(
        children: [
          GestureDetector(
            // onPanUpdate: (details) {
            //   if (details.delta.dx > 0) {
            //     MaterialPageRoute route = MaterialPageRoute(
            //         builder: (value) => NavScreen(screenmenu: 4));
            //     Navigator.push(context, route);
            //   } else {
            //     MaterialPageRoute route = MaterialPageRoute(
            //         builder: (value) => NavScreen(screenmenu: 3));
            //     Navigator.push(context, route);
            //   }
            // },
            child: Container(
              height: Palette.stdbutton_height * 3.25,
              width: Palette.restsalesitemwidth() * 1.1,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.grey),
                    left: BorderSide(width: 1.0, color: Colors.grey),
                    right: BorderSide(width: 1.0, color: Colors.grey),
                    bottom: BorderSide(width: 1.0, color: Colors.grey),
                  )),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.white),
                  child: DataTable(
                    dataRowHeight: Palette.stdbutton_height * 0.30,
                    headingRowHeight: 0,
                    columnSpacing: 9,
                    horizontalMargin: 2,
                    showCheckboxColumn: false,
                    columns: PosInput().kTableColumBilDisChg,
                    rows: saleslistFB(model),
                    // rows: (model.inventoryList.length > 0)
                    //     ? saleslistFB(model)
                    //     : saleslistFBDemo(),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  List<DataRow> saleslistFB(BillDCItemHiveModel model) {
    var sallist = model.inventoryList
        .where((element) => PosBDCCtrl().checkBDC(element))
        .toList();
    int slcnt;
    slcnt = sallist.length;
    return List<DataRow>.generate(slcnt, (indexno) {
      final SalesItem _salesItems = sallist[indexno];
      SalesItems _constSalesitem = PosInput().getSalesItem(_salesItems);
      return getRow(indexno, _constSalesitem);
    });
  }

  DataRow getRow(int indexno, _salesItems) {
    return DataRow.byIndex(index: indexno, cells: <DataCell>[
      DataCell(Container(
        width: Palette.stdbutton_width * 3.5,
        child: Text(
          rno.format(indexno + 1).padLeft(4, " ") +
              ' ' +
              _salesItems.salesitem.toString().trim(),
          textAlign: TextAlign.left,
          softWrap: true,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Micrsoft Sans Serif',
            fontWeight: FontWeight.w300,
            fontSize: 10.0,
            letterSpacing: 0.1,
          ),
        ),
      )),
      DataCell(Container(
        width: Palette.stdbutton_width * 1.46,
        child: Text(
          oCcy.format(_salesItems.amount).padLeft(20, " "),
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Micrsoft Sans Serif',
            fontWeight: FontWeight.w300,
            fontSize: 10.0,
            letterSpacing: 0.1,
          ),
        ),
      )),
    ]);
  }
}
