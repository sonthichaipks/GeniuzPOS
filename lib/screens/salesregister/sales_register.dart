import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/possales/bdcitemmodel.dart';
import 'package:com_csith_geniuzpos/data/possales/rcpitemmodel.dart';
import 'package:com_csith_geniuzpos/data/possales/salesitemmodel.dart';
import 'package:com_csith_geniuzpos/models/posmodels/posshiftlogin.dart';
import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/resources/fnccal.dart';
import 'package:com_csith_geniuzpos/screens/cashinouts/cashinout_ok.dart';
import 'package:com_csith_geniuzpos/screens/posparams/components/posparam_searchresult.dart';
import 'package:com_csith_geniuzpos/services/response/poscontrol_response.dart';
import 'package:com_csith_geniuzpos/services/response/posdata_response.dart';

import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';

import 'package:com_csith_geniuzpos/resources/styles.dart';
import 'package:provider/provider.dart';

import 'components/register_numpad.dart';

class SalesSignInPages extends StatefulWidget {
  @override
  _SalesSignInPages createState() => _SalesSignInPages();
}

class _SalesSignInPages extends State<SalesSignInPages>
    implements
        PosFncCallBack,
        clsSalSUmItemCallBack,
        GetPosSignInCallBack,
        execPosShiftCallBack {
  PosFncCallResponse _responseInput;
  clsSalSUmItemResponse _responseClsSalSum;
  GetPosSigninResponse _responseGetSignin;
  ExecPosShiftResponse _responseExecShift;
  TextEditingController activeTxt;
  String cashierlogin = '';
  final PosInput _posinput = new PosInput();
  FocusNode userFocusNode, passFocusNode;
  _SalesSignInPages() {
    _responseInput = new PosFncCallResponse(this);
    _responseClsSalSum = new clsSalSUmItemResponse(this);
    _responseGetSignin = new GetPosSigninResponse(this);
    _responseExecShift = new ExecPosShiftResponse(this);
  }
  int _checkConfigCashier = 0;
  String cashierID, Password;
  bool readySignin = false;
  @override
  void initState() {
    userFocusNode = FocusNode();
    passFocusNode = FocusNode();

    // userFocusNode.addListener(() {
    //   if (userFocusNode.hasFocus) {
    //     activeTxt = _posinput.txtUser;
    //     _posinput.setActiveTxt(_posinput.txtUser, userFocusNode);
    //   }
    // });
    // passFocusNode.addListener(() {
    //   if (passFocusNode.hasFocus) {
    //     activeTxt = _posinput.txtPass;
    //     _posinput.setActiveTxt(_posinput.txtPass, passFocusNode);
    //   }
    // });s
    activeTxt = _posinput.txtUser;
    userFocusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    PosInput().focusnode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<SalesItemHiveModel>().getItem();
    context.watch<BillDCItemHiveModel>().getItem();
    context.watch<ReceiptItemHiveModel>().getItem();
    return Container(
      height: Palette.stdbutton_height * 8,
      width: Palette.stdbutton_width * 10.5,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 0, color: Palette.stdbutton_theme_51),
            left: BorderSide(width: 0, color: Palette.stdbutton_theme_51),
            right: BorderSide(width: 0, color: Palette.stdbutton_theme_51),
            bottom: BorderSide(width: 0, color: Colors.white),
          )),
      child: Scaffold(body: registereScreenDesktop(context)),
    );
    // });
  }

  Widget registereScreenDesktop(BuildContext context) {
    return Container(
      height: Palette.stdbutton_height * 8,
      width: Palette.stdbutton_width * 10.5,
      child: Stack(children: [
        Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0), child: registerTitle()),
        Container(child: userForm()),
        Container(child: passForm()),
        Positioned(
            top: 130,
            left: 160,
            child: registerNumpad(context, _responseInput)),
      ]),
    );
  }

  Widget registerTitle() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
              color: Palette.stdbutton_theme_51,
              border: Border(
                top: BorderSide(width: 1.0, color: Palette.stdbutton_theme_51),
                left: BorderSide(width: 1.0, color: Palette.stdbutton_theme_51),
                right:
                    BorderSide(width: 1.0, color: Palette.stdbutton_theme_51),
                bottom: BorderSide(width: 1.0, color: Colors.white),
              )),
          child: Center(
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                text: '',
                children: <TextSpan>[
                  TextSpan(
                      text: Palette.sales_register_title,
                      style: TextStyle(
                        fontFamily: 'Leelawadee',
                        fontWeight: FontWeight.w400,
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

  Widget userForm() {
    return Stack(
      children: [
        Positioned(
          top: 60,
          left: 190,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 4,
                height: Palette.stdbutton_height,
                child: Row(
                  children: [
                    Container(
                      width: Palette.stdbutton_width * 4,
                      height: Palette.stdbutton_height,
                      padding: const EdgeInsets.all(1),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: MyConfig().sales_register_user,
                                style: TextStyle(
                                  fontFamily: 'Leelawadee',
                                  fontWeight: FontWeight.w400,
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
          top: 70,
          left: 420,
          child: Container(
            width: Palette.stdbutton_width * 2.4,
            height: Palette.onelineheigth() * 0.7,
            padding: const EdgeInsets.all(1),
            child: TextField(
              autofocus: true,
              focusNode: userFocusNode,
              controller: _posinput.txtUser,
              onChanged: (text) {},
              onSubmitted: (result) {
                _posinput.txtUser.text = result;
                _checkConfigCashier = 1; //doCheckConfigCashier(result);
                // 0-default, 1-same config, 2-Not same, 3-New
                txtinputEntry("CHECKCASHIERCACHE");
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                hintText: cashierlogin,
                labelText: getCashierLabel(_checkConfigCashier),
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

  Widget passForm() {
    return Stack(
      children: [
        Positioned(
          top: 110,
          left: 190,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Container(
                width: Palette.stdbutton_width * 4,
                height: Palette.stdbutton_height,
                child: Row(
                  children: [
                    Container(
                      width: Palette.stdbutton_width * 4,
                      height: Palette.stdbutton_height,
                      padding: const EdgeInsets.all(1),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          text: '',
                          children: <TextSpan>[
                            TextSpan(
                                text: MyConfig().sales_register_pass,
                                style: TextStyle(
                                  fontFamily: 'Leelawadee',
                                  fontWeight: FontWeight.w400,
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
          left: 420,
          child: Container(
            width: Palette.stdbutton_width * 2.4,
            height: Palette.onelineheigth() * 0.7,
            padding: const EdgeInsets.all(1),
            child: TextField(
              focusNode: passFocusNode,
              controller: _posinput.txtPass,
              obscureText: true, //--hidden and mark entry--password
              onChanged: (text) {},
              onSubmitted: (result) {
                var tl = result.length;
                if (tl > 0) {
                  _posinput.txtPass.text = result;
                  txtinputEntry("ENTER");
                }
              },
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                labelStyle: TextStyle(color: Colors.grey),
                labelText: 'Password',
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
      var tl = activeTxt.text.length;
      if (result == "BACKSPACE") {
        if (tl > 0) {
          activeTxt.text = activeTxt.text.substring(0, tl - 1);
        } else {
          activeTxt = _posinput.txtUser;
          _checkConfigCashier = 0;
        }
        if (activeTxt == _posinput.txtPass) {
          _posinput.setActiveTxt(_posinput.txtPass, passFocusNode);
        } else {
          _posinput.setActiveTxt(_posinput.txtUser, userFocusNode);
        }
      } else if (result == "CLS") {
        if (tl == 0) {
          activeTxt = _posinput.txtUser;
          _checkConfigCashier = 0;
        }
        activeTxt.text = "";
        if (activeTxt == _posinput.txtPass) {
          _posinput.setActiveTxt(_posinput.txtPass, passFocusNode);
        } else {
          _posinput.setActiveTxt(_posinput.txtUser, userFocusNode);
        }
      } else if (result == "CHECKCASHIERCACHE") {
        //---check pos config-cashier that memmory
        checkUser();
      } else if (result == "ENTER") {
        if (activeTxt == _posinput.txtPass) {
          if (tl > 0) {
            cashierID = _posinput.txtUser.text.toString().trim();
            Password = _posinput.txtPass.text.toString().trim();
            //--------send PosID/User/Password--to server for Login
            //http://192.168.1.33:9393/GetPosSIgnIn/i/00123/999
            String possignin = PosControlFnc().getPosSignInurl(context) +
                '/' +
                _posinput.txtUser.text.trim();

            _responseGetSignin.getPosSignin(possignin);
          }
        } else {
          cashierID = _posinput.txtUser.text.toString().trim();
          Password = _posinput.txtPass.text.toString().trim();
          _checkConfigCashier = 1; //doCheckConfigCashier(result);
          checkUser();
          // activeTxt = _posinput.txtPass;
        }
      } else {
        activeTxt.text = activeTxt.text + result;
        if (activeTxt == _posinput.txtPass) {
          _posinput.setActiveTxt(_posinput.txtPass, passFocusNode);
        } else {
          _posinput.setActiveTxt(_posinput.txtUser, userFocusNode);
        }
      }
    }
  }

  void checkUser() {
    //---if have the same tell that 'Login again'
    if (_checkConfigCashier > 0) {
      //---if have but not the same , tell that 'Already Config-Cashier Logined'
      //---and ask for decission to next login with or not!
      String _configCashier = PosControlFnc().getConfigCashier(context);
      bool ch = (_configCashier != '' &&
          _configCashier.split('-')[0].trim() != _posinput.txtUser.text);
      if (_configCashier == '') {
        _checkConfigCashier = 3;
        setState(() {
          activeTxt = _posinput.txtPass;
          passFocusNode.requestFocus();
        });
      } else if (ch) {
        // _checkConfigCashier = 2;

        _showAlertDialog(
            context,
            'Already login by cashier:' + _configCashier,
            'Want to',
            'Recover login by cashier ID:' + _posinput.txtUser.text + ' ?');
      } else {
        _checkConfigCashier = 1;
        setState(() {
          activeTxt = _posinput.txtPass;
          passFocusNode.requestFocus();
        });
      }
    } else {
      //---if not have tell that 'New Login' and next to get password.
      setState(() {
        activeTxt = _posinput.txtPass;
        passFocusNode.requestFocus();
      });
    }
  }

  String getCashierLabel(int _chkCashierLogin) {
    if (_chkCashierLogin == 0) {
      return 'Cashier/user id.';
    } else if (_chkCashierLogin == 1) {
      return 'Login again';
    } else if (_chkCashierLogin == 2) {
      return 'Recover login by';
    } else if (_chkCashierLogin == 3) {
      return 'New Login';
    } else {
      return 'Cashier/user id.';
    }
  }

  void _showAlertDialog(
      BuildContext context, String title, String subtitle, String detail) {
    // set up the buttons
    int result = -1;
    Widget remindButton = TextButton(
      child: Text(title),
      onPressed: () {
        //return -1;
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Calcel"),
      onPressed: () {
        _checkConfigCashier = 0;
        _posinput.txtUser.text = '';
        activeTxt = _posinput.txtUser;
        userFocusNode.requestFocus();
        Navigator.of(context).pop();
        //  return 0;
      },
    );
    Widget launchButton = TextButton(
      child: Text("O.K."),
      onPressed: () {
        _checkConfigCashier = 2;
        setState(() {
          activeTxt = _posinput.txtPass;
          passFocusNode.requestFocus();
        });
        Navigator.of(context).pop();
        // return 1;
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(detail),
      actions: [
        // remindButton,
        cancelButton,
        launchButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void begCashDialog(
      BuildContext context, String mnuName, PosShiftLogin activeposShift) {
    switch (mnuName) {
      case "BEGCASH":
        {
          showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                    backgroundColor: Colors.white,
                    insetAnimationDuration: const Duration(milliseconds: 100),
                    child: Container(
                      // use container to change width and height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(color: Colors.white, spreadRadius: 3),
                        ],
                      ),
                      height: Palette.stdbutton_height * 6.6,
                      width: Palette.stdbutton_width * 7.6,
                      child: CashinoutPages(goSalesPages, activeposShift, 1),
                    ));
              });
        }
        break;
    }
    //return 0;
  }

  void goSalesPages(PosShiftLogin activeposShift, double cashbeg) {
    PosControlFnc().newShift(context, activeposShift, cashbeg);
    try {
      //[URL]/Posshift/a/00123/001/1250
      String posexec = PosControlFnc().getAddShifturl(context) +
          '/' +
          _posinput.txtUser.text.trim() +
          '/' +
          c2rnd.format(cashbeg);
      _responseExecShift.exPosShift(posexec);
    } catch (e) {
      showToast(context, e.toString());
    }
  }

  void gotoSalesPage(PosShiftLogin activeposShift) {
    String docno =
        PosControlFnc().getRunno(context, MyConfig().a_cycleRcptBegEnd);
    //---clear ---postran -EV ---all at server

    //---
    if (docno == '000-000-000]000-000-000]') {
      //--new installation
      _posinput.savePOSTrans(context, 0);
      begCashDialog(context, "BEGCASH", activeposShift);
    } else {
      if (activeposShift.shiftStatus == 'C') {
        //--shift posted has sign out
        _posinput.savePOSTrans(context, 0);
        begCashDialog(context, "BEGCASH", activeposShift);
      } else if (activeposShift.shiftStatus == 'O') {
        //--already open
        PosControlFnc().loginShiftId(context, activeposShift);
        PosControlFnc().getDefaultScreen(context, _responseInput);
      } else if (activeposShift.shiftStatus == 'P') {
        //--already Temp exit then pending and will be continious
        PosControlFnc().loginShiftId(context, activeposShift);
        //--Open Shift with ---- [URL]/Posshift/s/posShiftId/O
        String posexec = PosControlFnc().getUpStatusShifturl(
            context, activeposShift.posshiftID.toString(), 'O');
        _responseExecShift.exPosShift(posexec);
      } else {
        showToast(context, 'This pos station has lock by other cashier  ');
        begCashDialog(context, "BEGCASH", activeposShift);
      }
    }
  }

  @override
  void onGetSalSumError(String error) {}

  @override
  void onGetSalSumSuccess(String ok) {}

  @override
  void onPosSigninError(String error) {
    normalDialog(
        context,
        'Can not connect to server now, please try again, \r\n=>' +
            error.toString());
    txtinputEntry('CLS');
  }

  @override
  void onPosSigninSuccess(List<PosShiftLogin> list) async {
    //--------If cannot login --will focus on txtUser again

    if (list != null) {
      //--check Authen with Password responsed here!

      if (list[0].cashierPassword == null) {
        normalDialog(
            context, 'Can not connect to server now, please try again,');
        txtinputEntry('CLS');
      } else {
        String orgPass = list[0].cashierPassword.toString().trim();
        if (orgPass == Password) {
          String curCashier = list[0].cashierId + ' - ' + list[0].cashierName;
          cashierlogin = curCashier.padRight(30).substring(0, 29);

          setCashier().then((data) {
            setState(() {});
          });

          gotoSalesPage(list[0]);
        } else {
          normalDialog(
              context, 'You entry wrong password, please try again,' + orgPass);
          txtinputEntry('CLS');
        }
      }
    }
  }

  Future setCashier() async {
    await PosControlFnc().updateCashier(context, cashierlogin);
  }

  @override
  void onPosShiftAddError(String error) {}

  @override
  void onPosShiftAddSuccess(String result) {
    PosControlFnc().startSalesItem(context);
    PosControlFnc().getDefaultScreen(context, _responseInput);
  }
}
