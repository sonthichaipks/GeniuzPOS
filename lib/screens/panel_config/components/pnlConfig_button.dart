import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/pospanelctrl.dart';
import 'package:com_csith_geniuzpos/widgets/oldwidgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/models/buttons/buttuns.dart';

typedef void PanelBtnCallback(PosButton pluinput);

class PanelButton extends StatefulWidget {
  final PosButtonX user;
  final PanelBtnCallback pnlbtnInput;
  final Function actdo;
  final String btntype;

  const PanelButton({
    Key key,
    @required this.user,
    @required this.pnlbtnInput,
    @required this.actdo,
    @required this.btntype,
  }) : super(key: key);

  @override
  _PanelButton createState() => new _PanelButton();
}

class _PanelButton extends State<PanelButton>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;
  String imgUrl;
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

    //String dataHost = PosPanelCtrl().getPnlUploadUrl(context);
    String data_imgUrl = PosPanelCtrl().getImgUrl(widget.user.imageUrl);
    // setImageByUrl(data_imgUrl);
    imgUrl = data_imgUrl;
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      onTap: () {
        widget.actdo(widget.user, widget.btntype);
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
                  image: (imgUrl != '')
                      ? NetworkImage(imgUrl)
                      : ExactAssetImage('assets/imgs/blankBtn.jpg'),
                  fit: BoxFit.fill,
                ),
                //shape: BoxShape.circle,
              ),
              child: SizedBox(
                  height: Palette.stdbutton_height + Palette.stdspacer_widht,
                  width: Palette.stdbutton_width * (8 / 6) +
                      Palette.stdspacer_widht,
                  child: Center(
                    child: Text(
                      widget.user.label ?? '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: widget.user.txtColor, //Colors.black,
                        fontFamily: 'Micrsoft Sans Serif',
                        fontWeight: FontWeight.normal,
                        fontSize: widget.user.btnFSize, // 20.0,
                        letterSpacing: 0.1,
                      ),
                    ),
                  )))),
    );
  }

  void setImageByUrl(String _imgUrl) async {
    imgUrl = await PosControlFnc().getCurrentIP(_imgUrl);
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
