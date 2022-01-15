import 'package:com_csith_geniuzpos/widgets/oldwidgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/models/buttons/padbuttons.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';

Widget positionCurveButtons(
    BuildContext context,
    PosFncCallResponse _responseInput,
    List<PadButton> posbtns,
    double startpositiontop,
    double startpositionleft,
    int dataid) {
  return Positioned(
    top: startpositiontop,
    left: startpositionleft,
    child: Container(
      height: Palette.stdbutton_height * 0.8,
      width: Palette.stdbutton_width * 1.8,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Palette.stdspacer_widht, 0.0, 0, 0),
        child: PosiButtonCard(
          posbtn: posbtns[dataid],
          onPressed: () {
            FncItems().padcenter(
                context, _responseInput, posbtns[dataid], FncItems().dummy);
          },
        ),
      ),
    ),
  );
}

class PosiButtonCard extends StatefulWidget {
  final PadButton posbtn;
  final Function onPressed;

  const PosiButtonCard({
    Key key,
    @required this.posbtn,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _PosiButtonCard createState() => new _PosiButtonCard();
}

class _PosiButtonCard extends State<PosiButtonCard>
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
        child: Container(
          height: Palette.stdbutton_height * 0.4,
          width: Palette.stdbutton_width * widget.posbtn.btnXwid,
          decoration: BoxDecoration(
            color: widget.posbtn.btnColor,
            borderRadius: new BorderRadius.all(Radius.circular(10.0)),
            boxShadow: Responsive.isDesktop(context)
                ? const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 0),
                      blurRadius: 0.0,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: '',
                children: <TextSpan>[
                  TextSpan(
                      text: widget.posbtn.label,
                      style: TextStyle(
                        fontFamily: 'Tahoma',
                        fontWeight: FontWeight.w500,
                        fontSize: widget.posbtn.btnFSize,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
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
