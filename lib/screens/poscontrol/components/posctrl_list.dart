import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/services/response/poscontrol_response.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

class PosCtrlSearchList extends StatefulWidget {
  final TextEditingController txt;
  // final PsMember getPsMember;
  final GetPosCtrlResponse responsePosCtrl;
  final List<PosControl> posCtrlLists;
  const PosCtrlSearchList(
      {Key key, this.txt, this.responsePosCtrl, this.posCtrlLists})
      : super(key: key);
  @override
  _PosCtrlSearchList createState() => _PosCtrlSearchList();
}

class _PosCtrlSearchList extends State<PosCtrlSearchList> {
  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController txtGet;

  @override
  Widget build(BuildContext context) {
    txtGet = widget.txt;

    return Row(children: [
      GestureDetector(
        child: Container(
          height: Palette.stdbutton_height * 7.4,
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
              //  child:
              child: Container(
                height: Palette.stdbutton_height * 7.4,
                child: DataTable2(
                  showCheckboxColumn: false,
                  headingRowHeight: 0,
                  dataRowHeight: Palette.stdbutton_height * 0.58,
                  columnSpacing: 0,
                  horizontalMargin: 1,
                  columns: PosInput().kTableColumnSearchPOSCTRLList,
                  rows: searchPSdemo(),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  List<DataRow> searchPSdemo() {
    return List<DataRow>.generate(95, (index) {
      final PosCtrl _searchpslist = posCtrlList[index];
      return getRow(index, _searchpslist);
    });
  }

  DataRow getRow(int index, _searchpslist) {
    int checkselect = 0;
    String _valuetext =
        PosControlFnc().getCurrentSettingValues(context, _searchpslist);

    var _data = PosControlFnc().getPosCtrlOpt(_searchpslist, _valuetext);
    if (_data == null) {
      _data = _searchpslist;
    }
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
            if (_searchpslist != null) {
              checkselect += 1;
              if (checkselect == 2) {
                Navigator.pop(context);
              } else {
                // txtGet.text = _data.itemcode;
                widget.responsePosCtrl.getPosCtrl(_data, index);
              }
            }
          }
        },
        cells: <DataCell>[
          DataCell(
            Container(
              padding: EdgeInsets.all(2),
              width: 196,
              child: Text(
                rno.format(index) + _data.description,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Tahoma',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ),
          DataCell(
            Container(
              width: 500,
              child: Text(
                _valuetext,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Tahoma',
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ),
        ]);

    return dataRow;
  }
}
