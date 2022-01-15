import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';

import 'package:com_csith_geniuzpos/models/persons/psmember.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/services/response/person_reponse.dart';

import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/curve_button.dart';

import 'package:com_csith_geniuzpos/widgets/buttons/position_curvbutton.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';

import 'package:com_csith_geniuzpos/resources/styles.dart';
import 'package:intl/intl.dart';

import 'components/member_searchresult.dart';

class MemberInfoOkPages extends StatefulWidget {
  final GetSearchMemberResponse responseMember;
  final String search;
  const MemberInfoOkPages(this.responseMember, this.search);

  @override
  _MemberInfoOkPages createState() => _MemberInfoOkPages();
}

class _MemberInfoOkPages extends State<MemberInfoOkPages>
    implements PosFncCallBack, GetSearchMemberCallBack, GetMemberListCallBack {
  PosFncCallResponse _responseInput;
  GetSearchMemberResponse _responseMember;
  GetMemberListResponse _responseMemberList;
  TextEditingController activeTxt;
  final PosInput _posinput = new PosInput();
  _MemberInfoOkPages() {
    _responseInput = new PosFncCallResponse(this);
    _responseMember = new GetSearchMemberResponse(this);
    _responseMemberList = new GetMemberListResponse(this);
    psMember = new PsMember();
  }
  List<PsMember> psMembers;
  PsMember psMember;
  FocusNode fcn1, fcn2, fcn3, fcn4, fcn5, fcn6, fcn7, fcn8;
  String memberImgUrl;
  @override
  void initState() {
    fcn1 = FocusNode();
    fcn2 = FocusNode();
    fcn3 = FocusNode();
    fcn4 = FocusNode();
    fcn5 = FocusNode();
    fcn6 = FocusNode();
    fcn7 = FocusNode();
    fcn8 = FocusNode();
    fcn1.requestFocus();
    memberImgUrl = PosControlFnc().urlHost + "/icon-png/member.png";
    super.initState();
  }

  void putMeberValues(PsMember _psMember) {
    setState(() {
      _posinput.txtMemberCode.text = _psMember.mbId;
      _posinput.txtMemberName.text = _psMember.mbNameT;
      _posinput.txtMemberType.text = _psMember.mbType;
      _posinput.txtMemberCurPoint.text = _psMember.mbAccumPoint.toString();
      _posinput.txtMemberExpireDate.text =
          DateFormat('dd/MM/yyyy').format(_psMember.mbExpireDate);
      _posinput.txtMemberBD.text =
          DateFormat('dd/MM/yyyy').format(_psMember.mbBirthDay);
      _posinput.txtMemebrCurCash.text = _psMember.mbCardStatus.toString();
      memberImgUrl = (_psMember.mbPhoto == '')
          ? PosControlFnc().urlHost + '/icon-png/member.png'
          : PosControlFnc().urlHost + _psMember.mbPhoto;
      // normalDialog(context, memberImgUrl);
    });
  }

  void putMeberClearValues() {
    setState(() {
      _posinput.txtMemberCode.text = '';
      _posinput.txtMemberName.text = '';
      _posinput.txtMemberType.text = '';
      _posinput.txtMemberCurPoint.text = '';
      _posinput.txtMemberExpireDate.text = '';
      _posinput.txtMemberBD.text = '';
      _posinput.txtMemebrCurCash.text = '';
      memberImgUrl = PosControlFnc().urlHost + '/icon-png/member.png';
    });
  }

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
        Container(child: mbtypeForm()),
        Container(child: mbBirtDayForm()),
        Container(child: mbPointForm()),
        Container(child: mbCashCardForm()),
        Container(child: mbMemoForm()),
        Container(child: mbExpireDateForm()),
        Container(child: mbPhotoForm()),
        Container(child: mbCommandForm()),
      ]),
    );
  }

  Future<void> showPopupTask(BuildContext context, String mnuName) async {
    switch (mnuName) {
      case "MEMBERLIST":
        {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                insetAnimationDuration: const Duration(milliseconds: 100),
                child: Stack(
                  children: [
                    Container(
                      // use container to change width and height
                      height: Palette.stdbutton_height * 9.55,
                      width: Palette.stdbutton_width * 13.6,
                      child: MemberSearchListPages(
                          responseMember: _responseMember,
                          txt: _posinput.txtMemberCode,
                          actionDo: putMeberClearValues,
                          psMembers: psMembers),
                    ),
                  ],
                ),
              );
            },
          );
        }
        break;

      default:
        normalDialog(context, mnuName);
        break;
    }
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
                      text: Palette.sales_member_title,
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
          top: 56,
          left: 10,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 3.6,
                height: Palette.stdbutton_height * 1.2,
                child: Row(
                  children: [
                    Container(
                      width: Palette.stdbutton_width * 3.6,
                      height: Palette.stdbutton_height * 1.2,
                      padding: const EdgeInsets.all(1),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: Palette.sales_member_f1,
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
          top: 60,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              focusNode: fcn1,
              controller: _posinput.txtMemberCode,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn2.requestFocus();
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Member Code',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
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
        curveButtons(context, _responseInput, stdButtuon0[2], 50, 447,
            Palette.stdbutton_width * 0.8, Palette.stdbutton_height * 1.05),
        positionCurveButtons(context, _responseInput, stdButtuon7, 56, 782, 12)
      ],
    );
  }

  Widget mbnameForm() {
    return Stack(
      children: [
        Positioned(
          top: 114,
          left: 10,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 4,
                height: Palette.stdbutton_height,
                child: Row(
                  children: [
                    Container(
                      width: Palette.stdbutton_width * 3.6,
                      height: Palette.stdbutton_height,
                      padding: const EdgeInsets.all(1),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: Palette.sales_member_f11,
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
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 9.7,
            height: Palette.onelineheigth() * 0.8,
            // padding: const EdgeInsets.all(1),
            child: TextField(
              focusNode: fcn2,
              controller: _posinput.txtMemberName,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn3.requestFocus();
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                //  contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Member Name',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
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
      ],
    );
  }

  Widget mbtypeForm() {
    return Stack(
      children: [
        Positioned(
          top: 172,
          left: 10,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 3.6,
                height: Palette.stdbutton_height * 1.2,
                child: Row(
                  children: [
                    Container(
                      width: Palette.stdbutton_width * 3.6,
                      height: Palette.stdbutton_height * 1.2,
                      padding: const EdgeInsets.all(1),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: Palette.sales_member_f2,
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
          top: 178,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              focusNode: fcn3,
              controller: _posinput.txtMemberType,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn4.requestFocus();
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Member Type',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
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
      ],
    );
  }

  Widget mbExpireDateForm() {
    return Stack(
      children: [
        Positioned(
          top: 172,
          left: 480,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 3.6,
                height: Palette.stdbutton_height * 1.2,
                child: Row(
                  children: [
                    Container(
                      width: Palette.stdbutton_width * 3.6,
                      height: Palette.stdbutton_height * 1.2,
                      padding: const EdgeInsets.all(1),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: Palette.sales_member_f7,
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
          top: 178,
          left: 595,
          child: Container(
            width: Palette.stdbutton_width * 4.2,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1)
            child: TextField(
              autofocus: true,
              focusNode: fcn8,
              controller: _posinput.txtMemberExpireDate,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn4.requestFocus();
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Expire Date',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
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
      ],
    );
  }

  Widget mbBirtDayForm() {
    return Stack(
      children: [
        Positioned(
          top: 230,
          left: 10,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 3.6,
                height: Palette.stdbutton_height * 1.2,
                child: Row(
                  children: [
                    Container(
                      width: Palette.stdbutton_width * 3.6,
                      height: Palette.stdbutton_height * 1.2,
                      padding: const EdgeInsets.all(1),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: Palette.sales_member_f3,
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
          top: 238,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              focusNode: fcn4,
              controller: _posinput.txtMemberBD,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn5.requestFocus();
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Birth Day',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
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
      ],
    );
  }

  Widget mbPointForm() {
    return Stack(
      children: [
        Positioned(
          top: 288,
          left: 10,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 3.6,
                height: Palette.stdbutton_height * 1.2,
                child: Row(
                  children: [
                    Container(
                      width: Palette.stdbutton_width * 3.6,
                      height: Palette.stdbutton_height * 1.2,
                      padding: const EdgeInsets.all(1),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: Palette.sales_member_f4,
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
          top: 296,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              focusNode: fcn5,
              controller: _posinput.txtMemberCurPoint,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn6.requestFocus();
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Current Points',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
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
      ],
    );
  }

  Widget mbCashCardForm() {
    return Stack(
      children: [
        Positioned(
          top: 346,
          left: 10,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 3.6,
                height: Palette.stdbutton_height * 1.2,
                child: Row(
                  children: [
                    Container(
                      width: Palette.stdbutton_width * 3.6,
                      height: Palette.stdbutton_height * 1.2,
                      padding: const EdgeInsets.all(1),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: Palette.sales_member_f5,
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
          top: 356,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              focusNode: fcn6,
              controller: _posinput.txtMemebrCurCash,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn7.requestFocus();
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Cash Card Amount',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
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
      ],
    );
  }

  Widget mbMemoForm() {
    return Stack(
      children: [
        Positioned(
          top: 404,
          left: 10,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 3.6,
                height: Palette.stdbutton_height * 1.2,
                child: Row(
                  children: [
                    Container(
                      width: Palette.stdbutton_width * 3.6,
                      height: Palette.stdbutton_height * 1.2,
                      padding: const EdgeInsets.all(1),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: Palette.sales_member_f6,
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
          top: 410,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 3.6,
            height: Palette.onelineheigth() * 4.8,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              focusNode: fcn7,
              controller: _posinput.txtMemberMemory,
              keyboardType: TextInputType.text,
              maxLines: 5,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn8.requestFocus();
              },
              textAlignVertical: TextAlignVertical.top,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Note',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
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
      ],
    );
  }

  Widget mbPhotoForm() {
    return Stack(
      children: [
        Positioned(
          top: 238,
          left: 484,
          child: Container(
            width: Palette.stdbutton_width * 5.6,
            height: Palette.stdbutton_height * 6.6,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Palette.stdbutton_theme_6,
            ),
            child: ClipOval(
                child: Container(
                    width: 60,
                    height: 60,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: ExactAssetImage(memberImgUrl),
                        fit: BoxFit.fitHeight,
                      ),
                      shape: BoxShape.circle,
                    ))),
          ),
        ),
      ],
    );
  }

  Widget mbCommandForm() {
    return Stack(
      children: [
        curveButtons(context, _responseInput, stdButtuon0[4], 594, 60,
            Palette.stdbutton_width * 1.3, Palette.stdbutton_height * 1.3),
        curveButtons(context, _responseInput, stdButtuon0[3], 594, 300,
            Palette.stdbutton_width * 1.3, Palette.stdbutton_height * 1.3),
      ],
    );
  }

  void closeMe() {
    Navigator.pop(context);
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
        widget.responseMember.getResultSearchToMemberForm(psMember);
        setState(() {
          String curmember = _posinput.txtMemberCode.text.trim() +
              ' - ' +
              _posinput.txtMemberName.text.trim().padRight(45).substring(0, 44);
          PosControlFnc().updateMember(context, curmember);
        });
        Navigator.pop(context);
      } else if (result == "SEARCH") {
        String url = PosControlFnc()
            .getMemberurl(context); // + '/i/' + _posinput.txt1.text;
        _responseMemberList.getMemberListForm('', url);
      } else if (result == "CANCEL") {
        Navigator.pop(context);
      }
    }
  }

  @override
  void onSearchMemberError(String error) {}

  @override
  void onSearchMemeberSuccess(PsMember _psMember) {
    //---get the Member Data then --- refresh binding to member forms---
    if (_psMember != null) {
      psMember = _psMember;
      // normalDialog(context, psMember.mbId + ' ' + psMember.mbNameT);
      putMeberValues(_psMember);
    }
  }

  @override
  void onSearchMemberListError(String error) {}

  @override
  void onSearchMemeberListSuccess(List<PsMember> _psMembers) {
    psMembers = _psMembers;
    setState(() {
      showPopupTask(context, "MEMBERLIST");
    });
  }
}
