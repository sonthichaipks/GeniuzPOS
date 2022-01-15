import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/models/buttons/buttuns.dart';

import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';

Widget actdoButtons(BuildContext context, Function actdo, PosButton posbtns,
    double startpositiontop, double startpositionleft, double bw, double bh) {
  return Positioned(
    top: startpositiontop,
    left: startpositionleft,
    child: Container(
      height: bh,
      width: bw,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Palette.stdspacer_widht, 0.0, 0, 0),
        child: CurveButtonsCard(
          posbtn: posbtns,
          onPressed: () {
            (actdo != null) ? actdo() : closeMe(context);
          },
        ),
      ),
    ),
  );
}

void closeMe(BuildContext context) {
  Navigator.of(context).pop();
}

class CurveButtonsCard extends StatefulWidget {
  final PosButton posbtn;
  final Function onPressed;
  final double bw;
  final double bh;
  const CurveButtonsCard({
    Key key,
    @required this.posbtn,
    @required this.onPressed,
    this.bw,
    this.bh,
  }) : super(key: key);

  @override
  _CurveButtonsCard createState() => new _CurveButtonsCard();
}

class _CurveButtonsCard extends State<CurveButtonsCard>
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
        child: Container(
          width: widget.bw,
          height: widget.bh,
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Palette.scaffold,
          ),
          child: ClipOval(
              child: Container(
            width: 60,
            height: 60,
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: ExactAssetImage(widget.posbtn.imageUrl),
                fit: BoxFit.fitHeight,
              ),
              shape: BoxShape.circle,
            ),
          )
              //     child: Image.network(
              //   widget.posbtn.imageUrl,
              //   fit: BoxFit.fitHeight,
              //   // width: 120.0,
              //   // height: 120.0,
              // )
              ),
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
