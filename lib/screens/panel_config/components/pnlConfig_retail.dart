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

class Rtpanel extends StatefulWidget {
  final double starttop;
  final double startleft;
  final PanelBtnListCallback pnlbtnInputs;
  final PosButton grpCode;
  final Function actdo;
  final List<ItemPanel> itemPanelList;
  final int maxList;
  final int pnlCount;
  const Rtpanel({
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
  _Rtpanel createState() => _Rtpanel();
}

class _Rtpanel extends State<Rtpanel> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String btntype = 'r';
    return Positioned(
      top: widget.starttop,
      left: widget.startleft,
      child: Row(
        children: [
          Container(
            height: Palette.stdbutton_height * 6 + Palette.stdspacer_widht * 6,
            width: Palette.stdbutton_width * (8 / 6) * 3 +
                Palette.stdspacer_widht * 3,
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
                        (Palette.stdbutton_width + Palette.stdspacer_widht) * 3,
                    showCheckboxColumn: false,
                    columns: PosInput().kTableColumn3,
                    rows: List<DataRow>.generate(widget.maxList, (index) {
                      PosButtonX bosbtn5, bosbtn6, bosbtn7;
                      int StIndex = index * widget.pnlCount;

                      if (StIndex < widget.itemPanelList.length) {
                        bosbtn5 = PosPanelCtrl()
                            .getListFromItemPnl(widget.itemPanelList[StIndex]);
                      } else {
                        bosbtn5 = PosPanelCtrl().getBlankPnl();
                      }

                      if (StIndex + 1 < widget.itemPanelList.length) {
                        bosbtn6 = PosPanelCtrl().getListFromItemPnl(
                            widget.itemPanelList[StIndex + 1]);
                      } else {
                        bosbtn6 = PosPanelCtrl().getBlankPnl();
                      }

                      if (StIndex + 2 < widget.itemPanelList.length) {
                        bosbtn7 = PosPanelCtrl().getListFromItemPnl(
                            widget.itemPanelList[StIndex + 2]);
                      } else {
                        bosbtn7 = PosPanelCtrl().getBlankPnl();
                      }

                      return DataRow.byIndex(index: index, cells: <DataCell>[
                        DataCell(Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 0),
                          child: (bosbtn5.label == 'Blank')
                              ? Container()
                              : Center(
                                  child: PanelButton(
                                  user: bosbtn5,
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
                          child: (bosbtn6.label == 'Blank')
                              ? Container()
                              : Center(
                                  child: PanelButton(
                                  user: bosbtn6,
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
                          child: (bosbtn7.label == 'Blank')
                              ? Container()
                              : Center(
                                  child: PanelButton(
                                  user: bosbtn7,
                                  pnlbtnInput: (PosButton input) {
                                    //widget.pnlbtnInputs(input);
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
