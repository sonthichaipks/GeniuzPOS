import 'package:com_csith_geniuzpos/data/posfunctions/pospanelctrl.dart';
import 'package:com_csith_geniuzpos/models/posmodels/itemPanel.dart';
import 'package:com_csith_geniuzpos/screens/panel_config/components/pnlConfig_button.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/models/models.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';

typedef void PanelBtnListCallback(PosButton input);

class Fbpanel extends StatefulWidget {
  final double starttop;
  final double startleft;
  final PanelBtnListCallback pnlbtnInputs;
  final PosButton grpCode;
  final Function actdo;
  final List<ItemPanel> itemPanelList;
  final int maxList;
  final int pnlCount;
  const Fbpanel({
    Key key,
    @required this.starttop,
    @required this.startleft,
    @required this.pnlbtnInputs,
    @required this.grpCode,
    @required this.actdo,
    @required this.itemPanelList,
    @required this.maxList,
    @required this.pnlCount,
  }) : super(key: key);
  @override
  _Fbpanel createState() => _Fbpanel();
}

class _Fbpanel extends State<Fbpanel> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String btntype = 'f';
    return Positioned(
      top: widget.starttop,
      left: widget.startleft,
      child: Row(
        children: [
          Container(
            height: Palette.stdbutton_height * 6 + Palette.stdspacer_widht * 6,
            width: Palette.stdbutton_width * (8 / 6) * 5 +
                Palette.stdspacer_widht * 5,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.white),
                    left: BorderSide(width: 1.0, color: Colors.white),
                    right: BorderSide(width: 1.0, color: Colors.white),
                    bottom: BorderSide(width: 1.0, color: Colors.white),
                  )),
              child: SingleChildScrollView(
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.white),
                  child: DataTable2(
                    dataRowHeight:
                        Palette.stdbutton_height + Palette.stdspacer_widht,
                    headingRowHeight: 0,
                    columnSpacing: 6,
                    horizontalMargin: 6,
                    minWidth:
                        (Palette.stdbutton_width + Palette.stdspacer_widht) * 5,
                    showCheckboxColumn: false,
                    columns: PosInput().kTableColumn5,
                    rows: List<DataRow>.generate(widget.maxList, (index) {
                      PosButtonX bosbtn, bosbtn1, bosbtn2, bosbtn3, bosbtn4;
                      int StIndex = index * widget.pnlCount;

                      if (StIndex < widget.itemPanelList.length) {
                        bosbtn = PosPanelCtrl()
                            .getListFromItemPnl(widget.itemPanelList[StIndex]);
                      } else {
                        bosbtn = PosPanelCtrl().getBlankPnl();
                      }
                      if (StIndex + 1 < widget.itemPanelList.length) {
                        bosbtn1 = PosPanelCtrl().getListFromItemPnl(
                            widget.itemPanelList[StIndex + 1]);
                      } else {
                        bosbtn1 = PosPanelCtrl().getBlankPnl();
                      }
                      if (StIndex + 2 < widget.itemPanelList.length) {
                        bosbtn2 = PosPanelCtrl().getListFromItemPnl(
                            widget.itemPanelList[StIndex + 2]);
                      } else {
                        bosbtn2 = PosPanelCtrl().getBlankPnl();
                      }
                      if (StIndex + 3 < widget.itemPanelList.length) {
                        bosbtn3 = PosPanelCtrl().getListFromItemPnl(
                            widget.itemPanelList[StIndex + 3]);
                      } else {
                        bosbtn3 = PosPanelCtrl().getBlankPnl();
                      }
                      if (StIndex + 4 < widget.itemPanelList.length) {
                        bosbtn4 = PosPanelCtrl().getListFromItemPnl(
                            widget.itemPanelList[StIndex + 4]);
                      } else {
                        bosbtn4 = PosPanelCtrl().getBlankPnl();
                      }

                      return DataRow.byIndex(index: index, cells: <DataCell>[
                        DataCell(Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 0),
                          child: (bosbtn.label == 'Blank')
                              ? Container()
                              : Center(
                                  child: PanelButton(
                                  user: bosbtn,
                                  pnlbtnInput: (PosButton input) {
                                    //widget.pnlbtnInputs(input);
                                  },
                                  actdo: widget.actdo,
                                  btntype: btntype,
                                )),
                        )),
                        DataCell(Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 0),
                          child: (bosbtn1.label == 'Blank')
                              ? Container()
                              : Center(
                                  child: PanelButton(
                                  user: bosbtn1,
                                  pnlbtnInput: (PosButton input) {
                                    // widget.pnlbtnInputs(input);
                                  },
                                  actdo: widget.actdo,
                                  btntype: btntype,
                                )),
                        )),
                        DataCell(Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 0),
                          child: (bosbtn2.label == 'Blank')
                              ? Container()
                              : Center(
                                  child: PanelButton(
                                  user: bosbtn2,
                                  pnlbtnInput: (PosButton input) {
                                    //widget.pnlbtnInputs(input);
                                  },
                                  actdo: widget.actdo,
                                  btntype: btntype,
                                )),
                        )),
                        DataCell(Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 0),
                          child: (bosbtn3.label == 'Blank')
                              ? Container()
                              : Center(
                                  child: PanelButton(
                                  user: bosbtn3,
                                  pnlbtnInput: (PosButton input) {
                                    //widget.pnlbtnInputs(input);
                                  },
                                  actdo: widget.actdo,
                                  btntype: btntype,
                                )),
                        )),
                        DataCell(Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 0),
                          child: (bosbtn4.label == 'Blank')
                              ? Container()
                              : Center(
                                  child: PanelButton(
                                  user: bosbtn4,
                                  pnlbtnInput: (PosButton input) {
                                    // widget.pnlbtnInputs(input);
                                  },
                                  actdo: widget.actdo,
                                  btntype: btntype,
                                )),
                        )),
                      ]);
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void showMyDialog(BuildContext context, String response) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(response),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(response),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("CLOSE"),
            onPressed: () {
              //appWindow.close();
            },
          ),
        ],
      );
    },
  );
}
