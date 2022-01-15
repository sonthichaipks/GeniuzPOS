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

class RtsaleItem extends StatefulWidget {
  final PosSumSalesItemCallResponse responseSumSalItem;
  final PosFncCallResponse responseInput;
  final TrackingScrollController trackingScrollController;
  final int modemnt;
  const RtsaleItem(
      {Key key,
      this.responseSumSalItem,
      this.responseInput,
      this.trackingScrollController,
      this.modemnt})
      : super(key: key);
  @override
  _RtsaleItem createState() => _RtsaleItem();
}

class _RtsaleItem extends State<RtsaleItem> {
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

        int maxrows = 12;
        double rowHeight = (Palette.restsalesitemheigth() - 60) / maxrows;
        return Row(
          children: [
            Container(
              height: Palette.salesitemheigth(),
              width: Palette.salesitemwidth() - 1,
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
                    dataRowHeight: rowHeight, //Palette.stdbutton_height * 0.4,
                    headingRowHeight: 0,
                    columnSpacing: 1,
                    horizontalMargin: 6,
                    //  minWidth: 1550,
                    showCheckboxColumn: false,
                    columns: PosInput().kTableColumnRTsales,
                    rows: saleslistRT(model),
                  ),
                ),
              ),
            ),
          ],
        );
      });
    });
  }

  List<DataRow> saleslistRT(SalesItemHiveModel model) {
    var sallist = model.inventoryList
        .where((element) => PosControlFnc().checkSIT(element))
        .toList();
    if (slcnt != sallist.length) {
      scrollmode = 0;
    }
    slcnt = sallist.length;
    if (slcnt > 0 && scrollmode == 0 && widget.modemnt == 0) {
      _controller.jumpTo(_controller.position.maxScrollExtent + 30);
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

  DataRow getRow(int indexno, _salesItem, int rowcnt) {
    String vatcode = _salesItem.vatcode;
    if (vatcode != null) {
      vatcode = (vatcode.contains('*'))
          ? vatcode.substring(0, 2)
          : vatcode.substring(0, 1);
    } else {
      vatcode = '';
    }

    return (indexno > rowcnt)
        ? null
        : DataRow.byIndex(
            index: indexno,
            color: MaterialStateColor.resolveWith(
              (states) {
                if (indexno == rowcnt - 1) {
                  return Palette.stdbutton_theme_4;
                } else {
                  if (indexno == checkSelect) {
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
                if (indexno == 0 && rowcnt - 1 == 0) {
                } else {
                  checkSelect = indexno;
                  //saySelect(indexno, _salesItem);
                  //_controller.jumpTo(currentScroll);
                  scrollmode = 1;
                }
              } else {
                scrollmode = 0;
              }
            },
            cells: [
                DataCell(Container(
                  width: Palette.stdbutton_width * 3,
                  child: Text(
                    _salesItem.salesitem,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Micrsoft Sans Serif',
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                      letterSpacing: 0.1,
                    ),
                  ),
                )),
                DataCell(Container(
                  width: Palette.stdbutton_width * 2.4,
                  child: Text(
                    _salesItem.plu,
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Micrsoft Sans Serif',
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                      letterSpacing: 0.1,
                    ),
                  ),
                )),
                DataCell(Container(
                  width: Palette.stdbutton_width * 2.2,
                  child: (_salesItem.plu == '')
                      ? Column(
                          children: [
                            Container(
                              width: 125, // 105,
                              padding: EdgeInsets.fromLTRB(0, 5, 28, 0),
                              child: Text(
                                  oCcy
                                      .format(_salesItem.amount)
                                      .padLeft(15, "  "),
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Micrsoft Sans Serif',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
                                    letterSpacing: 0.1,
                                  )),
                            ),
                            Spacer()
                          ],
                        )
                      : Row(
                          children: [
                            Container(
                              width: 125, // 105,
                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Text(
                                  oCcy
                                      .format(_salesItem.amount)
                                      .padLeft(15, "  "),
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Micrsoft Sans Serif',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
                                    letterSpacing: 0.1,
                                  )),
                            ),
                            // Spacer(),
                            Container(
                              width: 20, // 105,
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(vatcode,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Micrsoft Sans Serif',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0,
                                    letterSpacing: 0.1,
                                  )),
                            ),
                          ],
                        ),
                  // : Text(
                  //     (oCcy.format(_salesItem.amount).padLeft(12, "  ") +
                  //             _salesItem.vatcode
                  //                 .padRight(8, " ")
                  //                 .padLeft(14, " "))
                  //         .padLeft(30, " "),
                  //     textAlign: TextAlign.right,
                  //     style: const TextStyle(
                  //       color: Colors.black,
                  //       fontFamily: 'Micrsoft Sans Serif',
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 10.0,
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
