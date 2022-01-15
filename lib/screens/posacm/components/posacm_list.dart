import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolmodel.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/services/response/poscontrol_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/curve_button.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PosAcmSearchList extends StatefulWidget {
  final TextEditingController txt;
  // final PsMember getPsMember;
  final GetPosCtrlResponse responsePosCtrl;
  final List<PosCtrl> posAcmLists;
  final Function actdo;
  //final List<PosControl> posAcmLists;
  const PosAcmSearchList(
      {Key key, this.txt, this.responsePosCtrl, this.posAcmLists, this.actdo})
      : super(key: key);
  @override
  _PosAcmSearchList createState() => _PosAcmSearchList();
}

class _PosAcmSearchList extends State<PosAcmSearchList> {
  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController txtGet;
  List<TextEditingController> txts = [];
  List<FocusNode> txtfcs = [];

  String editValue = '';
  PosCtrl editslist;

  @override
  Widget build(BuildContext context) {
    txtGet = widget.txt;
    // int _rowPerPage = 3;
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
                  dataRowHeight: Palette.stdbutton_height * 0.78,
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

  List<DataRow> searchPSdemo_0() {
    return List<DataRow>.generate(32, (index) {
      index = 63 + index;
      final PosCtrl _searchpslist = posCtrlList[index];
      return getRow(index, _searchpslist);

      // final PosCtrl _searchpslist = widget.posAcmLists[index];
      // // PosAcm().posCycleAcm[index];
      // return getRow(index, _searchpslist);
    });
  }

  List<DataRow> searchPSdemo() {
    return List<DataRow>.generate(4, (index) {
      index = 56 + index;
      txts.add(TextEditingController());
      //txts[index - 57] = new TextEditingController();
      final PosCtrl _searchpslist = posCtrlList[index];
      return getRow(index, _searchpslist);

      // final PosCtrl _searchpslist = widget.posAcmLists[index];
      // // PosAcm().posCycleAcm[index];
      // return getRow(index, _searchpslist);
    });
  }

  Future<void> _handleSubmission(PosCtrl _posCtrl, String value) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Do you want to change this'),
          content: Text('Do you want to change this to "$value"? (OK/CANEL)'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () async {
                await updatePosCtrl(_posCtrl, value);
                Navigator.pop(context);
                //setState(() {});
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void updatePosCtrl(PosCtrl _posCtrl, String value) async {
    PosControlModel model =
        Provider.of<PosControlModel>(context, listen: false);

    PosControlFnc().updatePosControl(
        context,
        PosCtrl(
            itemcode: _posCtrl.itemcode,
            description: _posCtrl.description,
            groupcode: _posCtrl.groupcode,
            valuetext: value,
            valueint: _posCtrl.valueint,
            valuedbl: _posCtrl.valuedbl,
            image: _posCtrl.image));
  }

  DataRow getRow(int index, _searchpslist) {
    int checkselect = 0;

    bool submit = false;
    String _valuetext =
        PosControlFnc().getCurrentSettingValues(context, _searchpslist);

    txts[index - 56].text = _valuetext.replaceAll(']', ', ');
    txtfcs.add(new FocusNode());
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
              } else {}
            }
          }
        },
        cells: <DataCell>[
          DataCell(
            Container(
              padding: EdgeInsets.all(2),
              width: 256,
              child: Text(
                rno.format(index) +
                    _data.itemcode.replaceAll(']', ', ') +
                    '\r\n' +
                    _data.description,
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
              child: RawKeyboardListener(
                onKey: onTextFieldKey,
                focusNode: txtfcs[index - 56],
                child: TextField(
                  controller: txts[index - 56],
                  onChanged: (text) {
                    editslist = _searchpslist;
                    editValue = text;
                    checkselect = index;
                  },
                ),
              ),
            ),
          ),
        ]);

    return dataRow;
  }

  onTextFieldKey(RawKeyEvent event) {
    if (event is RawKeyUpEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        submit();
      } else if (event.data is RawKeyEventDataWeb) {
        final data = event.data as RawKeyEventDataWeb;
        if (data.keyLabel == 'Enter') submit();
      } else if (event.data is RawKeyEventDataAndroid) {
        final data = event.data as RawKeyEventDataAndroid;
        if (data.keyCode == 13) submit();
      }
    }
  }

  submit() {
    if (editValue != '') {
      _handleSubmission(editslist, editValue);
      // Navigator.pop(context);
    }
  }
}
