import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posdatactrl.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/models/posmodels/csplu.dart';
import 'package:com_csith_geniuzpos/services/response/posdata_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

class PluSearchList extends StatefulWidget {
  final TextEditingController txt;
  final List<CsPlu> getPluList;
  final GetPluResponse responsePlu;
  const PluSearchList({Key key, this.txt, this.responsePlu, this.getPluList})
      : super(key: key);
  @override
  _PluSearchList createState() => _PluSearchList();
}

class _PluSearchList extends State<PluSearchList> {
  @override
  void dispose() {
    super.dispose();
  }

  List<CsPlu> _pnlPlu;
  TextEditingController txtGet;
  void getPluPnlList(String url) async {
    _pnlPlu = await PosDataCtrl().getPlusWS(url);
  }

  @override
  Widget build(BuildContext context) {
    txtGet = widget.txt;
    if (widget.getPluList.length == 0) {
      Navigator.of(context).pop();
    }
    return Row(children: [
      GestureDetector(
        child: Container(
          height: Palette.stdbutton_height * 3,
          width: Palette.stdbutton_width * 7,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.white),
                left: BorderSide(width: 1.0, color: Colors.grey),
                right: BorderSide(width: 1.0, color: Colors.grey),
                bottom: BorderSide(width: 1.0, color: Colors.grey),
              )),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.white),
              child: Container(
                child: DataTable(
                  dataRowHeight: Palette.stdbutton_height * 0.38,
                  headingRowHeight: 0,
                  columnSpacing: 1,
                  horizontalMargin: 6,
                  // minWidth: 180,
                  showCheckboxColumn: false,
                  columns: PosInput().kTableColumnSearchMBList,
                  rows: searchPlu(),
                  //  rows: saleslistFS(model),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
    // });
  }

  List<DataRow> searchPlu() {
    // } else {
    return List<DataRow>.generate(widget.getPluList.length, (index) {
      final CsPlu _searchplulist = widget.getPluList[index];
      return getRow(index, _searchplulist);
    });
    // }
  }

  DataRow getRow(int index, _searchplulist) {
    int checkSelect = 0;
    var dataRow = DataRow.byIndex(
        index: index,
        color: MaterialStateColor.resolveWith(
          (states) {
            if ((index.isEven)) {
              return Palette.stdbutton_theme_0_1;
            } else {
              return Colors.white;
            }
          },
        ),
        onSelectChanged: (bool value) {
          if (value) {
            if (_searchplulist != null) {
              checkSelect += 1;
              if (checkSelect == 2) {
                Navigator.pop(context);
              } else {
                txtGet.text = _searchplulist.pluCode;
                widget.responsePlu.getPlu(_searchplulist);
              }
            }
          }
        },
        cells: <DataCell>[
          DataCell(Container(
            height: double.infinity,
            width: 28,
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(width: 1.0, color: Colors.transparent),
              left: BorderSide(width: 1.0, color: Colors.transparent),
              right: BorderSide(width: 1.0, color: Palette.stdbutton_theme_0_1),
              bottom: BorderSide(width: 1.0, color: Colors.transparent),
            )),
            child: Text(
              (index + 1).toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'Tahoma',
                fontWeight: FontWeight.bold,
                fontSize: 10.0,
                letterSpacing: 0.1,
              ),
            ),
          )),
          DataCell(
            Container(
              // height: double.infinity,
              width: Palette.stdbutton_width * 1.8,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(width: 1.0, color: Colors.transparent),
                left: BorderSide(width: 1.0, color: Colors.transparent),
                right:
                    BorderSide(width: 1.0, color: Palette.stdbutton_theme_0_1),
                bottom: BorderSide(width: 1.0, color: Colors.transparent),
              )),
              child: Text(
                _searchplulist.pluCode,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Tahoma',
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ),
          DataCell(
            Container(
              width: Palette.stdbutton_width * 3.9,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(width: 1.0, color: Colors.transparent),
                left: BorderSide(width: 1.0, color: Colors.transparent),
                right: BorderSide(width: 1.0, color: Colors.transparent),
                bottom: BorderSide(width: 1.0, color: Colors.transparent),
              )),
              child: Text(
                _searchplulist.pluShortDesc,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Tahoma',
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ),
        ]);
    return dataRow;
  }
}
