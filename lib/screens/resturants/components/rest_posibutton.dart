import 'package:com_csith_geniuzpos/widgets/oldwidgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/models/buttons/padbuttons.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';

Widget restpositionButtons(
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
      height: Palette.stdbutton_height + Palette.stdspacer_widht,
      width: (posbtns[dataid].btnXwid == 2)
          ? Palette.stdbutton_width * posbtns[dataid].btnXwid +
              Palette.stdspacer_widht * posbtns[dataid].btnXwid
          : Palette.stdbutton_width * posbtns[dataid].btnXwid +
              Palette.stdspacer_widht,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(Palette.stdspacer_widht, 0.0, 0, 0),
        child: RestButtonCard(
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

class RestButtonCard extends StatefulWidget {
  final PadButton posbtn;
  final Function onPressed;

  const RestButtonCard({
    Key key,
    @required this.posbtn,
    @required this.onPressed,
  }) : super(key: key);

  @override
  _RestButtonCard createState() => new _RestButtonCard();
}

class _RestButtonCard extends State<RestButtonCard>
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
            child: Stack(
              children: [
                Container(
                  height: (widget.posbtn.kybTBLR < 0)
                      ? Palette.stdbutton_height * 2
                      : Palette.stdbutton_height,
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
                        top: 1.0,
                        left: 0.0,
                        right: 8.0,
                        bottom: 10.0,
                        child: Center(
                          child: (widget.posbtn.btnFSize > 19)
                              ? RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text:
                                        (widget.posbtn.label == 'จำนวน\r\n*' ||
                                                widget.posbtn.label ==
                                                    'แถม\r\nFREE')
                                            ? ''
                                            : '\r\n',
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: widget.posbtn.label,
                                          style: TextStyle(
                                            fontFamily: 'Leelawadee',
                                            fontWeight:
                                                (widget.posbtn.label == '.')
                                                    ? FontWeight.bold
                                                    : FontWeight.w500,
                                            fontSize: widget.posbtn.btnFSize,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                )
                              : RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: '',
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: widget.posbtn.label,
                                          style: TextStyle(
                                            fontFamily: 'Leelawadee',
                                            fontWeight: FontWeight.w400,
                                            fontSize: widget.posbtn.btnFSize,
                                            color: Colors.black,
                                          )),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                (widget.posbtn.kybTBLR == 0)
                    ? Container()
                    : (widget.posbtn.kybTBLR == 1)
                        ? Positioned(
                            top: (widget.posbtn.kybCode.indexOf('\r\n') > 0)
                                ? 35.0
                                : 45.0,
                            left: 2.0,
                            // right: 8.0,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  Palette.stdspacer_widht,
                                  Palette.stdspacer_widht,
                                  0.0,
                                  0.0),
                              child: Center(
                                child: RichText(
                                  textAlign: TextAlign.left,
                                  text: TextSpan(
                                    text: '',
                                    children: <TextSpan>[
                                      (widget.posbtn.btnFSize > 19)
                                          ? TextSpan(
                                              text: '',
                                            )
                                          : TextSpan(
                                              text:
                                                  (widget.posbtn.kybCode == '')
                                                      ? ''
                                                      : widget.posbtn.kybCode,
                                              style: TextStyle(
                                                fontFamily: 'Leelawadee',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 11,
                                                color: Colors.black,
                                              )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : (widget.posbtn.kybTBLR == 2)
                            ? Positioned(
                                top: 45.0,
                                left: 1.0,
                                right: 1.0,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      Palette.stdspacer_widht,
                                      Palette.stdspacer_widht,
                                      0.0,
                                      0.0),
                                  child: Center(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: '',
                                        children: <TextSpan>[
                                          (widget.posbtn.btnFSize > 19)
                                              ? TextSpan(
                                                  text: '',
                                                )
                                              : TextSpan(
                                                  text: (widget
                                                              .posbtn.kybCode ==
                                                          '')
                                                      ? ''
                                                      : '', // widget.posbtn.kybCode,
                                                  style: TextStyle(
                                                    fontFamily: 'Leelawadee',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11,
                                                    color: Colors.black,
                                                  )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Positioned(
                                top: 45.0,
                                // left: 1.0,
                                right: 12.0,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      Palette.stdspacer_widht,
                                      Palette.stdspacer_widht,
                                      0.0,
                                      0.0),
                                  child: Center(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: '',
                                        children: <TextSpan>[
                                          (widget.posbtn.btnFSize > 19)
                                              ? TextSpan(
                                                  text: '',
                                                )
                                              : TextSpan(
                                                  text: (widget
                                                              .posbtn.kybCode ==
                                                          '')
                                                      ? ''
                                                      : widget.posbtn.kybCode,
                                                  style: TextStyle(
                                                    fontFamily: 'Leelawadee',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 11,
                                                    color: Colors.black,
                                                  )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                (widget.posbtn.imageUrl == '')
                    ? Container()
                    : Positioned(
                        top: (widget.posbtn.kybTBLR == 1) ||
                                (widget.posbtn.kybTBLR == 3) ||
                                (widget.posbtn.kybTBLR == 0)
                            ? 6.0
                            : 6.0,
                        left: (widget.posbtn.kybTBLR == 1) ||
                                (widget.posbtn.kybTBLR == 3) ||
                                (widget.posbtn.kybTBLR == 0)
                            ? 10.0
                            : 10.0,
                        right: (widget.posbtn.kybTBLR == 1) ||
                                (widget.posbtn.kybTBLR == 3) ||
                                (widget.posbtn.kybTBLR == 0)
                            ? 10.0
                            : 10.0,
                        bottom: 10.0,
                        child: Container(
                          height: (widget.posbtn.kybTBLR == 1) ||
                                  (widget.posbtn.kybTBLR == 3) ||
                                  (widget.posbtn.kybTBLR == 0)
                              ? Palette.stdbutton_height * 0.9
                              : Palette.stdbutton_height * 0.7,
                          width: (widget.posbtn.kybTBLR == 1) ||
                                  (widget.posbtn.kybTBLR == 3) ||
                                  (widget.posbtn.kybTBLR == 0)
                              ? Palette.stdbutton_width *
                                  widget.posbtn.btnXwid *
                                  0.5
                              : Palette.stdbutton_width *
                                  widget.posbtn.btnXwid *
                                  0.5,
                          padding: EdgeInsets.all(10),
                          alignment: Alignment.bottomLeft,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: ExactAssetImage(widget.posbtn.imageUrl),
                              fit: BoxFit.fitHeight,
                            ),
                            //shape: BoxShape.circle,
                          ),
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
