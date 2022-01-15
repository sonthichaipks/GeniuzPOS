import 'package:com_csith_geniuzpos/resources/posacm_data.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';

import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolmodel.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/services/response/poscontrol_response.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/curve_button.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/posimenubtn.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/resources/styles.dart';
import 'package:provider/provider.dart';
import 'components/posacm_searchresult.dart';

class PosAcmPages2 extends StatefulWidget {
  @override
  _PosAcmPages createState() => _PosAcmPages();
}

class _PosAcmPages extends State<PosAcmPages2>
    implements PosFncCallBack, GetPosCtrlCallBack {
  PosFncCallResponse _responseInput;
  GetPosCtrlResponse _responsePosCtrl;
  TextEditingController activeTxt;
  final PosInput _posinput = new PosInput();
  _PosAcmPages() {
    _responseInput = new PosFncCallResponse(this);
    _responsePosCtrl = new GetPosCtrlResponse(this);
    _posCtrl = new PosCtrl();
  }
  PosControlModel _model;
  List<PosCtrl> _posCtrlListOpt;
  int _posOptSelect;
  bool isOptItem = false;
  PosCtrl _posCtrl;
  FocusNode fcn1, fcn2, fcn3, fcn4, fcn5, fcn6, fcn7, fcn8;
  bool fcb1, fcb2, fcb3;
  String posctrlImgUrl;
  @override
  void initState() {
    fcn1 = FocusNode();
    fcn2 = FocusNode();
    fcn3 = FocusNode();
    putPosCtrlClearValues();
    _posOptSelect = 0;
    posctrlImgUrl = PosControlFnc().urlHost + "/menu-icon/menu-config.png";
    // _responseInput.doEntry('SEARCH', 0, 0);
    _posCtrlListOpt = new PosAcm().posCycleAcm;
    super.initState();
  }

  void putPosCtrlOpt() {
    try {
      _posCtrlListOpt = posCtrlListOpt
          .where((e) => e.groupcode == _posinput.txt1.text)
          .toList();
      if (_posCtrlListOpt.length > 0) {
        isOptItem = true;
        if (_posOptSelect > _posCtrlListOpt.length - 1) {
          _posOptSelect = 0;
        }
        setState(() {
          putPosCtrlValues(_posCtrlListOpt[_posOptSelect], 1);
        });
        _posOptSelect += 1;
        fcb3 = false;
      } else {
        isOptItem = false;
        _posOptSelect = 0;
        fcb3 = true;
        fcn3.requestFocus();
      }
    } catch (e) {}
  }

  void putPosCtrlValues(PosCtrl posCtrl, int _default) {
    if (_default != 0) {
      _posCtrl = posCtrl;
    }
    setState(() {
      _posinput.txt1.text = posCtrl.itemcode;
      _posinput.txt2.text = posCtrl.description;
      _posinput.txt3.text = posCtrl.valuetext;
      posctrlImgUrl = posCtrl.image;
      fcb1 = false;
      fcb2 = false;
      fcb3 = true;
      fcn1.canRequestFocus;
      fcn2.canRequestFocus;
      fcn3.requestFocus();
    });
  }

  void putPosCtrlClearValues() {
    setState(() {
      _posinput.txt1.text = '';
      _posinput.txt2.text = '';
      _posinput.txt3.text = '';
      fcb1 = true;
      fcb2 = false;
      fcb3 = false;
      _posOptSelect = 0;
      fcn1.requestFocus();
    });
  }

  @override
  void dispose() {
    fcn1.dispose();
    fcn2.dispose();
    fcn3.dispose();
    PosInput().focusnode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<PosControlModel>().getItem();
    return Consumer<PosControlModel>(builder: (context, model, child) {
      _model = model;
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
    });
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
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: posctrlTitle()),
        Container(child: pscodeForm()),
        Container(child: psnameForm()),
        Container(child: psValueForm()),
        Container(child: psMemoForm()),
        Container(child: psPhotoForm()),
        Container(child: psCtrlMenu()),
      ]),
    );
  }

  Widget psCtrlMenu() {
    return Positioned(
      top: 200,
      left: 10,
      child: Container(
          height: Palette.stdbutton_height * 8,
          width: Palette.stdbutton_width * 10.5,
          child: Stack(
            children: [
              menuSetPosiButtons(context, _responseInput, stdButtuon14[1],
                  stdButtuonMenu[12], 25, 230, 0),
              // menuSetPosiButtons(context, _responseInput, stdButtuon14[1],
              //     stdButtuonMenu[18], 35, 230, 1),
              menuSetPosiButtons(context, _responseInput, stdButtuon14[1],
                  stdButtuonMenu[13], 35, 230, 1),
            ],
          )),
    );
  }

  Future<void> showPopupTask(BuildContext context, String mnuName) async {
    switch (mnuName) {
      case "CONFIGLIST":
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
                      height: Palette.stdbutton_height * 9.8,
                      width: Palette.stdbutton_width * 7.3,
                      child: PosAcmSearchPages(
                        responsePosCtrl: _responsePosCtrl,
                        txt: _posinput.txt1,
                        actionDo: putPosCtrlClearValues,
                        posAcmLists: _posCtrlListOpt,
                      ),
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

  Widget posctrlTitle() {
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
                      text: Palette.posacm_title,
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

  Widget pscodeForm() {
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
                                text: Palette.posacm_f1,
                                style: TextStyle(
                                  fontFamily: 'Tahoma',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
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
              enabled: fcb1,
              focusNode: fcn1,
              controller: _posinput.txt1,
              onChanged: (text) {},
              onSubmitted: (result) {
                fcn2.requestFocus();
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: '',
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
      ],
    );
  }

  Widget psnameForm() {
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
                                text: Palette.posacmf11,
                                style: TextStyle(
                                  fontFamily: 'Tahoma',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
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
            width: Palette.stdbutton_width * 4.7,
            height: Palette.onelineheigth() * 0.8,
            // padding: const EdgeInsets.all(1),
            child: TextField(
              focusNode: fcn2,
              enabled: fcb2,
              controller: _posinput.txt2,
              onChanged: (text) {},
              onSubmitted: (result) {
                //fcn3.requestFocus();
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                //  contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: '',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CsiStyle().primaryColor),
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              style: TextStyle(
                color: Colors.purple,
                fontStyle: FontStyle.italic,
                fontFamily: 'Tahoma',
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget psValueForm() {
    return Stack(
      children: [
        Positioned(
            top: 192,
            left: 10,
            child: Container(
              width: Palette.stdbutton_width * 1.9,
              height: Palette.stdbutton_height * 0.3,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Palette.stdbutton_theme_7,
                  border: Border(
                    top: BorderSide(
                        width: 1.0, color: Palette.stdbutton_theme_7),
                    left: BorderSide(
                        width: 1.0, color: Palette.stdbutton_theme_7),
                    right: BorderSide(
                        width: 1.0, color: Palette.stdbutton_theme_7),
                    bottom: BorderSide(width: 1.0, color: Colors.red),
                  )),
            )),
        Positioned(
          top: 172,
          left: 10,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 3.6,
                height: Palette.stdbutton_height * 1.2,
                child: GestureDetector(
                  onTap: () {
                    putPosCtrlOpt();
                  },
                  child: RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      text: '',
                      children: <TextSpan>[
                        TextSpan(
                            text: Palette.posacmf111,
                            style: TextStyle(
                              fontFamily: 'Tahoma',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.black,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 178,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 6.6,
            height: Palette.onelineheigth() * 0.8,
            //padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              enabled: fcb3,
              focusNode: fcn3,
              controller: _posinput.txt3,
              onChanged: (text) {},
              onSubmitted: (result) {
                if (!isOptItem) {
                  isOptItem = true;
                }
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                // contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: '',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
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

  Widget psMemoForm() {
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
                                text: Palette.posacmf2,
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
      ],
    );
  }

  Widget psPhotoForm() {
    return Stack(
      children: [
        Positioned(
          top: 238,
          left: 166,
          child: Container(
            width: Palette.stdbutton_width * 6.6,
            height: Palette.onelineheigth() * 5,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Palette.stdbutton_theme_6,
            ),
            child: (posctrlImgUrl == '')
                ? ClipOval(
                    child: Image.network(
                    PosControlFnc().urlHost + "/icon-png/posctrl.png",
                    fit: BoxFit.fitHeight,
                    // width: 120.0,
                    // height: 120.0,
                  ))
                : Center(
                    child: Container(
                      width: Palette.stdbutton_width * 6.4,
                      height: Palette.onelineheigth() * 4.8,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(posctrlImgUrl),
                        ),
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget psCommandForm() {
    return Stack(
      children: [
        curveButtons(context, _responseInput, stdButtuon0[4], 224, 80,
            Palette.stdbutton_width * 1.3, Palette.stdbutton_height * 1.3),
        curveButtons(context, _responseInput, stdButtuon0[3], 224, 380,
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
        // putPosCtrlValues(_posCtrl, 1);
      } else if (result == "RegAdd") {
        // addPosAcm();
      } else if (result == "RegSave") {
        //---save --- POS CONTROL ---HIVE---
        updatePosControl();
      } else if (result == "SEARCH") {
        showPopupTask(context, "CONFIGLIST");
      } else if (result == "CANCEL") {
        Navigator.pop(context);
      }
      //---posctrl search by result (posctrlID )then display data in forms here!
    }
  }

  void updatePosControl() {
    if (isOptItem) {
      PosControlFnc().updatePosACM(
          context,
          PosCtrl(
              itemcode: _posCtrl.itemcode,
              description: _posCtrl.description,
              groupcode: _posCtrl.groupcode,
              valuetext: _posinput.txt3.text,
              valueint: _posCtrl.valueint,
              valuedbl: _posCtrl.valuedbl,
              image: posctrlImgUrl));
      normalDialog(
          context,
          'SAVE THIS CONFIGURATION :' +
              _posCtrl.itemcode +
              ' = ' +
              _posinput.txt3.text);
    } else {
      // PosControlFnc().updatePosControl(context, _posCtrl);
      normalDialog(
          context,
          'NOT SAVE, STILL THIS CONFIGURATION VALUE :' +
              _posCtrl.itemcode +
              ' = ' +
              _posCtrl.valuetext);
    }
  }

  @override
  void onGetPosCtrlError(String error) {}

  @override
  void onGetPosCtrlSuccess(PosCtrl posControl) {
    if (posControl != null) {
      _posCtrl = posControl;
      isOptItem = false;
      putPosCtrlValues(_posCtrl, 0);
    }
  }
}
