import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:com_csith_geniuzpos/models/buttons/hive_tableusages.dart';
import 'package:com_csith_geniuzpos/screens/billdischgs/billdischg_pages.dart';
import 'package:com_csith_geniuzpos/screens/cardscoupons/ccp_is_ok.dart';
import 'package:com_csith_geniuzpos/screens/cardscoupons/components/ccp_searchresult.dart';
import 'package:com_csith_geniuzpos/screens/panel_config/pnlConfig_pages.dart';

import 'package:com_csith_geniuzpos/screens/receipts/receipts_pages.dart';

import 'package:com_csith_geniuzpos/screens/searchmember/member_info_ok.dart';
import 'package:com_csith_geniuzpos/screens/searchplu/plu_info_ok.dart';
import 'package:com_csith_geniuzpos/screens/searchsalman/salman_info_ok.dart';
import 'package:com_csith_geniuzpos/services/response/person_reponse.dart';
import 'package:com_csith_geniuzpos/services/response/posdata_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/models/buttons/buttuns.dart';
import 'package:com_csith_geniuzpos/models/buttons/padbuttons.dart';
import 'package:com_csith_geniuzpos/models/buttons/tablemaster.dart';
import 'package:com_csith_geniuzpos/screens/fullsales/full_salespage.dart';
import 'package:com_csith_geniuzpos/screens/home_screen.dart';
import 'package:com_csith_geniuzpos/screens/nav_screen.dart';
import 'package:com_csith_geniuzpos/screens/resturants/rest_salespage.dart';
import 'package:com_csith_geniuzpos/screens/resturants/rest_seatzone.dart';
import 'package:com_csith_geniuzpos/screens/retails/retail_salespage.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';

class FncItems {
  FncItems();
  Future<void> poscenter(BuildContext context,
      PosFncCallResponse _responseInput, PosButton posbtn) async {
    switch (posbtn.cmdCode) {
      case "fncResturant":
        {
          //    Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => ResturantSalesPages());
          Navigator.push(context, route);
        }
        break;
      case "fncRetail":
        {
          //   Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => RetailSalesPages());
          Navigator.push(context, route);
        }
        break;

      case "fncFullSales":
        {
          //     Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => FullSalesPages());
          Navigator.push(context, route);
        }
        break;

      case "fncFullSales":
        {
          //   Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => FullSalesPages());
          Navigator.push(context, route);
        }
        break;
      case "fncTempExit":
        {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => HomeScreen(0));
          Navigator.push(context, route);
        }
        break;
      case "txtInput":
        {
          _responseInput.doEntry(posbtn.kybCode, 0, 0);
        }
        break;
      case "FuncInput":
        {
          _responseInput.doEntry(posbtn.kybCode, 1, 1);
        }
        break;

      case "grpInput":
        {
          _responseInput.doEntry(posbtn.kybCode, 2, 2);
        }
        break;
      default:
        showMyDialog(context, posbtn);
        break;
    }
  }

  Future<void> padcenter(
      BuildContext context,
      PosFncCallResponse _responseInput,
      PadButton posbtn,
      Function doact) async {
    switch (posbtn.cmdCode) {
      case "fncResturant":
        {
          //    Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => ResturantSalesPages());
          Navigator.push(context, route);
        }
        break;
      case "fncRetail":
        {
          //   Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => RetailSalesPages());
          Navigator.push(context, route);
        }
        break;

      case "fncRestuarant":
        {
          //  Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => RetailSalesPages());
          Navigator.push(context, route);
        }
        break;

      case "fncSeatZone":
        {
          //  Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => ResturantSeatPages());
          Navigator.push(context, route);
        }
        break;
      case "fncFullSales":
        {
          //   Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => FullSalesPages());
          Navigator.push(context, route);
        }
        break;
      case "fncTempExit":
        {
          _responseInput.doEntry(posbtn.kybCode, 2, 1);
          //---must to update open shift from 'O' - openning to 'P'- pending
          // MaterialPageRoute route =
          //     MaterialPageRoute(builder: (value) => NavScreen(screenmenu: 0));
          // Navigator.push(context, route);
        }
        break;
      case "txtInput":
        {
          _responseInput.doEntry(posbtn.kybCode, 0, 0);
        }
        break;
      case "FuncInput":
        {
          _responseInput.doEntry(posbtn.kybCode, 1, 1);
        }
        break;
      case "FuncNavigator":
        {
//showPopupTask(context, "BILLRECEIPT");
          showPopupTask(context, posbtn.label, doact);
        }
        break;
      case "signOut":
        {
          _responseInput.doEntry(posbtn.kybCode, 2, 1);
          //---must to update open shift from 'O' - openning to 'C'- Closed
          // Navigator.pop(context);
          // MaterialPageRoute route =
          //     MaterialPageRoute(builder: (value) => HomeScreen(0));
          // Navigator.push(context, route);
        }
        break;
      case "grpInput":
        {
          _responseInput.doEntry(posbtn.kybCode, 2, 2);
        }
        break;
      default:
        break;
    }
  }

  Future<void> dummy() {
    return null;
  }

  Future<void> menucenter(BuildContext context,
      PosFncCallResponse _responseInput, TableAndPostions posbtn) async {
    switch (posbtn.cmdCode) {
      case "fncResturant":
        {
          //  Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => ResturantSalesPages());
          Navigator.push(context, route);
        }
        break;
      case "fncRetail":
        {
          //   Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => RetailSalesPages());
          Navigator.push(context, route);
        }
        break;

      case "fncRetailConfig":
        {
          Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => RetailConfPages());
          Navigator.push(context, route);
        }
        break;

      case "fncSeatZone":
        {
          //   Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => ResturantSeatPages());
          Navigator.push(context, route);
        }
        break;
      case "fncFullSales":
        {
          //   Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => FullSalesPages());
          Navigator.push(context, route);
        }
        break;
      case "mnuExit":
        {
          appWindow.close();
        }
        break;
      case "mnuAction":
        {
          _responseInput.doEntry(posbtn.kybCode, 0, 0);
        }
        break;
      case "txtInput":
        {
          _responseInput.doEntry(posbtn.kybCode, 0, 0);
        }
        break;
      case "backMain":
        {
          //    Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => HomeScreen(0));
          Navigator.push(context, route);
        }
        break;
      case "closeMe":
        {
          Navigator.pop(context);
        }
        break;
      case "custService":
        {
          //    Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => HomeScreen(1));
          Navigator.push(context, route);
        }
        break;
      case "FuncInput":
        {
          _responseInput.doEntry(posbtn.kybCode, 1, 1);
        }
        break;
      case "signOut":
        {
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => HomeScreen(0));
          Navigator.push(context, route);
        }
        break;
      case "grpInput":
        {
          _responseInput.doEntry(posbtn.kybCode, 2, 2);
        }
        break;
      default:
        // _showMyDialog(context, posbtn);
        break;
    }
  }

  Future<void> tablecenter(BuildContext context,
      PosFncCallResponse _responseInput, TableUsage posbtn) async {
    //----tableinfo
    String comms, zoneno, tableno;
    comms = '';
    zoneno = '';
    tableno = '';
    if (posbtn.tablekey != "null") {
      var f = posbtn.tableinfo.split(']');
      if (f.length > 0) {
        comms = f[0];
      }
      //----tablekey
      var t = posbtn.tablekey.split(']');
      if (t.length > 0) {
        zoneno = t[0];
      }
      if (t.length > 1) {
        tableno = t[1];
      }
    }
    switch (comms) {
      case "fncResturant":
        {
          //     Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => ResturantSalesPages());
          Navigator.push(context, route);
        }
        break;
      case "fncRetail":
        {
          //     Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => RetailSalesPages());
          Navigator.push(context, route);
        }
        break;

      case "fncRestuarant":
        {
          Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => RetailSalesPages());
          Navigator.push(context, route);
        }
        break;

      case "fncSeatZone":
        {
          Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => ResturantSeatPages());
          Navigator.push(context, route);
        }
        break;
      case "fncFullSales":
        {
          //    Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => FullSalesPages());
          Navigator.push(context, route);
        }
        break;
      case "mnuExit":
        {
          Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => HomeScreen(0));
          Navigator.push(context, route);
        }
        break;
      case "txtInput":
        {
          _responseInput.doEntry(tableno, 0, 0);
        }
        break;
      case "FuncInput":
        {
          _responseInput.doEntry(tableno, 1, 1);
        }
        break;
      case "signOut":
        {
          //   Navigator.pop(context);
          MaterialPageRoute route =
              MaterialPageRoute(builder: (value) => HomeScreen(0));
          Navigator.push(context, route);
        }
        break;
      case "grpInput":
        {
          _responseInput.doEntry(tableno, 2, 2);
        }
        break;
      default:
        // _showMyDialog(context, posbtn);
        break;
    }
  }

  String posinput(String btext, String keyin) {
    return btext + keyin;
  }

  int posFunction(
      BuildContext context,
      PosInput _posinput,
      PosButton posGroup,
      PosFncVoidAllCallResponse _responseVoidAll,
      PosFncAddFreeCallResponse _responseFree,
      GetSearchMemberResponse _responseMember,
      String shift,
      String keyCode,
      Function doact) {
    if (shift == "1") {
      switch (keyCode) {
        //button pad
        case "F12":
          {
            showPopReceipt(context, doact);
          }
          break;
        case 'Shift F3':
          {
            //showToast(context, keyCode);
            //showPopSearchSalesMan(context, '');
            //CashinoutPages(goSalesPages, activeposShift),
          }
          break;
        case "F2":
          {
            //searchPLU(context, "SEARCHPLU");
          } //
          break;
        case "F3":
          {
            showPopSearchSalesMan(context, '');
          }
          break;
        case "F4":
          {
            showPopSearchMember(context, _responseMember, '');
          }
          break;
        case "F11":
          {
            showPopBillDiscChg(context);
          }
          break;
        case "F4V":
          {
            _responseVoidAll.doVoidAll(context);
          }
          break;
        case "FREE":
          {
            _posinput.txtQty.text = "";
            _posinput.txtPlu.text = "";
            _responseFree.doAddFree(context);
          }
          break;
        default:
          break;
      }
    } else if (shift == "2") {
      // group panel
      if (keyCode != "") {
        posGroup = stdButtuon4.firstWhere((e) => e.kybCode == keyCode);
        if (posGroup != null) {
          //setState(() {});
          return 1; //must setState()  to refresh screen
        }
      }
    }
    return 0; //---noithing to do.
  }

  bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  Future<void> showMyDialog(BuildContext context, PosButton posbtn) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                (posbtn.imageUrl == '')
                    ? Text('')
                    : Image.network(
                        posbtn.imageUrl,
                        height: Palette.stdbutton_height,
                        width: Palette.stdbutton_width,
                      ),
                Text(posbtn.label),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                  (posbtn.cmdCode == '') ? posbtn.kybCode : posbtn.cmdCode),
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

  Future<void> showTableDialog(
      BuildContext context, double x, double y, double _x, double _y) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('New position'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("[" +
                  x.toString() +
                  ":" +
                  y.toString() +
                  "] => \r\n" +
                  "[" +
                  _x.toString() +
                  ":" +
                  _y.toString() +
                  "]"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  Future<void> searchPLU(
      BuildContext context,
      String value,
      PosFncAddNewCallResponse responseAddNew,
      TextEditingController plu,
      TextEditingController qty,
      GetPluResponse responsePlu,
      double sellPriceNo) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetAnimationDuration: const Duration(milliseconds: 100),
          child: Stack(
            children: [
              Container(
                // use container to change width and height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.white, spreadRadius: 3),
                  ],
                ),
                height: Palette.stdbutton_height * 6.6,
                width: Palette.stdbutton_width * 7.6,
                child: PluInfoOkPages(
                    value, responseAddNew, plu, qty, responsePlu, sellPriceNo),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showPopupTask(
      BuildContext context, String mnuName, Function doact) async {
    switch (mnuName) {
      case "BILLRECEIPT": //RECEIPTS
        {
          PosInput().savePOSTrans(context, 20);
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                insetAnimationDuration: const Duration(milliseconds: 100),
                child: Stack(
                  children: [
                    Container(
                      // use container to change width and height
                      height: Palette.stdbutton_height * 9.6,
                      width: Palette.stdbutton_width * 13.6,
                      child: ReceiptsPages((doact)),
                    ),
                  ],
                ),
              );
            },
          );
        }
        break;
      case "BILLCHGDISC": //RECEIPTS
        {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                insetAnimationDuration: const Duration(milliseconds: 100),
                child: Stack(
                  children: [
                    Container(
                      // use container to change width and height
                      height: Palette.stdbutton_height * 9.6,
                      width: Palette.stdbutton_width * 14.6,
                      child: BilldischgPages(),
                    ),
                  ],
                ),
              );
            },
          );
        }
        break;
      case "SALESMAN":
        {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                insetAnimationDuration: const Duration(milliseconds: 100),
                child: Stack(
                  children: [
                    Container(
                      // use container to change width and height
                      height: Palette.stdbutton_height * 4.9,
                      width: Palette.stdbutton_width * 7.3,
                      child: SalmanInfoOkPages(),
                    ),
                  ],
                ),
              );
            },
          );
        }
        break;
      case "PasswordReset":
        {
          showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                    title: Text(mnuName),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'OK',
                                style: TextStyle(color: Colors.red),
                              ))
                        ],
                      )
                    ],
                  ));
        }
        break;

      default:
        normalDialog(context, mnuName);
        break;
    }
  }

  Future<void> showPopReceipt(BuildContext context, Function doact) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () => Future.value(false),
          child: Container(
              height: Palette.stdbutton_height * 9.6,
              width: Palette.stdbutton_width * 14.6,
              child: Dialog(
                backgroundColor: Colors.white,
                insetAnimationDuration: const Duration(milliseconds: 100),
                child: Stack(
                  children: [
                    Container(
                      // height: double.infinity,
                      // width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      height: Palette.stdbutton_height * 9.6,
                      width: Palette.stdbutton_width * 14.6,
                      // height: Palette.stdbutton_height * 9.6,
                      // width: Palette.stdbutton_width * 13.6,
                      child: Center(child: ReceiptsPages(doact)),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  Future<void> showPopBillDiscChg(BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetAnimationDuration: const Duration(milliseconds: 100),
          child: Stack(
            children: [
              Container(
                // use container to change width and height
                height: Palette.stdbutton_height * 9.6,
                width: Palette.stdbutton_width * 14.6,
                child: BilldischgPages(),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showPopSearchSalesMan(
      BuildContext context, String values) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetAnimationDuration: const Duration(milliseconds: 100),
          child: Stack(
            children: [
              Container(
                // use container to change width and height
                height: Palette.stdbutton_height * 4.9,
                width: Palette.stdbutton_width * 7.3,
                child: SalmanInfoOkPages(),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showPopSearchCCP(
      BuildContext context,
      String values,
      PosFncGetAitemCallResponse responseGetItem,
      TextEditingController entBtnCmd) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetAnimationDuration: const Duration(milliseconds: 100),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(color: Colors.white, spreadRadius: 3),
                  ],
                ),
                height: Palette.stdbutton_height * 4.9,
                width: Palette.stdbutton_width * 4.3,
                child: CcpIsOkPages(values, responseGetItem, entBtnCmd),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showPopSearchMember(BuildContext context,
      GetSearchMemberResponse _responseMember, String values) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetAnimationDuration: const Duration(milliseconds: 100),
          child: Stack(
            children: [
              Container(
                // use container to change width and height
                height: Palette.stdbutton_height * 11,
                width: Palette.stdbutton_width * 13.6,
                child: MemberInfoOkPages(_responseMember, values),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showPopResetPassword(
      BuildContext context, String mnuName, String values) async {
    showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: Text(mnuName),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'OK',
                          style: TextStyle(color: Colors.red),
                        ))
                  ],
                )
              ],
            ));
  }
}
