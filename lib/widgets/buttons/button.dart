import 'package:com_csith_geniuzpos/widgets/oldwidgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/models/buttons/buttuns.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';

class PosButtons extends StatelessWidget {
  final List<PosButton> posbtns;
  final Function onPressed;
  final PosFncCallResponse responseInput;

  const PosButtons(
      {Key key, @required this.posbtns, this.onPressed, this.responseInput})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Palette.stdbutton_height,
      width: Palette.stdbutton_width,
      color: Responsive.isDesktop(context) ? Colors.transparent : Colors.white,
      child: ListView.builder(
        // padding: const EdgeInsets.symmetric(
        //   vertical: 10.0,
        //   horizontal: 8.0,
        // ),
        scrollDirection: Axis.horizontal,
        itemCount: 1 + posbtns.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Padding(
              padding:
                  const EdgeInsets.fromLTRB(Palette.stdspacer_widht, 0.0, 0, 0),
              child: _ButtonCard(
                isAddStory: true,
                posbtn: posbtns[0],
                onPressed: () {
                  FncItems().poscenter(context, responseInput, posbtns[0]);
                },
              ),
            );
          } else {
            final PosButton posbtn = posbtns[index - 1];
            if (index == 1) {
              return Container();
            } else {
              return Padding(
                padding: const EdgeInsets.fromLTRB(
                    Palette.stdspacer_widht, 0.0, 0, 0),
                child: _ButtonCard(
                  isAddStory: true,
                  posbtn: posbtn,
                  onPressed: () {
                    FncItems().poscenter(context, responseInput, posbtn);
                  },
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
                        padding: (posbtn.label == '.')
                            ? const EdgeInsets.fromLTRB(Palette.stdspacer_widht,
                                Palette.stdspacer_widht, 0.0, 10)
                            : const EdgeInsets.fromLTRB(Palette.stdspacer_widht,
                                Palette.stdspacer_widht, 0.0, 0.0),
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
