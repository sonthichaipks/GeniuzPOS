import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:com_csith_geniuzpos/widgets/oldwidgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/models/buttons/buttuns.dart';

typedef void PanelBtnCallback(PosButton pluinput);

class PanelBox extends StatefulWidget {
  final PosButton user;
  final PanelBtnCallback pnlbtnInput;

  const PanelBox({
    Key key,
    @required this.user,
    @required this.pnlbtnInput,
  }) : super(key: key);

  @override
  _PanelBox createState() => new _PanelBox();
}

class _PanelBox extends State<PanelBox> with SingleTickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;

    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTap: () {
        widget.pnlbtnInput(widget.user);
      },
      child: Transform.scale(
          scale: _scale,
          child: Container(
              width: double.infinity,
              height: Palette.stdbutton_height + Palette.stdspacer_widht,
              decoration: new BoxDecoration(
                color: widget.user.btnColor,
                boxShadow: Responsive.isDesktop(context)
                    ? const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 0),
                          blurRadius: 0.0,
                        ),
                      ]
                    : null,
                image: new DecorationImage(
                  image: ExactAssetImage(widget.user.imageUrl),
                  fit: BoxFit.fitHeight,
                ),
                //shape: BoxShape.circle,
              ),
              child: SizedBox(
                  height: Palette.stdbutton_height + Palette.stdspacer_widht,
                  width: Palette.stdbutton_width * (8 / 6) +
                      Palette.stdspacer_widht,
                  child: Center(
                    child: (widget.user.label == '')
                        ? Container()
                        : new Text(
                            widget.user.label,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Micrsoft Sans Serif',
                              fontWeight: FontWeight.normal,
                              fontSize: 20.0,
                              letterSpacing: 0.1,
                            ),
                          ),
                  )))),
    );
  }

  void _tapDown(TapDownDetails details) {
    details.localPosition.scale(100, 200);
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}

Future<void> showMyDialog(BuildContext context, String response) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('AlertDialog Title'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(response),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(response),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text("CLOSE"),
            onPressed: () {
              appWindow.close();
            },
          ),
        ],
      );
    },
  );
}
