import 'package:com_csith_geniuzpos/services/request/salesitem_request.dart';
import 'package:hive/hive.dart';

abstract class HiveInitCallBack {
  void onCallHiveInitSuccess(String result);
  void onCallHiveInitError(String error);
}

class HiveInitCallResponse {
  HiveInitCallBack _callBackGet;
  SalesItemRequest hiveInitreq = new SalesItemRequest();
  HiveInitCallResponse(this._callBackGet);

  doInitial() async {
    hiveInitreq
        .initDataFiles()
        .then((result) => _callBackGet.onCallHiveInitSuccess(result))
        .catchError(
            (onError) => _callBackGet.onCallHiveInitError(onError.toString()));
  }
}

abstract class HiveCloseCallBack {
  void onCallHiveCloseSuccess(String result);
  void onCallHiveCloseError(String error);
}

class HiveCloseCallResponse {
  HiveCloseCallBack _callBackGet;
  SalesItemRequest hiveClosereq = new SalesItemRequest();
  HiveCloseCallResponse(this._callBackGet);

  doHiveClose(List<Box> boxList) async {
    hiveClosereq
        .closeDataFiles(boxList)
        .then((result) => _callBackGet.onCallHiveCloseSuccess(result))
        .catchError(
            (onError) => _callBackGet.onCallHiveCloseError(onError.toString()));
  }
}

// abstract class TableAddCallBack {
//   void onCallTableAddSuccess(String result);
//   void onCallTableAddError(String error);
// }

// class TableAddCallResponse {
//   TableAddCallBack _callBackGet;
//   SalesItemRequest tableAddreq = new SalesItemRequest();
//   TableAddCallResponse(this._callBackGet);

//   doAddTable(BuildContext context, String zoneno, String tableno, String info,
//       double _x, double _y) async {
//     tableAddreq
//         .addTable(context, zoneno, tableno, info, _x, _y)
//         .then((result) => _callBackGet.onCallTableAddSuccess(result))
//         .catchError(
//             (onError) => _callBackGet.onCallTableAddError(onError.toString()));
//   }
// }

// abstract class TableUpdateCallBack {
//   void onCallTableUpdateSuccess(String result);
//   void onCallTableUpdateError(String error);
// }

// class TableUpdateCallResponse {
//   TableUpdateCallBack _callBackGet;
//   SalesItemRequest tableUpdatereq = new SalesItemRequest();
//   TableUpdateCallResponse(this._callBackGet);

//   doUpdateTable(BuildContext context, String zoneno, String tableno,
//       String info, double _x, double _y) async {
//     tableUpdatereq
//         .updateTable(context, zoneno, tableno, info, _x, _y)
//         .then((result) => _callBackGet.onCallTableUpdateSuccess(result))
//         .catchError((onError) =>
//             _callBackGet.onCallTableUpdateError(onError.toString()));
//   }
// }

// abstract class SalesItemAddCallBack {
//   void onCallSalesItemAddSuccess(String result);
//   void onCallSalesItemAddError(String error);
// }

// class SalesItemAddCallResponse {
//   SalesItemAddCallBack _callBackGet;
//   SalesItemRequest salesitemAddreq = new SalesItemRequest();
//   SalesItemAddCallResponse(this._callBackGet);

//   doSalesItemAdd(BuildContext context, SalesItems sales) async {
//     salesitemAddreq
//         .salesitemAdd(context, sales)
//         .then((result) => _callBackGet.onCallSalesItemAddSuccess(result))
//         .catchError((onError) =>
//             _callBackGet.onCallSalesItemAddError(onError.toString()));
//   }
// }
