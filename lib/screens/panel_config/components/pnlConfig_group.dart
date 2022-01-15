import 'package:com_csith_geniuzpos/data/posfunctions/pospanelctrl.dart';
import 'package:com_csith_geniuzpos/models/posmodels/groupPanel.dart';
import 'package:com_csith_geniuzpos/screens/panel_config/components/pnlConfig_button.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/models/models.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_grppanel.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';

typedef void GrpPnlBtnListCallback(PosButton input);

class GroupPanelForm extends StatefulWidget {
  final double starttop;
  final double startleft;
  final GrpPnlBtnListCallback pnlbtnInputs;
  final Function actdo;
  final List<GroupPanel> groupPanelList;

  const GroupPanelForm({
    Key key,
    @required this.starttop,
    @required this.startleft,
    @required this.pnlbtnInputs,
    @required this.actdo,
    @required this.groupPanelList,
  }) : super(key: key);
  @override
  _GroupPanel createState() => _GroupPanel();
}

class _GroupPanel extends State<GroupPanelForm> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String btntype = 'g';
    return Positioned(
      top: widget.starttop,
      left: widget.startleft,
      child: Row(
        children: [
          Container(
            height: Palette.stdbutton_height * 6 + Palette.stdspacer_widht * 6,
            width: Palette.stdbutton_width * (8 / 6) + Palette.stdspacer_widht,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.white),
                    left: BorderSide(width: 1.0, color: Colors.white),
                    right: BorderSide(width: 1.0, color: Colors.white),
                    bottom: BorderSide(width: 1.0, color: Colors.white),
                  )),
              child: InkWell(
                onTap: () {
                  // _responseInputThis.doEntry(widget.user.kybCode, 0, 0);
                  //  widget.pnlbtnInput(widget.user.kybCode);
                  // widget.pnlbtnInputs(value);
                },
                child: SingleChildScrollView(
                  child: Theme(
                    data:
                        Theme.of(context).copyWith(dividerColor: Colors.white),
                    child: DataTable2(
                      dataRowHeight:
                          Palette.stdbutton_height + Palette.stdspacer_widht,
                      headingRowHeight: 0,
                      columnSpacing: 0,
                      horizontalMargin: 0,
                      minWidth:
                          Palette.stdbutton_width + Palette.stdspacer_widht,
                      showCheckboxColumn: false,
                      columns: PosInput().kTableColumn1,
                      rows: List<DataRow>.generate(widget.groupPanelList.length,
                          (index) {
                        //real data of GroupPanelForm from WS:[psPanelGroupButton]
                        //-- must have list view of data to be sortable and update to server.  or copy!
                        // --- load WS:[psPanelGroupButton] and  put to PosButtons (bosbtn) by seq.

                        //----this the samples data----
                        // PosButton bosbtn = stdButtuon4[index];
                        PosButtonX bosbtn = PosPanelCtrl()
                            .getGBFromGpnl(widget.groupPanelList[index]);
                        //  PosButton(
                        //   label: 'คุกกี้',
                        //   imageUrl: '',
                        //   cmdCode: 'grpInput',
                        //   kybCode: '100000001',
                        //   btnXwid: 1.5,
                        //   btnFSize: 14,
                        //   btnColor: Palette.stdbutton_theme_0,
                        // ),
                        //---end samples data----

                        return DataRow.byIndex(index: index, cells: <DataCell>[
                          DataCell(Container(
                              decoration: BoxDecoration(
                                  color: Palette.stdbutton_theme_6,
                                  border: Border(
                                    top: BorderSide(
                                        width: 1.0, color: Colors.white),
                                    left: BorderSide(
                                        width: 1.0, color: Colors.white),
                                    right: BorderSide(
                                        width: 1.0, color: Colors.white),
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.white),
                                  )),
                              child: SizedBox(
                                height: Palette.stdbutton_height +
                                    Palette.stdspacer_widht,
                                width: Palette.stdbutton_width * (8 / 6) +
                                    Palette.stdspacer_widht,
                                child: Center(
                                    child: PanelButton(
                                  user: bosbtn,
                                  pnlbtnInput: (PosButton input) {
                                    //widget.pnlbtnInputs(input);
                                  },
                                  actdo: widget.actdo,
                                  btntype: btntype,
                                )),
                              ))),
                        ]);
                      }),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
