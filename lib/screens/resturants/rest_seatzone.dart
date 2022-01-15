import 'package:com_csith_geniuzpos/models/persons/psmember.dart';
import 'package:com_csith_geniuzpos/screens/resturants/components/restcomponent.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_components.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/models/buttons/buttuns.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/resources/styles.dart';

class ResturantSeatPages extends StatefulWidget {
  @override
  _ResturantSeatPages createState() => _ResturantSeatPages();
}

class _ResturantSeatPages extends State<ResturantSeatPages>
    implements PosFncCallBack {
  PosFncCallResponse _responseInput;

  PosButton posGroup;
  PsMember csMember;

  final PosInput _posinput = new PosInput();

  _ResturantSeatPages() {
    _responseInput = new PosFncCallResponse(this);
    _posinput.focusnode = FocusNode();
    posGroup = PosInput().restuantGrpPanel;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    PosInput().focusnode.dispose();
    super.dispose();
  }

  @override
  void onCallPosFncError(String error) {
    // setState(() {
    //   PosInput().focusnode.requestFocus();
    // });
  }

  @override
  void onCallPosFncSuccess(String result) {
    setState(() {
      txtinputEntry(result);

      _posinput.focusnode.requestFocus();
    });
  }

  void txtinputEntry(String result) {
    if (result != "") {
      var enchar = result.substring(result.length - 1, 1);

      if (enchar == '\n') {
        debugPrint(enchar);
        _posinput.txtPlu.text = "";
      } else {
        setState(() {
          _posinput.txtPlu.text = result;
        });
        debugPrint(_posinput.txtPlu.text);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.white),
            left: BorderSide(width: 1.0, color: Colors.white),
            right: BorderSide(width: 1.0, color: Colors.white),
            bottom: BorderSide(width: 1.0, color: Colors.white),
          )),
      child: Scaffold(body: seatScreenDesktop(context, _responseInput)),
    );
  }

  Widget seatScreenDesktop(
      BuildContext context, PosFncCallResponse responseInput) {
    return Stack(children: [
      frameBUtton(context),
      restseatsh(context),
      frmae10botline(context, responseInput),
      Container(child: RestSeatTableInZone(responseInput: responseInput)),
      Container(child: pluForm())
    ]);
  }

  Widget pluForm() {
    return Stack(
      children: [
        Positioned(
          top: 60,
          left: 860,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 2,
                height: Palette.stdbutton_height,
                child: Row(
                  children: [
                    Container(
                      width: Palette.stdbutton_width * 1.5,
                      height: Palette.stdbutton_height,
                      padding: const EdgeInsets.all(1),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: 'โต๊ะ#',
                                style: TextStyle(
                                  fontFamily: 'Leelawadee',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 950,
          child: Container(
            width: 67,
            height: Palette.onelineheigth() * 0.7,
            padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              controller: _posinput.txtPlu,
              onChanged: (text) {
                _posinput.txtPlu.text = text;
              },
              onSubmitted: (result) {
                txtinputEntry('\n');
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Entry: Table No.',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: CsiStyle().primaryColor)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
