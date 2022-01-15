import 'package:intl/intl.dart';

final cspno = new NumberFormat("##0]", "en_US");
final cno = new NumberFormat("##0", "en_US");
final rno = new NumberFormat("##0.", "en_US");
final pCcy = new NumberFormat("#0%", "en_US");
final oCcy = new NumberFormat("#,##0.00", "en_US");
final c4rnd = new NumberFormat("###0.0000", "en_US");
final c2rnd = new NumberFormat("###0.00", "en_US");
final df = new NumberFormat("##0.00", "en_US");
final DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
