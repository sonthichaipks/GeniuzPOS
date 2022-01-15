import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/data/sampledata.dart';
import 'package:com_csith_geniuzpos/models/ccps/ccp.dart';
import 'package:com_csith_geniuzpos/models/posmodels/paymentInfo.dart';
import 'package:com_csith_geniuzpos/services/response/ccp_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:intl/intl.dart';

class CCPSearchList extends StatefulWidget {
  final TextEditingController txt;
  // final PsMember getPsMember;
  final GetSearchCCPResponse responseCCP;
  final String ccpType;
  final List<PaymentInfo> paymentinfo;
  const CCPSearchList(
      {Key key, this.txt, this.responseCCP, this.ccpType, this.paymentinfo})
      : super(key: key);
  @override
  _CCPSearchList createState() => _CCPSearchList();
}

class _CCPSearchList extends State<CCPSearchList> {
  @override
  void dispose() {
    super.dispose();
  }

  TextEditingController txtGet;
  GetSearchCCPResponse _responseCCP;
  @override
  Widget build(BuildContext context) {
    txtGet = widget.txt;

    // context.watch<SalesItemHiveModel>().getItem();
    // return Consumer<SalesItemHiveModel>(builder: (context, model, child) {
    return Row(children: [
      GestureDetector(
        child: Container(
          height: Palette.stdbutton_height * 4.6,
          width: Palette.stdbutton_width * 4.6,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.grey),
                left: BorderSide(width: 1.0, color: Colors.grey),
                right: BorderSide(width: 1.0, color: Colors.grey),
                bottom: BorderSide(width: 1.0, color: Colors.grey),
              )),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.white),
              child: Container(
                child: DataTable(
                  dataRowHeight: Palette.stdbutton_height * 0.8,
                  headingRowHeight: 0,
                  columnSpacing: 0,
                  horizontalMargin: 1,
                  showCheckboxColumn: false,
                  columns: PosInput().kTableColumnSearchCCPList,
                  rows: searchPayment(widget.ccpType),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
    // });
  }

  List<DataRow> searchPayment(String ccType) {
    return List<DataRow>.generate(widget.paymentinfo.length, (index) {
      final PaymentInfo paymentInfo = widget.paymentinfo[index];
      CardsCoupon cardsCoupon = CardsCoupon(
        ccpid: paymentInfo.code,
        ccpName: paymentInfo.detail,
        ccpType: paymentInfo.paytype,
        ccpLogo: 'assets' + '/icons/cash-voucher.jpg',
        ccpAmount: paymentInfo.value,
        expireDate: DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()),
        ccpNumber: paymentInfo.valuetype.toString(),
        ccpApproveCode: '',
      );
      return getRows(index, cardsCoupon, paymentInfo, widget.ccpType);
    });
  }

  DataRow getRows(int index, _searchCCPlist, paymentInfo, String paytype) {
    int checkSelect = 0;
    Color color;
    int selectedIndex = -1;
    var dataRow = DataRow.byIndex(
        index: index,
        color: MaterialStateColor.resolveWith(
          (states) {
            if (color == null) {
              if ((index.isEven)) {
                return Palette.stdbutton_theme_0_1;
              } else {
                return Colors.white;
              }
            } else {
              return color;
            }
          },
        ),
        onSelectChanged: (bool value) {
          if (value) {
            if (_searchCCPlist != null) {
              checkSelect += 1;
              if (checkSelect == 2) {
                Navigator.pop(context);
              } else {
                //---send payment type to receipt main page to run process by type
                selectArows(_searchCCPlist, paymentInfo, paytype);
                color = Colors.lightBlueAccent;
              }
            }
          }
        },
        cells: <DataCell>[
          DataCell(
            Container(
              // height: double.infinity,
              width: 58,
              alignment: Alignment.bottomLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.grey, spreadRadius: 1),
                ],
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(_searchCCPlist.ccpLogo),
                ),
              ),
            ),
          ),
          DataCell(
            Container(
              //  height: double.infinity,
              width: 268,
              decoration: BoxDecoration(
                  border: Border(
                top: BorderSide(width: 1.0, color: Colors.transparent),
                left: BorderSide(width: 1.0, color: Colors.transparent),
                right: BorderSide(width: 1.0, color: Colors.transparent),
                bottom: BorderSide(width: 1.0, color: Colors.transparent),
              )),
              child: Text(
                _searchCCPlist.ccpName,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Tahoma',
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  letterSpacing: 0.1,
                ),
              ),
            ),
          ),
        ]);
    return dataRow;
  }

  void selectArows(
      CardsCoupon cardsCoupon, PaymentInfo paymentInfo, String paytype) async {
    //--will get some info form paymentinfo ...
    //---send payment type to receipt main page to run process by type
    await widget.responseCCP.getResultSearchToCCPForm(cardsCoupon);
  }

  // List<DataRow> searchCCPdemo(String ccType) {
  //   if (ccType == '1') {
  //     return List<DataRow>.generate(sampleCCP1.length, (index) {
  //       final CardsCoupon _searchCCPlist = sampleCCP1[index];
  //       return getRow(index, _searchCCPlist);
  //     });
  //   } else if (ccType == '2') {
  //     return List<DataRow>.generate(sampleCCP2.length, (index) {
  //       final CardsCoupon _searchCCPlist = sampleCCP2[index];
  //       return getRow(index, _searchCCPlist);
  //     });
  //   } else if (ccType == '3') {
  //     return List<DataRow>.generate(sampleCCP3.length, (index) {
  //       final CardsCoupon _searchCCPlist = sampleCCP3[index];
  //       return getRow(index, _searchCCPlist);
  //     });
  //   } else if (ccType == '4') {
  //     return List<DataRow>.generate(sampleCCP4.length, (index) {
  //       final CardsCoupon _searchCCPlist = sampleCCP4[index];
  //       return getRow(index, _searchCCPlist);
  //     });
  //   } else if (ccType == '5') {
  //     return List<DataRow>.generate(sampleCCP5.length, (index) {
  //       final CardsCoupon _searchCCPlist = sampleCCP5[index];
  //       return getRow(index, _searchCCPlist);
  //     });
  //   } else if (ccType == '6') {
  //     return List<DataRow>.generate(sampleCCP6.length, (index) {
  //       final CardsCoupon _searchCCPlist = sampleCCP6[index];
  //       return getRow(index, _searchCCPlist);
  //     });
  //   } else if (ccType == '7') {
  //     return List<DataRow>.generate(sampleCCP7.length, (index) {
  //       final CardsCoupon _searchCCPlist = sampleCCP7[index];
  //       return getRow(index, _searchCCPlist);
  //     });
  //   } else {
  //     return List<DataRow>.generate(sampleCCP1.length, (index) {
  //       final CardsCoupon _searchCCPlist = sampleCCP1[index];
  //       return getRow(index, _searchCCPlist);
  //     });
  //   }
  // }

  // DataRow getRow(int index, _searchCCPlist) {
  //   int checkSelect = 0;
  //   Color color;
  //   int selectedIndex = -1;
  //   var dataRow = DataRow.byIndex(
  //       index: index,
  //       color: MaterialStateColor.resolveWith(
  //         (states) {
  //           if (color == null) {
  //             if ((index.isEven)) {
  //               return Palette.stdbutton_theme_0_1;
  //             } else {
  //               return Colors.white;
  //             }
  //           } else {
  //             return color;
  //           }
  //         },
  //       ),
  //       onSelectChanged: (bool value) {
  //         if (value) {
  //           if (_searchCCPlist != null) {
  //             checkSelect += 1;
  //             if (checkSelect == 2) {
  //               Navigator.pop(context);
  //             } else {
  //               selectArow(_searchCCPlist);
  //               color = Colors.lightBlueAccent;
  //             }
  //           }
  //         }
  //       },
  //       cells: <DataCell>[
  //         DataCell(
  //           Container(
  //             // height: double.infinity,
  //             width: 58,
  //             alignment: Alignment.bottomLeft,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(10),
  //               color: Colors.white,
  //               boxShadow: [
  //                 BoxShadow(color: Colors.grey, spreadRadius: 1),
  //               ],
  //               image: DecorationImage(
  //                 fit: BoxFit.contain,
  //                 image: NetworkImage(_searchCCPlist.ccpLogo),
  //               ),
  //             ),
  //           ),
  //         ),
  //         DataCell(
  //           Container(
  //             //  height: double.infinity,
  //             width: 268,
  //             decoration: BoxDecoration(
  //                 border: Border(
  //               top: BorderSide(width: 1.0, color: Colors.transparent),
  //               left: BorderSide(width: 1.0, color: Colors.transparent),
  //               right: BorderSide(width: 1.0, color: Colors.transparent),
  //               bottom: BorderSide(width: 1.0, color: Colors.transparent),
  //             )),
  //             child: Text(
  //               _searchCCPlist.ccpName,
  //               textAlign: TextAlign.left,
  //               style: const TextStyle(
  //                 color: Colors.black,
  //                 fontFamily: 'Tahoma',
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 14.0,
  //                 letterSpacing: 0.1,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ]);
  //   return dataRow;
  // }

  // void selectArow(CardsCoupon cardsCoupon) async {
  //   await widget.responseCCP.getResultSearchToCCPForm(cardsCoupon);
  // }
}
