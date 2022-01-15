import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/models/buttons/padbuttons.dart';
import 'package:com_csith_geniuzpos/models/buttons/tablemaster.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';

Widget menuPositionButtons(
  BuildContext context,
  PosFncCallResponse _responseInput,
  PadButton posbtns,
  TableAndPostions tableAndPosition,
) {
  return Positioned(
    top: tableAndPosition.btnPosYStart,
    left: tableAndPosition.btnPosXStart,
    child: MenuPositionCard(
      posbtn: posbtns,
      onPressed: () {
        FncItems().menucenter(context, _responseInput, tableAndPosition);
      },
      tableAndPosition: tableAndPosition,
    ),
  );
}

class MenuPositionCard extends StatefulWidget {
  final PadButton posbtn;
  final Function onPressed;
  final TableAndPostions tableAndPosition;
  const MenuPositionCard({
    Key key,
    @required this.posbtn,
    @required this.onPressed,
    @required this.tableAndPosition,
  }) : super(key: key);

  @override
  _MenuPositionCard createState() => _MenuPositionCard();
}

class _MenuPositionCard extends State<MenuPositionCard>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  @override
  void initState() {
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
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  int press = 0;
  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTap: widget.onPressed,
      child: Transform.scale(
        scale: _scale,
        child: Stack(
          children: [
            Container(
              height: Palette.stdbutton_height *
                  widget.tableAndPosition.btnXwid *
                  2.8,
              width: Palette.stdbutton_width *
                  widget.tableAndPosition.btnXwid *
                  2.8,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.rectangle,
              ),
              child: Row(
                children: [
                  Container(
                    height: Palette.stdbutton_height *
                        widget.tableAndPosition.btnXwid *
                        1.8,
                    width: Palette.stdbutton_width *
                        widget.tableAndPosition.btnXwid *
                        1.8,
                    decoration: BoxDecoration(
                      color: widget.tableAndPosition.btnColor,
                      shape: BoxShape.circle,
                    ),
                    child: (widget.tableAndPosition.imageUrl == '')
                        ? Container()
                        : Center(
                            child: Container(
                              height: Palette.stdbutton_height *
                                  widget.tableAndPosition.btnXwid *
                                  2 *
                                  0.8,
                              width: Palette.stdbutton_width *
                                  widget.tableAndPosition.btnXwid *
                                  2 *
                                  0.8,
                              child: Center(
                                child: CircleAvatar(
                                  radius: 60.0,
                                  backgroundColor:
                                      widget.tableAndPosition.btnColor,
                                  child: Container(
                                    height: Palette.stdbutton_height *
                                        widget.tableAndPosition.btnXwid *
                                        2 *
                                        0.8,
                                    width: Palette.stdbutton_width *
                                        widget.tableAndPosition.btnXwid *
                                        2 *
                                        0.8,
                                    decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                        image: ExactAssetImage(
                                            widget.tableAndPosition.imageUrl),
                                        fit: BoxFit.fitHeight,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  // Image.asset(
                                  //   widget.tableAndPosition.imageUrl,
                                  //   // width: 200.0,
                                  //   // height: 200.0,
                                  //   fit: BoxFit.contain,
                                  // ),
                                  // backgroundImage: NetworkImage(
                                  //     widget.tableAndPosition.imageUrl),
                                ),
                              ),
                            ),
                          ),
                  ),
                ],
              ),
            ),
            (widget.tableAndPosition.label == '')
                ? Container()
                : Positioned(
                    top: 146.0,
                    left: 0.0,
                    right: 80.0,
                    bottom: 0.0,
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: widget.tableAndPosition.label,
                                style: TextStyle(
                                  fontFamily: 'Leelawadee',
                                  fontWeight: FontWeight.w400,
                                  fontSize: widget.tableAndPosition.btnFSize,
                                  color: Colors.blue,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    press = 1;
    details.localPosition.scale(100, 200);
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    press = 0;
    _controller.reverse();
  }
}
