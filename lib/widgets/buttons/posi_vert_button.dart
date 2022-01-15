import 'package:com_csith_geniuzpos/widgets/oldwidgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/models/buttons/buttuns.dart';

class VeriticalPosButtons extends StatelessWidget {
  final List<PosButton> posbtns;
  final Function onPressed;
  final startpositiontop;
  final startpositionleft;

  const VeriticalPosButtons(
      {Key key,
      @required this.posbtns,
      this.onPressed,
      this.startpositiontop,
      this.startpositionleft})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Palette.stdbutton_height,
      width: Palette.stdbutton_width,
      // color: Responsive.isDesktop(context) ? Colors.transparent : Colors.white,
      color: Colors.white,
      child: ListView.builder(
        // padding: const EdgeInsets.symmetric(
        //   vertical: 10.0,
        //   horizontal: 8.0,
        // ),
        scrollDirection: Axis.vertical,
        itemCount: 1 + posbtns.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Positioned(
              top: startpositiontop,
              left: startpositionleft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    Palette.stdspacer_widht, 0.0, 0, 0),
                child: _ButtonCard(
                  isAddStory: true,
                  posbtn: posbtns[0],
                  onPressed: () {
                    // FncItems().poscenter(context, posbtns[0]);
                    //_showMyDialog(context, posbtns[0]);
                  },
                ),
              ),
            );
          } else {
            final PosButton posbtn = posbtns[index - 1];
            if (index == 1) {
              return Container();
            } else {
              return Positioned(
                top: startpositiontop + index * Palette.stdbutton_width,
                // left: startpositionleft + index * Palette.stdbutton_width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0, 0),
                  child: _ButtonCard(
                    isAddStory: true,
                    posbtn: posbtn,
                    onPressed: () {
                      //    FncItems().poscenter(context, posbtn);
                      //_showMyDialog(context, posbtn);
                    },
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

class _ButtonCard extends StatelessWidget {
  final bool isAddStory;
  final PosButton posbtn;
  final Function onPressed;

  const _ButtonCard({
    Key key,
    this.isAddStory = false,
    this.posbtn,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onLongPress: onPressed,
        onTap: onPressed,
        child: Container(
          child: Stack(
            children: [
              Container(
                height: Palette.stdbutton_height,
                width: (posbtn.btnXwid == 2)
                    ? Palette.stdbutton_width * posbtn.btnXwid +
                        Palette.stdspacer_widht
                    : Palette.stdbutton_width * posbtn.btnXwid,
                decoration: BoxDecoration(
                  color: posbtn.btnColor,
                  //gradient: Palette.setThemesButton(posbtn.btnColor),
                  // borderRadius: BorderRadius.circular(1.0),
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
              (posbtn.label == '')
                  ? Container()
                  : Positioned(
                      top: 1.0,
                      left: 1.0,
                      right: 1.0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                            Palette.stdspacer_widht,
                            Palette.stdspacer_widht,
                            0.0,
                            0.0),
                        child: Center(
                          child: (posbtn.btnFSize > 19)
                              ? RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: (posbtn.label == 'จำนวน\r\n*' ||
                                            posbtn.label == 'แถม\r\nFREE')
                                        ? ''
                                        : '\r\n',
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: posbtn.label,
                                          style: TextStyle(
                                            fontFamily: 'Leelawadee',
                                            fontWeight: (posbtn.label == '.')
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                            fontSize: posbtn.btnFSize,
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
                                          text: posbtn.label,
                                          style: TextStyle(
                                            fontFamily: 'Leelawadee',
                                            fontWeight: FontWeight.w400,
                                            fontSize: posbtn.btnFSize,
                                            color: Colors.black,
                                          )),
                                      (posbtn.btnFSize > 19)
                                          ? TextSpan(
                                              text: '',
                                            )
                                          : TextSpan(
                                              text: '\r\n\r\n',
                                              style: TextStyle(
                                                fontFamily: 'Leelawadee',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 5,
                                                color: Colors.black,
                                              )),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
              (posbtn.label == '')
                  ? Container()
                  : Positioned(
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
                                (posbtn.btnFSize > 19)
                                    ? TextSpan(
                                        text: '',
                                      )
                                    : TextSpan(
                                        text: posbtn.kybCode,
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
              (posbtn.imageUrl == '')
                  ? Container()
                  : Container(
                      height: Palette.stdbutton_height,
                      width: Palette.stdbutton_width * posbtn.btnXwid,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(posbtn.imageUrl),
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }
}
