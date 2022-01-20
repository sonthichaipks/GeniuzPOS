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

  @override
  void initState() {
    posConfigList.add(posCtrlList[59]);
    posConfigList.add(posCtrlList[58]);
    posConfigList.add(posCtrlList[01]);
    posConfigList.add(posCtrlList[56]);
    posConfigList.add(posCtrlList[68]);
    posConfigList.add(posCtrlList[69]);

    for (int i = 0; i < 6; ++i) {
      txts.add(new TextEditingController());
      txtfcs.add(new FocusNode());
      setFocusListen(i);
    }

    super.initState();
  }

  void setFocusListen(int index) {
    txtfcs[index].addListener(() {
      txts[index].selection = TextSelection.fromPosition(
          TextPosition(offset: txts[index].text.length));
    });
  }

  TextEditingController txtGet;
  List<TextEditingController> txts = [];
  List<FocusNode> txtfcs = [];
  List<PosCtrl> posConfigList = new List<PosCtrl>();

  String editValue = '';
  PosCtrl editslist;

  @override
  Widget build(BuildContext context) {
    txtGet = widget.txt;
    // int _rowPerPage = 3;
    return Row(children: [
      GestureDetector(
        child: Container(
          height: Palette.stdbutton_height * 4.7,
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
                height: Palette.stdbutton_height * 6.6,
                child: DataTable2(
                  showCheckboxColumn: false,
                  headingRowHeight: 0,
                  dataRowHeight: Palette.stdbutton_height * 0.78,
                  columnSpacing: 0,
                  horizontalMargin: 1,
                  columns: PosInput().kTableColumnSearchPOSCTRLList,
                  rows: searchConfig(),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  List<DataRow> searchConfig() {
    return List<DataRow>.generate(posConfigList.length, (index) {
      final PosCtrl _searchpslist = posConfigList[index];
      return getRowConfig(index, _searchpslist, _searchpslist.itemcode);
    });
  }

  DataRow getRowConfig(int index, _searchpslist, String itemcode) {
    int checkselect = 0;

    bool submit = false;
    String _valuetext =
        PosControlFnc().getCurrentSettingValuesById(context, itemcode);

    txts[index].text = _valuetext.replaceAll(']', ', ');

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
                focusNode: txtfcs[index],
                child: TextField(
                  controller: txts[index],
                  onChanged: (text) {
                    editslist = _searchpslist;
                    editValue = text;
                    checkselect = index;
                  },
                  style: TextStyle(
                    fontFamily: 'Tahoma',
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(12.0),
                    labelStyle: TextStyle(color: Colors.grey),
                    labelText: 'Entry value and then [ENTER]',
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueAccent)),
                  ),
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
      _handleSubmission(editslist, editValue.trim());
    }
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
                await widget.actdo(_posCtrl, value);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
