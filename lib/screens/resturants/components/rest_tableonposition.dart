import 'package:com_csith_geniuzpos/models/buttons/hive_tableusages.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/models/buttons/padbuttons.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:hive/hive.dart';

Widget tableOnPositionButtons(
  BuildContext context,
  PosFncCallResponse _responseInput,
  PadButton posbtns,
  TableUsage tableAndPosition,
  // int tableno,
) {
  return TableOnPositionCard(
    posbtn: posbtns,
    onPressed: () {
      FncItems().tablecenter(context, _responseInput, tableAndPosition);
    },
    tableAndPosition: tableAndPosition,
    // tableno: tableno,
  );
}

class TableOnPositionCard extends StatefulWidget {
  final PadButton posbtn;
  final Function onPressed;
  final TableUsage tableAndPosition;
  // final int tableno;
  const TableOnPositionCard({
    Key key,
    @required this.posbtn,
    @required this.onPressed,
    @required this.tableAndPosition,
    //  @required this.tableno,
  }) : super(key: key);

  @override
  _PTableOnPositionCard createState() => _PTableOnPositionCard();
}

class _PTableOnPositionCard extends State<TableOnPositionCard>
    with SingleTickerProviderStateMixin
    implements TableUpdateCallBack {
  TableUpdateCallResponse _tablectrl;
  String zoneno, tableno, comms, sColor, tableDesc;
  double _scale, _x, _y, fSize;
  Offset offset;
  TableUsage _tableAndPosition;
  _PTableOnPositionCard();

  BinaryWriter writer;
  String _saveTable;
  AnimationController _controller;
  @override
  void initState() {
    _tableAndPosition = widget.tableAndPosition;
    //Provider.of<RestTableUsageModel>(context, listen: false);
    zoneno = 'Z02';
    tableno = 'A01';
    _x = 100;
    _y = 100;
    sColor = 'Color(0xffa6e4ff)';
    fSize = 14;
    if (_tableAndPosition.tablekey != "null") {
      //----tablekey
      var t = _tableAndPosition.tablekey.split(']');
      if (t.length > 0) {
        zoneno = t[0];
      }
      if (t.length > 1) {
        tableno = t[1];
      }
      //----tableinfo
      var f = _tableAndPosition.tableinfo.split(']');
      if (f.length > 0) {
        comms = f[0];
      }
      if (f.length > 1) {
        tableDesc = f[1];
      }
      //----tabledata
      var l = _tableAndPosition.tabledata.split(']');
      //----position
      if (l[0].indexOf(',') > 0) {
        var w = l[0].split(',');
        if (w.length > 0) {
          _x = double.parse(w[0]);
          _y = double.parse(w[1]);
        }
      }
      //----color
      if (l.length > 1) {
        sColor = l[1];
      }
      //----FontSize
      if (l.length > 2) {
        fSize = double.parse(l[2]);
      }
    }

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });

    _tablectrl = new TableUpdateCallResponse(this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    //  Hive.close();
  }

  int press = 0;

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return Positioned(
        top: _y,
        left: _x,
        child: Draggable(
          child: button(),
          feedback: button(),
          childWhenDragging: Container(),
          onDraggableCanceled: (Velocity velocity, Offset offset) {
            setState(() {
              this.offset = offset;
            });
          },
          onDragEnd: (dragDetails) {
            setState(() {
              this.offset = dragDetails.offset;
              if (dragDetails.offset.dx != null) {
                _x = dragDetails.offset.dx.toDouble();
                _y = dragDetails.offset.dy.toDouble();
              }
              _onupdateTable(
                  context, zoneno, tableno, 'txtInput]middle room]4]', _x, _y);
              widget.onPressed();
            });
          },
        ));
    //});
  }

  Widget button() {
    return Container(
      height: Palette.stdbutton_height * widget.posbtn.btnXwid,
      width: Palette.stdbutton_width * widget.posbtn.btnXwid,
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: GestureDetector(
          onTapDown: _tapDown,
          onTapUp: _tapUp,
          child: Transform.scale(
            scale: _scale,
            child: Container(
              height: Palette.stdbutton_height * widget.posbtn.btnXwid,
              width: Palette.stdbutton_width * widget.posbtn.btnXwid,
              margin: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Center(
                    child: CircleAvatar(
                        radius: 10.0,
                        backgroundColor: (sColor != null)
                            ? Palette.colorConvert(sColor)
                            : Colors.blue,
                        child: CircleAvatar(
                          radius: 10.0,
                          backgroundColor: Colors.transparent,
                        )),
                  ),
                  (tableno == '')
                      ? Container()
                      : Positioned(
                          top: 36.0,
                          left: 6.0,
                          right: 6.0,
                          bottom: 0.0,
                          child: Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: '',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: tableno,
                                      style: TextStyle(
                                        fontFamily: 'Leelawadee',
                                        fontWeight: FontWeight.w400,
                                        fontSize: fSize,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          )),
    );
  }

  void _tapDown(TapDownDetails details) {
    press = 1;
    details.localPosition.scale(100, 200);
    widget.onPressed();
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    press = 0;
    widget.onPressed();
    _controller.reverse();
  }

  _onupdateTable(BuildContext context, String zoneno, String tableno,
      String info, double _x, double _y) {
    _tablectrl.doUpdateTable(context, zoneno, tableno, info, _x, _y);
  }

  @override
  void onCallTableUpdateError(String error) {
    //   _saveTable = error;
  }

  @override
  void onCallTableUpdateSuccess(String result) {
    setState(() {
      _saveTable = result;
    });
  }
}
