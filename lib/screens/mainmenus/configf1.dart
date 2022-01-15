part of 'posregister.dart';

Widget configf1() {
  return Builder(builder: (BuildContext context) {
    retreiveConfig();
    return Row(children: [
      Container(
        height: Palette.stdbutton_width * 0.55,
        width: Palette.stdbutton_width * 0.55,
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            top: BorderSide(width: 1.0, color: Colors.transparent),
            left: BorderSide(width: 1.0, color: Colors.transparent),
            right: BorderSide(width: 1.0, color: Colors.transparent),
            bottom: BorderSide(width: 1.0, color: Colors.transparent),
          ),
        ),
        child: Palette().showConfigf1(context),
      )
    ]);
  });
}

void retreiveConfig() {
  if (configModel.poscontrolList.length == 0) {
    PosCtrl poscontrol;
    for (poscontrol in posCtrlList)
      PosControlFnc().getPocControlFmPosCtrl(poscontrol);
  } else {
    int dataLen = configModel.poscontrolList.length;
    int confLen = posCtrlList.length;
    if (confLen - dataLen > 1) {
      PosControlFnc().addGapDataWithConf(configModel, dataLen, confLen);
    }
  }
}

// void retreiveAccum() {
//   if (configModel.poscontrolList.length == 0) {
//     PosCtrl poscontrol;
//     for (poscontrol in posCtrlList)
//       PosControlFnc().getPocControlFmPosCtrl(poscontrol);
//   } else {
//     int dataLen = configModel.poscontrolList.length;
//     int confLen = posCtrlList.length;
//     if (confLen - dataLen > 1) {
//       PosControlFnc().addGapDataWithConf(configModel, dataLen, confLen);
//     }
//   }
// }
