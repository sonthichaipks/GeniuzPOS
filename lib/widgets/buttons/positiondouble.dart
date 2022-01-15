import 'package:com_csith_geniuzpos/widgets/oldwidgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/models/buttons/padbuttons.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';

Widget positionDouble(
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
      height: Palette.stdbutton_height * 1.5 + Palette.stdspacer_widht,
      width: (posbtns[dataid].btnXwid == 2)
          ? Palette.stdbutton_width * posbtns[dataid].btnXwid +
              Palette.stdspacer_widht * posbtns[dataid].btnXwid
          : Palette.stdbutton_width * posbtns[dataid].btnXwid +
              Palette.stdspacer_widht,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Palette.stdspacer_widht, 0.0, 0, 0),
        child: PosiDblButtonCard(
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

class PosiDblButtonCard extends StatefulWidget {
  final PadButton posbtn;
  final Function onPressed;

  const PosiDblButtonCard({
    Key key,
    @required this.posbtn,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _PosiDblButtonCard createState() => new _PosiDblButtonCard();
}

class _PosiDblButtonCard extends State<PosiDblButtonCard>
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
            height: Palette.stdbutton_height * 2,
            child: Stack(
              children: [
                Container(
                  height: Palette.stdbutton_height * 2,
                  width: (widget.posbtn.btnXwid == 2)
                      ? Palette.stdbutton_width * widget.posbtn.btnXwid
                      : Palette.stdbutton_width * widget.posbtn.btnXwid +
                          Palette.stdspacer_widht,
                  decoration: BoxDecoration(
                    color: widget.posbtn.btnColor,
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
                ),
                (widget.posbtn.label == '')
                    ? Container()
                    : Positioned(
                        top: 35.0,
                        left: 1.0,
                        right: 10.0,
                        bottom: 0.0,
                        child: Text(widget.posbtn.label,
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                              fontFamily: 'Leelawadee',
                              fontWeight: FontWeight.bold,
                              fontSize: widget.posbtn.btnFSize,
                              letterSpacing: 0.1,
                            )),
                      ),
                (widget.posbtn.imageUrl == '')
                    ? Container()
                    : Positioned(
                        top: (widget.posbtn.kybTBLR == 1) ||
                                (widget.posbtn.kybTBLR == 3) ||
                                (widget.posbtn.kybTBLR == 0)
                            ? 8.0
                            : 4.0,
                        left: (widget.posbtn.kybTBLR == 1) ||
                                (widget.posbtn.kybTBLR == 3) ||
                                (widget.posbtn.kybTBLR == 0)
                            ? 2.0
                            : 10.0,
                        right: (widget.posbtn.kybTBLR == 1) ||
                                (widget.posbtn.kybTBLR == 3) ||
                                (widget.posbtn.kybTBLR == 0)
                            ? 4.0
                            : 10.0,
                        child: Container(
                          height: (widget.posbtn.kybTBLR == 1) ||
                                  (widget.posbtn.kybTBLR == 3) ||
                                  (widget.posbtn.kybTBLR == 0)
                              ? Palette.stdbutton_height * 1.3
                              : Palette.stdbutton_height * 1.2,
                          width: (widget.posbtn.kybTBLR == 1) ||
                                  (widget.posbtn.kybTBLR == 3) ||
                                  (widget.posbtn.kybTBLR == 0)
                              ? Palette.stdbutton_width *
                                  widget.posbtn.btnXwid *
                                  1.2
                              : Palette.stdbutton_width *
                                  widget.posbtn.btnXwid *
                                  1.2,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.bottomLeft,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: ExactAssetImage(widget.posbtn.imageUrl),
                              fit: BoxFit.fitHeight,
                            ),
                            //shape: BoxShape.circle,
                          ),
                          // decoration: BoxDecoration(
                          //   image: DecorationImage(
                          //     fit: BoxFit.contain,
                          //     image: NetworkImage(widget.posbtn.imageUrl),
                          //   ),
                          // ),
                        ),
                      ),
              ],
            ),
          ),
        ));
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
