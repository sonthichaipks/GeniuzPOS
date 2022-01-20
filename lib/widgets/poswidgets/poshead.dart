import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:com_csith_geniuzpos/screens/posacm/components/posacm_searchresult.dart';
import 'package:com_csith_geniuzpos/screens/posacm/posacm_pages.dart';
import 'package:com_csith_geniuzpos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/models/posctrls/posheaditem.dart';

class PosHead extends StatelessWidget {
  // final List<PosHeadItem> posheaditems;
  final PosHeadItem posheaditems;
  final Function onPressed;

  const PosHead({Key key, @required this.posheaditems, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PosHeadItem posheaditem = posheaditems;
    return Container(
      height: 30,
      width: double.infinity,
      color: Responsive.isDesktop(context) ? Colors.transparent : Colors.white,
      child: _PosHeadCard(
        posHeadItem: posheaditem,
        onPressed: () {},
      ),
    );
  }
}

Future<void> _showMyDialog(
    BuildContext context, PosHeadItem posheaditem) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        insetAnimationDuration: const Duration(milliseconds: 100),
        child: Stack(
          children: [
            Container(
              // use container to change width and height
              // height: Palette.stdbutton_height * 8,
              // width: Palette.stdbutton_width * 10.5,
              //child: PosAcmPages(),
              height: Palette.stdbutton_height * 9.8,
              width: Palette.stdbutton_width * 7.3,
              child: PosAcmSearchPages(
                responsePosCtrl: null,
                txt: null,
                actionDo: null,
                posAcmLists: null,
              ),
            ),
          ],
        ),
      );
    },
  );
}

Future<void> _showActivePIPDialog(
    BuildContext context, PosHeadItem posheaditem) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        insetAnimationDuration: const Duration(milliseconds: 100),
        child: Stack(
          children: [
            Container(
              height: Palette.stdbutton_height * 9.8,
              width: Palette.stdbutton_width * 7.3,
              child: PosAcmSearchPages(
                responsePosCtrl: null,
                txt: null,
                actionDo: null,
                posAcmLists: null,
              ),
            ),
          ],
        ),
      );
    },
  );
}

BoxDecoration myBoxDecoration() {
  return BoxDecoration(
    border: Border(
      top: BorderSide(width: 1.0, color: Colors.white),
      left: BorderSide(width: 1.0, color: Colors.grey),
      right: BorderSide(width: 1.0, color: Colors.grey),
      bottom: BorderSide(width: 1.0, color: Colors.grey),
    ),
  );
}

class _PosHeadCard extends StatelessWidget {
  final PosHeadItem posHeadItem;
  final Function onPressed;

  const _PosHeadCard({
    Key key,
    this.posHeadItem,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        // onTap: () {
        //   _showMyDialog(context, posHeadItem);
        // },
        behavior: HitTestBehavior.translucent,
        onPanStart: (details) {
          appWindow.startDragging();
        },
        // onDoubleTap: () => _showActivePIPDialog(context, posHeadItem),
        // onTap: onPressed,
        child: Container(
          decoration: myBoxDecoration(),
          padding: const EdgeInsets.fromLTRB(
              0.0, Palette.stdspacer_widht, 0.0, Palette.stdspacer_widht),
          child: Stack(
            children: [
              RichText(
                text: TextSpan(
                  text: '',
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                        text: posHeadItem.label,
                        style: TextStyle(
                          fontFamily: 'Leelawadee',
                          fontWeight: FontWeight.w200,
                          fontSize: 11,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

final buttonColors = WindowButtonColors(
    iconNormal: Color(0xFF805306),
    mouseOver: Color(0xFFF6A00C),
    mouseDown: Color(0xFF805306),
    iconMouseOver: Color(0xFF805306),
    iconMouseDown: Color(0xFFFFD500));

final closeButtonColors = WindowButtonColors(
    mouseOver: Color(0xFFD32F2F),
    mouseDown: Color(0xFFB71C1C),
    iconNormal: Color(0xFF805306),
    iconMouseOver: Colors.white);

class WindowButtons extends StatelessWidget {
  final String infomsge;
  const WindowButtons({
    Key key,
    @required this.infomsge,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MoveWindow(),
      ],
    );
  }
}
