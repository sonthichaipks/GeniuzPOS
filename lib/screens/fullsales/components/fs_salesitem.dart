import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolmodel.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/data/possales/salesitemmodel.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitem.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';

import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:provider/provider.dart';

class FullsaleItem extends StatefulWidget {
  final PosSumSalesItemCallResponse responseSumSalItem;
  final PosFncCallResponse responseInput;
  final TrackingScrollController trackingScrollController;
  final int modemnt;
  const FullsaleItem(
      {Key key,
      this.responseSumSalItem,
      this.responseInput,
      this.trackingScrollController,
      this.modemnt})
      : super(key: key);
  @override
  _FullsaleItem createState() => _FullsaleItem();
}

class _FullsaleItem extends State<FullsaleItem> {
  final _controller = ScrollController();
  int scrollmode = 0;
  int slcnt;
  int checkSelect = -1;

  @override
  void initState() {
    scrollmode = widget.modemnt;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<PosControlModel>().getItem();
    return Consumer<PosControlModel>(builder: (context, model, child) {
      context.watch<SalesItemHiveModel>().getItem();
      return Consumer<SalesItemHiveModel>(builder: (context, model, child) {
        widget.responseSumSalItem.doCalSalesItemSum(context);
        return Row(children: [
          Container(
            height: Palette.fullsalesitemheigth() - 45,
            width: Palette.fullsalesitemwidth() - 80,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.white),
                  left: BorderSide(width: 1.0, color: Colors.grey),
                  right: BorderSide(width: 1.0, color: Colors.grey),
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                )),
            child: SingleChildScrollView(
              controller: _controller,
              scrollDirection: Axis.vertical,
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.white),
                child: DataTable(
                  dataRowHeight: Palette.stdbutton_height * 0.4,
                  headingRowHeight: 0,
                  columnSpacing: 12,
                  horizontalMargin: 10,
                  //  minWidth: 1550,
                  showCheckboxColumn: false,
                  columns: PosInput().kTableColumnFullSales,
                  rows: saleslistFS(model),
                ),
              ),
            ),
          ),
          //),
        ]);
      });
    });
  }

//--- HIVE DATA STRUCTURES : SALES ITEM
//--- key : PLU], ITEM.TYPE] (0-sales item, 1-discount charge)
//--- info : Product Name], Discount/Charge detail]
//--- data : VatCode],QTY],PRICE],AMOUNT],DISCAMT/CHARGE AMT]
//---
  List<DataRow> saleslistFS(SalesItemHiveModel model) {
    var sallist = model.inventoryList
        .where((element) => PosControlFnc().checkSIT(element))
        .toList();
    if (slcnt != sallist.length) {
      scrollmode = 0;
    }
    slcnt = sallist.length;
    if (slcnt > 0 && scrollmode == 0 && widget.modemnt == 0) {
      _controller.jumpTo(_controller.position.maxScrollExtent + 30);
      //_controller.jumpTo(_lastEndOfScroll);
      scrollmode = 1;
    }
    return List<DataRow>.generate(slcnt, (indexno) {
      final SalesItem _salesItems = sallist[indexno];
      SalesItems _constSalesitem = PosInput().getSalesItem(_salesItems);
      return getRow(indexno, _constSalesitem, slcnt);
    });
  }

  void saySelect(int index, SalesItems saleitem) {
    checkSelect = index;
    showToast(context,
        rno.format(checkSelect) + saleitem.salesitem + ',' + saleitem.plu);
    setState(() {});
  }

  DataRow getRow(int index, _salesItems, int rowcnt) {
    return DataRow.byIndex(
        index: index,
        color: MaterialStateColor.resolveWith(
          (states) {
            if (index == rowcnt - 1) {
              return Palette.stdbutton_theme_4;
            } else {
              if (index == checkSelect) {
                return Colors.white;
                // return Palette.stdbutton_theme_4;
              } else {
                return Colors.white;
              }
            }
          },
        ),
        onSelectChanged: (bool value) {
          if (value) {
            if (index == 0 && rowcnt - 1 == 0) {
            } else {
              checkSelect = index;
              //saySelect(index, _salesItems);
              //_controller.jumpTo(currentScroll);
              scrollmode = 1;
            }
          } else {
            scrollmode = 0;
          }
        },
        cells: <DataCell>[
          DataCell(Container(
            width: Palette.stdbutton_width * 4.8,
            child: Text(
              (_salesItems.plu == '') ? '' : _salesItems.salesitem,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Micrsoft Sans Serif',
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                letterSpacing: 0.1,
              ),
            ),
          )),
          DataCell(Container(
            width: Palette.stdbutton_width * 3.2,
            child: Text(
              _salesItems.plu,
              textAlign: TextAlign.left,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Micrsoft Sans Serif',
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                letterSpacing: 0.1,
              ),
            ),
          )),
          DataCell(Container(
            width: Palette.stdbutton_width * 2.4,
            child: (_salesItems.plu == '')
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        width: 180,
                        height: 26,
                        child: Text(_salesItems.salesitem,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Micrsoft Sans Serif',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              letterSpacing: 0.1,
                            )),
                      ),
                      Spacer()
                    ],
                  )
                : Text(
                    _salesItems.disccode,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Micrsoft Sans Serif',
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      letterSpacing: 0.1,
                    ),
                  ),
          )),
          DataCell(Container(
            width: Palette.stdbutton_width * 2,
            child: (_salesItems.plu == '')
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                        width: 90,
                        height: 26,
                        child: Text(oCcy.format(_salesItems.amount),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Micrsoft Sans Serif',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              letterSpacing: 0.1,
                            )),
                      ),
                      Spacer()
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 6, 12, 0),
                        width: 125,
                        height: 26,
                        child: Text(oCcy.format(_salesItems.amount),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Micrsoft Sans Serif',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              letterSpacing: 0.1,
                            )),
                      ),
                      // Spacer(),
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 6, 5, 0),
                        width: 20,
                        height: 26,
                        child: Text(_salesItems.vatcode,
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Micrsoft Sans Serif',
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              letterSpacing: 0.1,
                            )),
                      ),
                    ],
                  ),
            // : Text(
            //     (oCcy.format(_salesItems.amount).padLeft(8, " ") +
            //             _salesItems.vatcode
            //                 .padRight(2, " ")
            //                 .padLeft(6, " "))
            //         .padLeft(30, " "),
            //     textAlign: TextAlign.right,
            //     style: const TextStyle(
            //       color: Colors.black,
            //       fontFamily: 'Micrsoft Sans Serif',
            //       fontWeight: FontWeight.bold,
            //       fontSize: 12.0,
            //       letterSpacing: 0.1,
            //     ),
            //   ),
          )),
          DataCell(
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                child: Text(''),
              ),
            ),
          ),
        ]);
  }
}
