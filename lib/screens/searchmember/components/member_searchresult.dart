import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/models/persons/psmember.dart';
import 'package:com_csith_geniuzpos/services/response/person_reponse.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/resources/styles.dart';
import 'member_list.dart';
import 'memberhdc_title.dart';

// ignore: must_be_immutable
class MemberSearchListPages extends StatefulWidget {
  final GetSearchMemberResponse responseMember;
  final TextEditingController txt;
  final PosFncCallResponse responseInput;
  final List<PsMember> psMembers;
  final Function actionDo;

  MemberSearchListPages(
      {Key key,
      this.responseMember,
      this.txt,
      this.responseInput,
      this.actionDo,
      this.psMembers})
      : super(key: key);
  @override
  _MemberSearchListPages createState() => _MemberSearchListPages();
}

class _MemberSearchListPages extends State<MemberSearchListPages>
    implements PosFncCallBack {
  PosFncCallResponse _responseInput;
  TextEditingController activeTxt;
  final PosInput _posinput = new PosInput();

  FocusNode fcn1, fcn2, fcn3, fcn4, fcn5, fcn6, fcn7, fcn8;
  PsMember psMember;
  @override
  void initState() {
    _responseInput = new PosFncCallResponse(this);
    fcn1 = FocusNode();
    fcn2 = FocusNode();
    fcn3 = FocusNode();
    fcn4 = FocusNode();
    fcn5 = FocusNode();
    fcn6 = FocusNode();
    fcn7 = FocusNode();
    fcn8 = FocusNode();
    fcn1.requestFocus();
    super.initState();
  }

  int _radioValue1 = -1;
  int correctScore = 0;

  @override
  void dispose() {
    PosInput().focusnode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // context.watch<PosControlModel>().getItem();
    // return Consumer<PosControlModel>(builder: (context, model, child) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 0, color: Palette.scaffold),
            left: BorderSide(width: 0, color: Palette.scaffold),
            right: BorderSide(width: 0, color: Palette.scaffold),
            bottom: BorderSide(width: 0, color: Colors.white),
          )),
      child: Scaffold(body: registereScreenDesktop(context)),
    );
    // });
  }

  Widget registereScreenDesktop(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 0, color: Palette.scaffold),
            left: BorderSide(width: 0, color: Palette.scaffold),
            right: BorderSide(width: 0, color: Palette.scaffold),
            bottom: BorderSide(width: 0, color: Colors.white),
          )),
      child: Stack(children: [
        Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: memberTitle()),
        Container(child: mbcodeForm()),
        Container(child: mbnameForm()),
        Container(child: mblistForm()),
        Container(child: mblistHDForm()),
        Container(child: mbCommandForm()),
      ]),
    );
  }

  Widget memberTitle() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.white),
                left: BorderSide(width: 1.0, color: Colors.white),
                right: BorderSide(width: 1.0, color: Colors.white),
                bottom: BorderSide(width: 1.0, color: Colors.white),
              )),
          child: Center(
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: '',
                children: <TextSpan>[
                  TextSpan(
                      text: Palette.search_mblist_title,
                      style: TextStyle(
                        fontFamily: 'Tahoma',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black,
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget mbcodeForm() {
    return Stack(
      children: [
        Positioned(
          top: 124,
          left: 60,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 6.6,
                height: Palette.stdbutton_height * 1.2,
                child: Row(
                  children: [
                    Container(
                      width: Palette.stdbutton_width * 6.6,
                      height: Palette.stdbutton_height * 1.2,
                      padding: const EdgeInsets.all(1),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: Palette.search_mblist_Label,
                                style: TextStyle(
                                  fontFamily: 'Tahoma',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
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
          top: 120,
          left: 516,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 0.7,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              focusNode: fcn1,
              controller: _posinput.txtMemberSearch,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn2.requestFocus();
              },
              style: TextStyle(fontSize: 24, fontFamily: 'Tahoma'),
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.stdbutton_theme_2),
                  borderRadius: BorderRadius.circular(0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CsiStyle().primaryColor),
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ),
        ),
        curveButtons(context, _responseInput, stdButtuon0[2], 110, 797,
            Palette.stdbutton_width * 0.8, Palette.stdbutton_height * 1.05),
      ],
    );
  }

  Widget mbnameForm() {
    return Stack(
      children: [
        Positioned(
          top: 45,
          left: 56,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 7,
                height: Palette.stdbutton_height,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    new Radio(
                      value: 0,
                      groupValue: _radioValue1,
                      onChanged: _handleRadioValueChange1,
                    ),
                    new Text(
                      Palette.search_radio1_title,
                      style: new TextStyle(
                        fontFamily: 'Tahoma',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    new Radio(
                      value: 1,
                      groupValue: _radioValue1,
                      onChanged: _handleRadioValueChange1,
                    ),
                    new Text(
                      Palette.search_radio2_title,
                      style: new TextStyle(
                        fontFamily: 'Tahoma',
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget mblistHDForm() {
    return Stack(
      children: [
        Positioned(
          top: 202,
          left: 90,
          child: memberhdcTitle(),
        ),
      ],
    );
  }

  Widget mblistForm() {
    return Stack(
      children: [
        Positioned(
          top: 226,
          left: 90,
          child: MemberSearchList(
              txt: _posinput.txtMemberSearch,
              responseMember: widget.responseMember,
              resultSearchList: widget.psMembers),
        ),
      ],
    );
  }

  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;

      switch (_radioValue1) {
        case 0:
          _posinput.txtMemberSearch.text = '1';
          break;
        case 1:
          _posinput.txtMemberSearch.text = '2';
          break;
      }
    });
  }

  Widget mbCommandForm() {
    return Stack(
      children: [
        curveButtons(context, _responseInput, stdButtuon0[4], 524, 240,
            Palette.stdbutton_width * 1.3, Palette.stdbutton_height * 1.3),
        curveButtons(context, _responseInput, stdButtuon0[3], 524, 600,
            Palette.stdbutton_width * 1.3, Palette.stdbutton_height * 1.3),
      ],
    );
  }

  @override
  void onCallPosFncError(String error) {}

  @override
  void onCallPosFncSuccess(String result) {
    setState(() {
      txtinputEntry(result);
    });
  }

  void txtinputEntry(String result) {
    if (result != "") {
      if (result == "OK") {
        Navigator.pop(context);
      } else if (result == "SEARCH") {
        normalDialog(context, result);
      } else if (result == "CANCEL") {
        //--must clear form data--before close!
        widget.actionDo();
        Navigator.pop(context);
      }
      //---member search by result (MemberID )then display data in forms here!
    }
  }
}
