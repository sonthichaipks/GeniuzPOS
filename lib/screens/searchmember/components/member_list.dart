import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/data/sampledata.dart';
import 'package:com_csith_geniuzpos/models/persons/psmember.dart';
import 'package:com_csith_geniuzpos/services/response/person_reponse.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

class MemberSearchList extends StatefulWidget {
  final TextEditingController txt;
  // final PsMember getPsMember;
  final GetSearchMemberResponse responseMember;
  final List<PsMember> resultSearchList;
  const MemberSearchList(
      {Key key, this.txt, this.responseMember, this.resultSearchList})
      : super(key: key);
  @override
  _MemberSearchList createState() => _MemberSearchList();
}

class _MemberSearchList extends State<MemberSearchList> {
  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController txtGet;

  @override
  Widget build(BuildContext context) {
    txtGet = widget.txt;
    // context.watch<SalesItemHiveModel>().getItem();
    // return Consumer<SalesItemHiveModel>(builder: (context, model, child) {
    return Row(children: [
      GestureDetector(
        child: Container(
          height: Palette.stdbutton_height * 3.4,
          width: Palette.stdbutton_width * 9,
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
                  columnSpacing: 0,
                  horizontalMargin: 1,
                  // minWidth: 180,
                  showCheckboxColumn: false,
                  columns: PosInput().kTableColumnSearchMBList,
                  rows: searchMBdemo(),
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

  List<DataRow> searchMBdemo() {
    return List<DataRow>.generate(sampleMembers.length, (index) {
      // final PsMember _searchmblist = sampleMembers[index];
      final PsMember _searchmblist = widget.resultSearchList[index];
      return getRow(index, _searchmblist);
    });
  }

  DataRow getRow(int index, _searchmblist) {
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
            if (_searchmblist != null) {
              checkSelect += 1;
              if (checkSelect == 2) {
                Navigator.pop(context);
              } else {
                txtGet.text = _searchmblist.mbId;
                widget.responseMember
                    .getResultSearchToMemberForm(_searchmblist);
              }
            }
          }
        },
        cells: <DataCell>[
          DataCell(Container(
            height: double.infinity,
            width: 58,
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
                fontSize: 14.0,
                letterSpacing: 0.1,
              ),
            ),
          )),
          DataCell(
            Container(
              height: double.infinity,
              width: 229,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(width: 1.0, color: Colors.transparent),
                left: BorderSide(width: 1.0, color: Colors.transparent),
                right:
                    BorderSide(width: 1.0, color: Palette.stdbutton_theme_0_1),
                bottom: BorderSide(width: 1.0, color: Colors.transparent),
              )),
              child: Text(
                _searchmblist.mbId,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Tahoma',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ),
          DataCell(
            Container(
              height: double.infinity,
              width: 320,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(width: 1.0, color: Colors.transparent),
                left: BorderSide(width: 1.0, color: Colors.transparent),
                right: BorderSide(width: 1.0, color: Colors.transparent),
                bottom: BorderSide(width: 1.0, color: Colors.transparent),
              )),
              child: Text(
                _searchmblist.mbNameT,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Tahoma',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ),
        ]);
    return dataRow;
  }
}
