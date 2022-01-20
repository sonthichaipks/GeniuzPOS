import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolmodel.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:provider/provider.dart';

class PosParamSearchList extends StatefulWidget {
  final Function actdo;
  final int mode;
  final List<PosControl> posCtrlLists;
  const PosParamSearchList({Key key, this.posCtrlLists, this.actdo, this.mode})
      : super(key: key);
  @override
  _PosParamSearchList createState() => _PosParamSearchList();
}

class _PosParamSearchList extends State<PosParamSearchList> {
  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController txtGet;

  ///List<PosControl> posCtrlLists;
  @override
  Widget build(BuildContext context) {
//txtGet = widget.txt;

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
                  rows: searchPSdemo(widget.posCtrlLists),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
    //});
  }

  List<DataRow> searchPSdemo(List<PosControl> posCtrlLists) {
    return List<DataRow>.generate(posCtrlLists.length, (index) {
      final PosControl _searchlist = posCtrlLists[index];
      return getRow(index, _searchlist);
    });
  }

  DataRow getRow(int index, _searchlist) {
    int checkselect = 0;
    // String _valuetext =
    //     PosControlFnc().getCurrentSettingValues(context, _searchpslist);

    // var _data = PosControlFnc().getPosCtrlOpt(_searchpslist, _valuetext);
    // if (_data == null) {
    //   _data = _searchpslist;
    // }
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
            if (_searchlist != null) {
              checkselect += 1;
              if (checkselect == 2) {
                Navigator.pop(context);
              } else {
                if (widget.mode == 0) {
                  widget.actdo(_searchlist);
                  Navigator.pop(context);
                }
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
                rno.format(index) + _searchlist.posctrlinfo,
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
                _searchlist.posctrldata,
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
