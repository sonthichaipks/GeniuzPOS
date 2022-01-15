import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/models/persons/salman.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/screens/posacm/components/posacm_list.dart';
import 'package:com_csith_geniuzpos/screens/posacm/components/posacm_title.dart';
import 'package:com_csith_geniuzpos/services/response/poscontrol_response.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';

// ignore: must_be_immutable
class PosAcmSearchPages extends StatefulWidget {
  final GetPosCtrlResponse responsePosCtrl;
  final TextEditingController txt;
  final PosFncCallResponse responseInput;
  final Function actionDo;
  final List<PosCtrl> posAcmLists;
  // final List<PosControl> posAcmLists;
  PosAcmSearchPages(
      {Key key,
      this.responsePosCtrl,
      this.txt,
      this.responseInput,
      this.actionDo,
      this.posAcmLists})
      : super(key: key);
  @override
  _PosAcmSearchPages createState() => _PosAcmSearchPages();
}

class _PosAcmSearchPages extends State<PosAcmSearchPages>
    implements PosFncCallBack {
  PosFncCallResponse _responseInput;
  TextEditingController activeTxt;
  final PosInput _posinput = new PosInput();

  FocusNode fcn1, fcn2, fcn3, fcn4, fcn5, fcn6, fcn7, fcn8;
  Salesman psMember;
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
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: psctrlTitle()),
        Container(child: pslistForm()),
        Container(child: pslistHDForm()),
        Container(child: psCommandForm()),
      ]),
    );
  }

  Widget psctrlTitle() {
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
                      text: Palette.searchacm_title,
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

  Widget pslistHDForm() {
    return Stack(
      children: [
        Positioned(
          top: 50,
          left: 10,
          child: posAcmTitle(),
        ),
      ],
    );
  }

  Widget pslistForm() {
    return Stack(
      children: [
        Positioned(
          top: 70,
          left: 10,
          child: PosAcmSearchList(
            txt: _posinput.txtMemberSearch,
            responsePosCtrl: widget.responsePosCtrl,
            posAcmLists: widget.posAcmLists,
            actdo: updateConfig,
          ),
        ),
      ],
    );
  }

  Widget psCommandForm() {
    return Stack(
      children: [
        curveButtons(context, _responseInput, stdButtuon0[4], 580, 100,
            Palette.stdbutton_width * 1.3, Palette.stdbutton_height * 1),
        curveButtons(context, _responseInput, stdButtuon0[3], 580, 380,
            Palette.stdbutton_width * 1.3, Palette.stdbutton_height * 1),
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
        setState(() {});
      } else if (result == "SEARCH") {
        Navigator.pop(context);
      } else if (result == "CANCEL") {
        //--must clear form data--before close!
        Navigator.pop(context);
      }
      //---member search by result (MemberID )then display data in forms here!
    }
  }

  void updateConfig(int index, String values) {
    try {
      // PosControlFnc().updateSetPanel(context, index - 56, values);
      // if (index == 0) {
      //   model.updateItem(
      //       index + 56,
      //       getPocControlFmPosCtrl(_PosCtrlupdate(
      //           values, posCtrlList[index + 56])));
      // } else if (index == 1) {
      // } else if (index == 2) {
      // } else if (index == 3) {}
    } catch (e) {
      showToast(context, e.toString());
    }
  }
}
