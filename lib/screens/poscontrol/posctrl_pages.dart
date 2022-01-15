import 'dart:typed_data';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posAcmModel.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolmodel.dart';
import 'package:com_csith_geniuzpos/models/posctrls/poscontrol.dart';
import 'package:com_csith_geniuzpos/reports/pdfprinting/pdfprintctrl.dart';
import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/screens/posparams/components/posparam_searchresult.dart';
import 'package:com_csith_geniuzpos/services/response/escpos_response.dart';
import 'package:com_csith_geniuzpos/services/response/poscontrol_response.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/curve_button.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/posimenubtn.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/resources/styles.dart';
//import 'package:flutter_pdf_printer/flutter_pdf_printer.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as Pdf;
import 'package:printing/printing.dart';

//import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'components/posctrl_searchresult.dart';

class PosCtrlPages extends StatefulWidget {
  @override
  _PosCtrlPages createState() => _PosCtrlPages();
}

class _PosCtrlPages extends State<PosCtrlPages>
    implements PosFncCallBack, GetPosCtrlCallBack, POSprintCallBack {
  PosFncCallResponse _responseInput;
  GetPosCtrlResponse _responsePosCtrl;
  POSprintResponse _responseEscPos;
  TextEditingController activeTxt;
  final PosInput _posinput = new PosInput();
  _PosCtrlPages() {
    _responseInput = new PosFncCallResponse(this);
    _responsePosCtrl = new GetPosCtrlResponse(this);
    _responseEscPos = new POSprintResponse(this);
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
  String checkConfigId;
  String checkPrintFormId;

  PosAcmModel _modelParams;
  @override
  void initState() {
    fcn1 = FocusNode();
    fcn2 = FocusNode();
    fcn3 = FocusNode();
    putPosCtrlClearValues();
    _posOptSelect = 0;
    posctrlImgUrl = PosControlFnc().urlHost + "/menu-icon/menu-config.png";
    checkConfigId = '';
    checkPrintFormId = '';
    _responseInput.doEntry('SEARCH', 0, 0);
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
    checkConfigId = posCtrl.itemcode;
    setState(() {
      _posinput.txt1.text = posCtrl.itemcode;
      _posinput.txt2.text = posCtrl.description;
      _posinput.txt3.text = posCtrl.valuetext;
      posctrlImgUrl = posCtrl.image;
      //  normalDialog(context, posCtrl.image);
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
              menuSetPosiButtons(context, _responseInput, stdButtuon14[1],
                  stdButtuonMenu[13], 35, 230, 1),
              (checkConfigId == '10041')
                  ? menuSetPosiButtons(context, _responseInput, stdButtuon14[1],
                      stdButtuonMenu[19], 40, 450, 1)
                  : Container(),
              (checkConfigId == '10041')
                  ? menuSetPosiButtons(context, _responseInput, stdButtuon14[1],
                      stdButtuonMenu[20], 40, 350, 1)
                  : Container(),
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
                      child: PosCtrlSearchPages(
                          responsePosCtrl: _responsePosCtrl,
                          txt: _posinput.txt1,
                          actionDo: putPosCtrlClearValues,
                          posCtrlLists: _model.poscontrolList),
                    ),
                  ],
                ),
              );
            },
          );
        }
        break;
      case "PARAMS":
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
                    child: PosParamSearchPages(
                      actdo: getData,
                    ),
                  ),
                ],
              ),
            );
          },
        );

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
                      text: Palette.posctrl_title,
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
                                text: Palette.posctrl_f1,
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
        curveButtons(context, _responseInput, stdButtuon0[5], 50, 527,
            Palette.stdbutton_width * 0.8, Palette.stdbutton_height * 1.05),
        // positionCurveButtons(context, _responseInput, stdButtuon7, 56, 782, 12)
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
                                text: Palette.posctrlf11,
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
                            text: Palette.posctrlf111,
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
                                text: Palette.posctrlf2,
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
      if (result == "EscPos") {
        checkPrintFormId = result;

        _responseEscPos.posPrint(
            context, PdfPrintCtrl().format80mm, checkPrintFormId, 0, '');
        //_responseEscPos.PosPrint(PdfPageFormat.roll80, checkPrintFormId);
      } else if (result == "FullTax") {
        checkPrintFormId = result;
        _responseEscPos.posPrint(
            context, PdfPrintCtrl().formatA4, checkPrintFormId, 0, '');
      } else if (result == "RegSave") {
        //---save --- POS CONTROL ---HIVE---
        updatePosControl();
      } else if (result == "UPDATE") {
        showPopupTask(context, "PARAMS");
      } else if (result == "SEARCH") {
        showPopupTask(context, "CONFIGLIST");
      } else if (result == "CANCEL") {
        Navigator.pop(context);
      }
      //---posctrl search by result (posctrlID )then display data in forms here!
    }
  }

  void getData(PosControl data) async {
    if (_posinput.txt1.text == '10002') {
      List<PosCtrl> screentypes = posCtrlListOpt
          .where((e) => (e.itemcode ==
              _model.poscontrolList[MyConfig().i_srcDisplayStyle].posctrlkey))
          .toList();
      String posScreenType = data.posctrldata;
      if (posScreenType == screentypes[0].valuetext.split('-')[0].trim()) {
        _posinput.txt3.text = screentypes[0].valuetext;
      } else if (posScreenType ==
          screentypes[1].valuetext.split('-')[0].trim()) {
        _posinput.txt3.text = screentypes[1].valuetext;
      } else if (posScreenType ==
          screentypes[2].valuetext.split('-')[0].trim()) {
        _posinput.txt3.text = screentypes[2].valuetext;
      } else if (posScreenType ==
          screentypes[3].valuetext.split('-')[0].trim()) {
        _posinput.txt3.text = screentypes[3].valuetext;
      }
    } else if (_posinput.txt1.text == '10048') {
      List<PosCtrl> sitDisplayStyles = posCtrlListOpt
          .where((e) => (e.itemcode ==
              _model.poscontrolList[MyConfig().i_sitDisplayStyle].posctrlkey))
          .toList();
      String slipItDs = data.posctrldata.trim();
      if (slipItDs == sitDisplayStyles[0].valuetext.split('-')[0].trim()) {
        _posinput.txt3.text = sitDisplayStyles[0].valuetext;
      } else if (slipItDs ==
          sitDisplayStyles[1].valuetext.split('-')[0].trim()) {
        _posinput.txt3.text = sitDisplayStyles[1].valuetext;
      } else if (slipItDs ==
          sitDisplayStyles[2].valuetext.split('-')[0].trim()) {
        _posinput.txt3.text = sitDisplayStyles[2].valuetext;
      } else if (slipItDs ==
          sitDisplayStyles[3].valuetext.split('-')[0].trim()) {
        _posinput.txt3.text = sitDisplayStyles[3].valuetext;
      } else if (slipItDs ==
          sitDisplayStyles[4].valuetext.split('-')[0].trim()) {
        _posinput.txt3.text = sitDisplayStyles[4].valuetext;
      }
    } else {
      _posinput.txt3.text = data.posctrldata;
    }
  }

  void updatePosControl() {
    if (isOptItem) {
      PosControlFnc().updatePosControl(
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

  @override
  void onESCPOSError(String error) {}

  @override
  void onESCPOSSuccess(Uint8List pdfFile) {
    //  pdfDialog(context, 'Hello world PDF', pdfFile);
    printOut(pdfFile);
  }

  void printOut(Uint8List pdfFile) async {
    if (checkPrintFormId == 'EscPos') {
      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdfFile);
    } else if (checkPrintFormId == 'FullTax') {
      pdfDialog(context, checkPrintFormId, pdfFile);
    }
  }
}
