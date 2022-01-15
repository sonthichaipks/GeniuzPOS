import 'dart:io';

import 'package:com_csith_geniuzpos/models/oldsobjs/csisysvar.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';

class WinHelper {
  static final WinHelper _instance = new WinHelper.internal();
  factory WinHelper() => _instance;

  WinHelper.internal();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }
  /*-----host server-----  */

  Future<File> get _localHost async {
    final path = await _localPath;
    return File('$path/host.var');
  }

  Future<int> writeHostData(CsiSysvar hostdata) async {
    final file = await _localHost;
    String host = hostdata.detail;
    // Write the file
    file.writeAsString('$host', mode: FileMode.write);
    return 1;
  }

  Future<CsiSysvar> readHost() async {
    try {
      final file = await _localHost;
      CsiSysvar host = new CsiSysvar();
      host.detail = await file.readAsString();
      // Read the file
      //final contents = await file.readAsString();
      return host;
    } catch (e) {
      // If encountering an error, return 0
      return new CsiSysvar();
    }
  }

  //---------Login----------
  Future<File> get _localLogin async {
    final path = await _localPath;
    return File('$path/login.var');
  }

  Future<File> writeLoginData(CsiSysvar login) async {
    final file = await _localLogin;
    String username = login.detail;
    // Write the file
    return file.writeAsString('$username.', mode: FileMode.write);
  }

  Future<CsiSysvar> readLogin() async {
    try {
      final file = await _localLogin;
      CsiSysvar login = new CsiSysvar();
      login.detail = await file.readAsString();
      // Read the file
      // final contents = await file.readAsString();
      return login;
    } catch (e) {
      // If encountering an error, return 0
      return new CsiSysvar();
    }
  }
}
