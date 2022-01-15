import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/pospanelctrl.dart';
import 'package:com_csith_geniuzpos/models/posmodels/touchPanel.dart';

import 'package:com_csith_geniuzpos/services/response/panel_response.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

class PnlConfigItem extends StatelessWidget {
  final PosFncCallResponse responseInput;
//  final TrackingScrollController trackingScrollController;
  final bool issalesitem = true;
  final List<TouchPanel> touchpnlList;
  final Function actdo;
  final LogPanelResponse responseTouchPanel;
  const PnlConfigItem(
      {Key key,
      this.responseInput,
      this.touchpnlList,
      this.actdo,
      this.responseTouchPanel})
      : super(key: key);

  void loadPanel(BuildContext context) {
    String pnlUrl = PosPanelCtrl().getPanelurl(context);
    //http://192.168.2.71:9393/TouchPanel
    responseTouchPanel.loadPanel(pnlUrl);
  }

  @override
  Widget build(BuildContext context) {
    loadPanel(context);
    return Row(
      children: [
        GestureDetector(
          child: Container(
            height: Palette.restsalesitemheigth() * 1 - 35,
            width: Palette.restsalesitemwidth() - 4,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.white),
                  left: BorderSide(width: 1.0, color: Colors.grey),
                  right: BorderSide(width: 1.0, color: Colors.grey),
                  bottom: BorderSide(width: 1.0, color: Colors.grey),
                )),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.white),
              child: ListView(
                // controller: trackingScrollController,
                shrinkWrap: true,
                children: [
                  DataTable(
                    dataRowHeight: Palette.stdbutton_height * 0.42,
                    headingRowHeight: 0,
                    columnSpacing: 9,
                    horizontalMargin: 0,
                    //  minWidth: 567,
                    showCheckboxColumn: false,
                    columns: PosInput().kTableColumRest,
                    rows: touchpanelRows(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<DataRow> touchpanelRows() {
    if (touchpnlList == null) {
      return List<DataRow>.generate(0, (indexno) {
        return null;
      });
    } else {
      return List<DataRow>.generate(touchpnlList.length, (indexno) {
        final TouchPanel _TouchPanel = touchpnlList[indexno];
        int rowcnt = touchpnlList.length;

        return getRow(indexno, _TouchPanel, rowcnt);
      });
    }
  }

  DataRow getRow(int indexno, touchpnlList, int rowcnt) {
    return DataRow.byIndex(
        index: indexno,
        onSelectChanged: (bool value) {
          if (value) {
            actdo(touchpnlList);
          }
        },
        cells: [
          DataCell(Container(
            height: 46,
            width: Palette.stdbutton_width * 3,
            child: Stack(
              children: [
                Positioned(
                  top: 1,
                  left: 8,
                  child: Text(
                    touchpnlList.touchPanelType +
                        ' ' +
                        touchpnlList.touchPanelDesc,
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
          DataCell(Container(
            height: 46,
            width: Palette.stdbutton_width * 3,
            child: Stack(
              children: [
                Positioned(
                  top: 3,
                  right: 135,
                  child: Text(
                    touchpnlList.posScreenType,
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
