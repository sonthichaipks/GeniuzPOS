import 'dart:io' show File, Platform;
import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class OS {
  OS();
  static String deviceinfo() {
    if (kIsWeb) {
      return "Web";
    } else {
      if (Platform.isAndroid) {
        return "Android";
      } else if (Platform.isIOS) {
        return "IOS";
      } else if (Platform.isFuchsia) {
        return "Fuchsia";
      } else if (Platform.isLinux) {
        return "Linux";
      } else if (Platform.isMacOS) {
        return "MacOS";
      } else if (Platform.isWindows) {
        return "Windows";
      } else {
        return "";
      }
    }
  }

  Future<String> localPath() async {
    String _path = '';
    final directory = await getApplicationDocumentsDirectory();
    if (OS.deviceinfo() == 'Windows') {
      _path = MyConfig().winData;
    } else if (OS.deviceinfo() == 'Web') {
      _path = directory.path;
    } else {
      _path = directory.path;
    }

    return _path;
  }

  Future<File> localPOSCYCLEFile() async {
    final path = await localPath();
    // print('path ${path}');
    String poscycle = MyConfig()
            .poscycleName
            .replaceAll('YYMMDD', DateFormat('yyMMdd').format(DateTime.now())) +
        '.hive';
    return File('$path\\$poscycle');
  }

  Future<int> deletePosCycleFile() async {
    try {
      final file = await localPOSCYCLEFile();

      await file.delete();
      return 1;
    } catch (e) {
      return 0;
    }
  }
}
