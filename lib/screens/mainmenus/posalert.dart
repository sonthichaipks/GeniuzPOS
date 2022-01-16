import 'package:com_csith_geniuzpos/screens/mainmenus/menucomponent.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:intl/intl.dart';

Widget posDateTime(BuildContext context, DateTime today) {
  DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
  return PosTimerBuilder.scheduled([today], builder: (context) {
    return Container(
      height: Palette.fullsalesheadcheight() * 0.5,
      width: Palette.stdbutton_width * 12,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.transparent),
          left: BorderSide(width: 1.0, color: Colors.transparent),
          right: BorderSide(width: 1.0, color: Colors.transparent),
          bottom: BorderSide(width: 1.0, color: Colors.transparent),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            PosTimerBuilder.periodic(Duration(seconds: 10),
                alignment: Duration.zero, builder: (context) {
              var now = DateTime.now();
              return Text(
                dateFormat.format(now),
                style: TextStyle(
                  fontFamily: 'Leelawadee',
                  fontWeight: FontWeight.w200,
                  fontSize: 18,
                  height: 1,
                  letterSpacing: 0.1,
                  color: Colors.black,
                ),
              );
            })
          ],
        ),
      ),
    );
  });
}

Widget posDateTimeLabel() {
  DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
  final now = DateTime.now();
  return Container(
    height: Palette.fullsalesheadcheight() * 0.5,
    width: Palette.stdbutton_width * 12,
    decoration: BoxDecoration(
      color: Colors.transparent,
      border: Border(
        top: BorderSide(width: 1.0, color: Colors.transparent),
        left: BorderSide(width: 1.0, color: Colors.transparent),
        right: BorderSide(width: 1.0, color: Colors.transparent),
        bottom: BorderSide(width: 1.0, color: Colors.transparent),
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            dateFormat.format(now),
            style: TextStyle(
              fontFamily: 'Leelawadee',
              fontWeight: FontWeight.w200,
              fontSize: 18,
              height: 1,
              letterSpacing: 0.1,
              color: Colors.black,
            ),
          )
        ],
      ),
    ),
  );
}
// Widget posInterface(BuildContext context, DateTime today,
//     TextEditingController txtFocus, FocusNode focusnode) {
//   DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
//   return PosTimerBuilder.scheduled([today], builder: (context) {
//     return Container(
//       height: Palette.fullsalesheadcheight() * 0.5,
//       width: Palette.stdbutton_width * 12,
//       decoration: BoxDecoration(
//         color: Colors.transparent,
//         border: Border(
//           top: BorderSide(width: 1.0, color: Colors.transparent),
//           left: BorderSide(width: 1.0, color: Colors.transparent),
//           right: BorderSide(width: 1.0, color: Colors.transparent),
//           bottom: BorderSide(width: 1.0, color: Colors.transparent),
//         ),
//       ),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             PosTimerBuilder.periodic(Duration(seconds: 1),
//                 alignment: Duration.zero, builder: (context) {
//               var now = DateTime.now();
//               return Text(
//                 dateFormat.format(now),
//                 style: TextStyle(
//                   fontFamily: 'Leelawadee',
//                   fontWeight: FontWeight.w200,
//                   fontSize: 9,
//                   height: 1,
//                   letterSpacing: 0.1,
//                   color: Colors.black,
//                 ),
//               );
//             })
//           ],
//         ),
//       ),
//     );
//   });
// }
