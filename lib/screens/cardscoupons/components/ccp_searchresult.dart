import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/models/persons/salman.dart';
import 'package:com_csith_geniuzpos/models/posmodels/paymentInfo.dart';
import 'package:com_csith_geniuzpos/screens/cardscoupons/components/ccp_list.dart';
import 'package:com_csith_geniuzpos/screens/searchsalman/components/salman_title.dart';
import 'package:com_csith_geniuzpos/services/response/ccp_response.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/resources/styles.dart';

// ignore: must_be_immutable
class CCPSearchListPages extends StatefulWidget {
  final GetSearchCCPResponse responseCCP;
  final PosFncCallResponse responseInput;
  final Function actionDo;
  final String ccType;

  CCPSearchListPages(
      {Key key,
      this.responseCCP,
      this.responseInput,
      this.actionDo,
      this.ccType})
      : super(key: key);
  @override
  _CCPSearchListPages createState() => _CCPSearchListPages();
}

class _CCPSearchListPages extends State<CCPSearchListPages>
    implements PosFncCallBack, GetPaymentInfoCallBack {
  PosFncCallResponse _responseInput;
  TextEditingController activeTxt;
  final PosInput _posinput = new PosInput();

  FocusNode fcn1;
  Salesman psMember;
  List<PaymentInfo> paymentinfo;
  GetPaymentInfoResponse _responsePaymentInfo;
  _CCPSearchListPages() {
    _responsePaymentInfo = new GetPaymentInfoResponse(this);
  }

  @override
  void initState() {
    _responseInput = new PosFncCallResponse(this);
    fcn1 = FocusNode();

    fcn1.requestFocus();
    String url = PosControlFnc().getPLUurl(context);
    _responsePaymentInfo.getResultPaymentInfo(
        widget.ccType, url.replaceAll('getsaleitem', 'PaymentInfo'));
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
        Container(padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: ccpTitle()),
        Container(child: ccplistForm()),
        Container(child: smCommandForm()),
      ]),
    );
  }

  Widget ccpTitle() {
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
                      text: (widget.ccType == "1")
                          ? Palette.searchCASHCARD_title
                          : (widget.ccType == "2")
                              ? Palette.searchCASHCOUPON_title
                              : (widget.ccType == "3")
                                  ? Palette.searchdisccoup_title
                                  : (widget.ccType == "4")
                                      ? Palette.searchCURRENCY_title
                                      : (widget.ccType == "5")
                                          ? Palette.searchOTHERCASH_title
                                          : (widget.ccType == "6")
                                              ? Palette.searchCREDITCARD_title
                                              : (widget.ccType == "7")
                                                  ? Palette
                                                      .searchDEBITCARD_title
                                                  : Palette
                                                      .searchDEBITCARD_title,
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

  Widget smlistHDForm() {
    return Stack(
      children: [
        Positioned(
          top: 50,
          left: 10,
          child: salmanhdcTitle(),
        ),
      ],
    );
  }

  Widget ccplistForm() {
    return Stack(
      children: [
        Positioned(
          top: 30,
          left: 16,
          child: (paymentinfo == null)
              ? Container()
              : CCPSearchList(
                  txt: _posinput.txtMemberSearch,
                  responseCCP: widget.responseCCP,
                  ccpType: widget.ccType,
                  paymentinfo: paymentinfo),
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

  Widget smCommandForm() {
    return Stack(
      children: [
        curveButtons(context, _responseInput, stdButtuon0[4], 340, 150,
            Palette.stdbutton_width, Palette.stdbutton_height),
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
        //normalDialog(context, result);
      } else if (result == "CANCEL") {
        //--must clear form data--before close!
        // widget.actionDo();
        Navigator.pop(context);
      }
      //---member search by result (MemberID )then display data in forms here!
    }
  }

  @override
  void onGetPaymentError(String error) {
    paymentinfo = null;
  }

  @override
  void onGetPaymentSuccess(List<PaymentInfo> _paymentInfo) {
    if (_paymentInfo != null) {
      paymentinfo = _paymentInfo;
      setState(() {});
    }
  }
}
