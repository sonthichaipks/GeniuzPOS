import 'dart:async';

import 'package:com_csith_geniuzpos/models/persons/psmember.dart';
import 'package:com_csith_geniuzpos/models/persons/salman.dart';

import '../wsHelper.dart';

class PsMemberCtr {
  //----------Member--------------
  Future<List<PsMember>> getMemberListWS(String memberid, String url) async {
    List<PsMember> list;
    var data = await wsList(url);
    if (data != null) {
      list = psMemberFromJson(data);
    }

    return list;
  }

  Future<PsMember> getResultSearchToMemberForm(PsMember psMember) async {
    if (psMember != null) {
      return psMember;
    }

    return null;
  }

  //----------Sales man--------------
  Future<List<Salesman>> getSalmanListWS(String memberid, String url) async {
    List<Salesman> list;
    var data = await wsList(url);
    if (data != null) {
      list = salesmanFromJson(data);
    }

    return list;
  }

  Future<Salesman> getResultSearchToSalmanForm(Salesman psMember) async {
    if (psMember != null) {
      return psMember;
    }

    return null;
  }

  //----------......--------------
}
