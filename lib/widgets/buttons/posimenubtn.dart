import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/models/buttons/padbuttons.dart';
import 'package:com_csith_geniuzpos/models/buttons/tablemaster.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';

Widget menuSetPosiButtons(
  BuildContext context,
  PosFncCallResponse _responseInput,
  PadButton posbtns,
  TableAndPostions tableAndPosition,
  double posiX,
  double posiY,
  int leftorright,
) {
  if (leftorright == 1) {
    return Positioned(
      // top: 0,
      // left: 0,
      right: posiX,
      bottom: posiY,
      child: MenuSetPosiCard(
        posbtn: posbtns,
        onPressed: () {
          FncItems().menucenter(context, _responseInput, tableAndPosition);
        },
        tableAndPosition: tableAndPosition,
      ),
    );
  } else {
    return Positioned(
      // top: 0,
      // right: 0,
      left: posiX,
      bottom: posiY,
      child: MenuSetPosiCard(
        posbtn: posbtns,
        onPressed: () {
          FncItems().menucenter(context, _responseInput, tableAndPosition);
        },
        tableAndPosition: tableAndPosition,
      ),
    );
  }
}

class MenuSetPosiCard extends StatefulWidget {
  final PadButton posbtn;
  final Function onPressed;
  final TableAndPostions tableAndPosition;

  const MenuSetPosiCard({
    Key key,
    @required this.posbtn,
    @required this.onPressed,
    @required this.tableAndPosition,
  }) : super(key: key);

  @override
  _MenuSetPosiCard createState() => _MenuSetPosiCard();
}

class _MenuSetPosiCard extends State<MenuSetPosiCard>
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
      onLongPress: widget.onPressed,
      onTap: widget.onPressed,
      child: Transform.scale(
        scale: _scale,
        child: Stack(
          children: [
            Center(
                child: ClipOval(
                    child: Container(
              width: 60,
              height: 60,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: ExactAssetImage(widget.tableAndPosition.imageUrl),
                  fit: BoxFit.fitHeight,
                ),
                shape: BoxShape.circle,
              ),
            ))),
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
