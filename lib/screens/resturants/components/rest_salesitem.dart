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

class RestsaleItem extends StatefulWidget {
  final PosSumSalesItemCallResponse responseSumSalItem;
  final PosFncCallResponse responseInput;
  final TrackingScrollController trackingScrollController;
  final int modemnt;
  const RestsaleItem(
      {Key key,
      this.responseSumSalItem,
      this.responseInput,
      this.trackingScrollController,
      this.modemnt})
      : super(key: key);
  @override
  _RestsaleItem createState() => _RestsaleItem();
}

class _RestsaleItem extends State<RestsaleItem> {
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

        return Row(
          children: [
            Container(
              height: Palette.restsalesitemheigth() - 30,
              width: Palette.restsalesitemwidth() - 4,
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
                    dataRowHeight: Palette.stdbutton_height * 0.42,
                    headingRowHeight: 0,
                    columnSpacing: 9,
                    horizontalMargin: 0,
                    //  minWidth: 1550,
                    showCheckboxColumn: false,
                    columns: PosInput().kTableColumRest,
                    rows: saleslistFB(model),
                  ),
                ),
              ),
            ),
            //),
          ],
        );
      });
    });
  }

  List<DataRow> saleslistFB(SalesItemHiveModel model) {
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

  DataRow getRow(int indexno, _salesItems, int rowcnt) {
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
                  //saySelect(indexno, _salesItems);
                  //_controller.jumpTo(currentScroll);
                  scrollmode = 1;
                }
              } else {
                scrollmode = 0;
              }
            },
            cells: [
                DataCell(Container(
                  height: (_salesItems.plu != '') ? 46 : 26,
                  width: Palette.stdbutton_width * 3,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 1,
                        left: 8,
                        child: Text(
                          (_salesItems.plu != '')
                              ? _salesItems.salesitem
                              : "   ",
                          textAlign: TextAlign.left,
                          softWrap: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Micrsoft Sans Serif',
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 3,
                        left: 14,
                        child: Text(
                          (_salesItems.plu != '') ? '' : _salesItems.salesitem,
                          textAlign: TextAlign.left,
                          softWrap: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Micrsoft Sans Serif',
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 20,
                        left: 8,
                        child: Text(
                          (_salesItems.plu != '') ? _salesItems.plu : '',
                          textAlign: TextAlign.left,
                          softWrap: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Micrsoft Sans Serif',
                            fontWeight: FontWeight.bold,
                            fontSize: 8,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                DataCell(Container(
                  height: (_salesItems.plu != '') ? 46 : 26,
                  width: Palette.stdbutton_width * 3,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 1,
                        right: 107,
                        child: Text(
                          (_salesItems.plu != '')
                              ? (oCcy
                                              .format(_salesItems.amount)
                                              .padLeft(6, " ") +
                                          _salesItems.vatcode
                                              .padRight(6, " ")
                                              .padLeft(8, " "))
                                      .padLeft(20, " ") +
                                  '\r\n'
                              : "   ",
                          textAlign: TextAlign.left,
                          softWrap: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Micrsoft Sans Serif',
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 3,
                        right: 135,
                        child: Text(
                          (_salesItems.plu != '')
                              ? ''
                              : oCcy.format(_salesItems.amount),
                          textAlign: TextAlign.left,
                          softWrap: false,
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Micrsoft Sans Serif',
                            fontWeight: FontWeight.bold,
                            fontSize: 10.0,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ]);
  }
}
