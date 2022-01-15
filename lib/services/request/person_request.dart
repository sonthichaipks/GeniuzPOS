import 'dart:async';

import 'package:com_csith_geniuzpos/data/persons/personsctrl.dart';
import 'package:com_csith_geniuzpos/models/persons/psmember.dart';
import 'package:com_csith_geniuzpos/models/persons/salman.dart';

class SearchPersonRequest {
  PsMemberCtr con = new PsMemberCtr();

  Future<List<PsMember>> getMemberListWS(String plu, String url) {
    var result = con.getMemberListWS(plu, url);
    return result;
  }

  Future<PsMember> getResultSearchToMemberForm(PsMember psMemeber) {
    return con.getResultSearchToMemberForm(psMemeber);
  }

  Future<List<Salesman>> getSalmanListWS(String plu, String url) {
    var result = con.getSalmanListWS(plu, url);
    return result;
  }

  Future<Salesman> getResultSearchToSalmanForm(Salesman salesman) {
    return con.getResultSearchToSalmanForm(salesman);
  }
}
