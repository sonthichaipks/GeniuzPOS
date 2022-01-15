import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/pospanelctrl.dart';
import 'package:com_csith_geniuzpos/models/buttons/buttuns.dart';
import 'package:com_csith_geniuzpos/services/response/panel_response.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/curve_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PnlConfigMntPages extends StatefulWidget {
  final int mntMode;
  final PosFncCallResponse responseInput;
  final AddPanelResponse responseAddPanel;
  final PosButtonX bosbtnX;
  final touchCharacter touchC;
  final representCharacter representC;
  final String touchPanelId;
  final int groupPanelId;
  final String btnlabel;
  final String btnCode;
  final String imgUrl;
  final Function actdo;
  //--use Item.id/Group.Id for maintain mode :
  //--by bosbtnX.id is null => add, else =>update!

  const PnlConfigMntPages(
      {Key key,
      this.mntMode,
      this.responseInput,
      this.responseAddPanel,
      //  this.responseItemPnlList,
      this.bosbtnX,
      this.touchC,
      this.representC,
      this.touchPanelId,
      this.groupPanelId,
      this.btnlabel,
      this.btnCode,
      this.imgUrl,
      this.actdo})
      : super(key: key);
  @override
  _PnlConfigMntPages createState() => _PnlConfigMntPages();
}

class _PnlConfigMntPages extends State<PnlConfigMntPages>
    implements PosFncCallBack {
  PosFncCallResponse _responseInput;
  _PnlConfigMntPages() {
    _responseInput = new PosFncCallResponse(this);
  }
  @override
  void initState() {
    btnFSize =
        (widget.bosbtnX.btnFSize != null) ? widget.bosbtnX.btnFSize : btnFSize;
    bgbtnColor = (widget.bosbtnX.btnColor != null)
        ? widget.bosbtnX.btnColor
        : bgbtnColor;
    textColor =
        (widget.bosbtnX.txtColor != null) ? widget.bosbtnX.txtColor : textColor;
    super.initState();
  }

  TextEditingController txt1 = new TextEditingController();
  TextEditingController txt2 = new TextEditingController();
  TextEditingController txt3 = new TextEditingController();
  TextEditingController txt4 = new TextEditingController();
  TextEditingController txt5 = new TextEditingController();
  TextEditingController txt6 = new TextEditingController(); //GroupId
  TextEditingController txt7 = new TextEditingController(); //itemId
  bool showResult = false;
  TextEditingController activeTxt;
  Color textColor = Colors.black;
  Color bgbtnColor = Colors.transparent;
  double btnFSize = 14;
  String btnColorString = Colors.transparent.value.toRadixString(16);
  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
  representCharacter _representC;
  @override
  Widget build(BuildContext context) {
    activeTxt = txt4;
    getPanel();
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: Palette.stdbutton_theme_4,
        textStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.black));
    final List<Color> colors = <Color>[
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.amber,
      Colors.blueGrey,
      Colors.grey,
      Colors.cyan,
      Colors.lightBlue,
      Colors.transparent,
      Colors.orange,
      Colors.white,
      Colors.yellow,
      Colors.black,
    ];
    final fontsizeitems = List<String>.generate(11, (i) => "FontSize + $i");

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(color: Colors.white, spreadRadius: 3),
            ],
          ),
          height: Palette.stdbutton_height * 5.97,
          width: Palette.stdbutton_width * 7.27,
          child: Stack(
            children: [
              Positioned(
                top: 3,
                left: 3,
                child: Container(
                  height: Palette.stdbutton_height * 5.97,
                  width: Palette.stdbutton_width * 7.27,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.white, spreadRadius: 3),
                    ],
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey),
                      left: BorderSide(width: 1.0, color: Colors.grey),
                      right: BorderSide(width: 1.0, color: Colors.grey),
                      bottom: BorderSide(width: 1.0, color: Colors.grey),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8,
                        left: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: Container(
                              width: Palette.stdbutton_width * 3.6,
                              height: Palette.stdbutton_height * 1.2,
                              child: Row(
                                children: [
                                  Container(
                                    width: Palette.stdbutton_width * 3.6,
                                    height: Palette.stdbutton_height * 1.2,
                                    padding: const EdgeInsets.all(1),
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: '',
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  'Seq.No.', //Palette.billdischg_coupontype,
                                              style: TextStyle(
                                                fontFamily: 'Tahoma',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        left: 116,
                        child: Container(
                          decoration: BoxDecoration(
                            color: bgbtnColor,
                          ),
                          width: Palette.stdbutton_width * 2.6,
                          height: Palette.onelineheigth() * 0.6,
                          child: TextField(
                            controller: txt7,
                            style: TextStyle(
                              fontSize: btnFSize,
                              height: 1.5,
                              color: textColor,
                            ),
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: '',
                              fillColor: Colors.transparent,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 38,
                        left: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: Container(
                              width: Palette.stdbutton_width * 3.6,
                              height: Palette.stdbutton_height * 1.2,
                              child: Row(
                                children: [
                                  Container(
                                    width: Palette.stdbutton_width * 3.6,
                                    height: Palette.stdbutton_height * 1.2,
                                    padding: const EdgeInsets.all(1),
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: '',
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  'Button Label', //Palette.billdischg_coupontype,
                                              style: TextStyle(
                                                fontFamily: 'Tahoma',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 38,
                        left: 116,
                        child: Container(
                          decoration: BoxDecoration(
                            color: bgbtnColor,
                          ),
                          width: Palette.stdbutton_width * 2.6,
                          height: Palette.onelineheigth() * 0.6,
                          child: TextField(
                            controller: txt3,
                            onTap: () {
                              activeTxt = txt3;
                            },
                            style: TextStyle(
                              fontSize: btnFSize,
                              height: 1.5,
                              color: textColor,
                            ),
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: '',
                              fillColor: Colors.transparent,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 76,
                        left: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: Container(
                              width: Palette.stdbutton_width * 3.6,
                              height: Palette.stdbutton_height * 1.2,
                              child: Row(
                                children: [
                                  Container(
                                    width: Palette.stdbutton_width * 3.6,
                                    height: Palette.stdbutton_height * 1.2,
                                    padding: const EdgeInsets.all(1),
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: '',
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'Button Color\r\n' +
                                                  btnColorString, //Palette.billdischg_coupontype,
                                              style: TextStyle(
                                                fontFamily: 'Tahoma',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 76,
                        left: 116,
                        child: Container(
                          decoration: BoxDecoration(
                            color: bgbtnColor,
                          ),
                          width: Palette.stdbutton_width * 2.6,
                          height: Palette.onelineheigth() * 0.6,
                          child: TextField(
                            controller: txt1,
                            onTap: () {
                              activeTxt = txt1;
                            },
                            onSubmitted: (result) {
                              if (result.length == 6 || result.length == 8) {
                                setState(() {
                                  bgbtnColor =
                                      PosPanelCtrl().getColorFromHex(result);
                                });
                              }
                            },
                            style: TextStyle(
                                fontSize: 13,
                                height: 1.5,
                                backgroundColor: bgbtnColor),
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              // contentPadding: const EdgeInsets.all(10.0),
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: '',
                              fillColor: Colors.transparent,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      (showResult)
                          ? Positioned(
                              top: 38,
                              left: 340,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: bgbtnColor,
                                ),
                                width: Palette.stdbutton_width * 2.6,
                                height: Palette.onelineheigth() * 5.6,
                                child: TextField(
                                  controller: txt6,
                                  style: TextStyle(
                                    fontSize: 11,
                                    height: 1.5,
                                    color: textColor,
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Colors.grey),
                                    labelText: '',
                                    fillColor: Colors.transparent,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Positioned(
                              top: 38,
                              left: 340,
                              child: Container(
                                width: Palette.stdbutton_width * 0.6,
                                height: Palette.onelineheigth() * 5.6,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: colors.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (activeTxt == txt3) {
                                              textColor = colors[index];
                                            } else {
                                              bgbtnColor = colors[index];
                                              btnColorString = colors[index]
                                                  .value
                                                  .toRadixString(16);
                                              txt1.text = btnColorString;
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 20.0,
                                          // width: 20.0,
                                          color: colors[index],
                                        ),
                                      );
                                    }),
                              ),
                            ),
                      Positioned(
                        top: 38,
                        left: 420,
                        child: Container(
                          width: Palette.stdbutton_width * 2.6,
                          height: Palette.onelineheigth() * 5.6,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: fontsizeitems.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      btnFSize =
                                          13 + double.parse(index.toString());
                                    });
                                  },
                                  child: Text(fontsizeitems[index]),
                                );
                              }),
                        ),
                      ),
                      (widget.mntMode >= 3)
                          ? Positioned(
                              top: 136,
                              left: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Center(
                                  child: Container(
                                    width: Palette.stdbutton_width * 3.6,
                                    height: Palette.stdbutton_height * 1.2,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: Palette.stdbutton_width * 3.6,
                                          height:
                                              Palette.stdbutton_height * 1.2,
                                          padding: const EdgeInsets.all(1),
                                          child: RichText(
                                            textAlign: TextAlign.left,
                                            text: TextSpan(
                                              text: '',
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        'GROUP PANEL', //Palette.billdischg_coupondisc,
                                                    style: TextStyle(
                                                      fontFamily: 'Tahoma',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Positioned(
                              top: 136,
                              left: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Center(
                                  child: Container(
                                    width: Palette.stdbutton_width * 3.6,
                                    height: Palette.stdbutton_height * 1.2,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: Palette.stdbutton_width * 3.6,
                                          height:
                                              Palette.stdbutton_height * 1.2,
                                          padding: const EdgeInsets.all(1),
                                          child: RichText(
                                            textAlign: TextAlign.left,
                                            text: TextSpan(
                                              text: '',
                                              children: <TextSpan>[
                                                TextSpan(
                                                    text:
                                                        'Button\r\nType', //Palette.billdischg_coupondisc,
                                                    style: TextStyle(
                                                      fontFamily: 'Tahoma',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      (widget.mntMode >= 3)
                          ? Container()
                          : Positioned(
                              top: 116,
                              left: 66,
                              child: Container(
                                width: Palette.stdbutton_width * 3.0,
                                height: Palette.onelineheigth() * 2.6,
                                child: Column(children: <Widget>[
                                  Container(
                                    width: Palette.stdbutton_width * 3.0,
                                    height: Palette.onelineheigth() * 0.6,
                                    child: ListTile(
                                      title: const Text('Represent of Plu'),
                                      leading: Radio<representCharacter>(
                                        value: representCharacter.plu,
                                        groupValue: _representC,
                                        onChanged: null,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 0.0),
                                      dense: true,
                                    ),
                                  ),
                                  Container(
                                    width: Palette.stdbutton_width * 3.0,
                                    height: Palette.onelineheigth() * 0.6,
                                    child: ListTile(
                                      title: const Text('Represent of Style'),
                                      leading: Radio<representCharacter>(
                                        value: representCharacter.style,
                                        groupValue: _representC,
                                        onChanged: null,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 0.0),
                                      dense: true,
                                    ),
                                  ),
                                  Container(
                                    width: Palette.stdbutton_width * 3.0,
                                    height: Palette.onelineheigth() * 0.6,
                                    child: ListTile(
                                      title: const Text('Represent of PLU SET'),
                                      leading: Radio<representCharacter>(
                                        value: representCharacter.setPlu,
                                        groupValue: _representC,
                                        onChanged: null,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0.0, horizontal: 0.0),
                                      dense: true,
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                      Positioned(
                        top: 240,
                        left: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: Container(
                              width: Palette.stdbutton_width * 3.6,
                              height: Palette.stdbutton_height * 1.2,
                              child: Row(
                                children: [
                                  Container(
                                    width: Palette.stdbutton_width * 3.6,
                                    height: Palette.stdbutton_height * 1.2,
                                    padding: const EdgeInsets.all(1),
                                    child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: '',
                                        children: <TextSpan>[
                                          TextSpan(
                                              text:
                                                  'Code', //Palette.billdischg_couponnumber,
                                              style: TextStyle(
                                                fontFamily: 'Tahoma',
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                                color: Colors.black,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 240,
                        left: 116,
                        child: Container(
                          width: Palette.stdbutton_width * 2.6,
                          height: Palette.onelineheigth() * 0.6,
                          child: TextField(
                            enabled: false,
                            focusNode: null,
                            controller: txt4,
                            onChanged: null,
                            keyboardType: null,
                            style: TextStyle(fontSize: 14, height: 1.5),
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: '',
                              fillColor: Colors.transparent,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 280,
                        left: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Center(
                            child: Container(
                              width: Palette.stdbutton_width * 1.4,
                              height: Palette.stdbutton_height * 0.5,
                              child: Row(
                                children: [
                                  Container(
                                    width: Palette.stdbutton_width * 1.4,
                                    height: Palette.stdbutton_height * 0.5,
                                    padding: const EdgeInsets.all(1),
                                    child: ElevatedButton(
                                      style: style,
                                      onPressed: () {
                                        showImageByUrl();
                                        // String imgurl = txt5.text;
                                        // if (imgurl != '') {
                                        //   _launchURL(imgurl);
                                        // }
                                      },
                                      child: const Text('View Image'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 276,
                        left: 116,
                        child: Container(
                          width: Palette.stdbutton_width * 2.6,
                          height: Palette.onelineheigth() * 8,
                          child: TextField(
                            enabled: false,
                            focusNode: null,
                            controller: txt5,
                            onChanged: (text) {},
                            onSubmitted: (result) {},
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: TextStyle(fontSize: 13),
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.grey),
                              labelText: '',
                              fillColor: Colors.transparent,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ),
                      ),
                      curveButtons(
                          context,
                          _responseInput,
                          stdButtuon0[4],
                          330,
                          16,
                          Palette.stdbutton_width * 0.8,
                          Palette.stdbutton_height * 0.8),
                      curveButtons(
                          context,
                          _responseInput,
                          stdButtuon0[3],
                          330,
                          466,
                          Palette.stdbutton_width * 0.8,
                          Palette.stdbutton_height * 0.8),
                    ],
                  ),
                ),
              ),
              //------------
            ],
          ),
        ),
      ],
    );
  }

  void showImageByUrl() async {
    // String getCurIp = await PosPanelCtrl().getCurrentIP(txt5.text);

    _launchURL(txt5.text);
  }

  void txtinputEntry(String result) {
    if (result != "") {
      //fcn1.unfocus();
      if ((result.indexOf(":") > 0)) {
        var comm = result.split(":");
      } else {
        if (result == 'OK') {
          if (widget.bosbtnX.id == null || widget.bosbtnX.id == 0) {
            if (widget.bosbtnX.cmdCode == 'grpInput') {
              addGroupPanel();
              widget.actdo();
              Navigator.pop(context);
            } else if (widget.bosbtnX.cmdCode == 'txtInput') {
              addItemPanel();
              widget.actdo();
              Navigator.pop(context);
            }
            //add
          } else {
            //update
            if (widget.bosbtnX.cmdCode == 'grpInput') {
              updateGroupPanel();
              widget.actdo();
              Navigator.pop(context);
            } else if (widget.bosbtnX.cmdCode == 'txtInput') {
              updateItemPanel();
              widget.actdo();
              Navigator.pop(context);
            }
          }
        } else if (result == 'CANCEL') {
          Navigator.pop(context);
        } else {
          //showToast(context, result);
        }
      }
    }
  }

//----------GROUP PANEL MAINTAIN--------------
  void addGroupPanel() {
    //----Panel/GroupId ---bgColor/txtColor/FontSize --Label/imageUrl
    // http://192.168.2.67:9393/GrpPnl/a/
    // RT003/33/  ff898989/00000000/18.0/  ของชำร่วย/temp.jpg
    String _body;
    String panelId = widget.bosbtnX.panelId;
    // String groudId = widget.bosbtnX.groupId.toString();
    String bgColor = bgbtnColor.value.toRadixString(16);
    String txColor = textColor.value.toRadixString(16);
    String fontSz = btnFSize.toString().trim();
    String label = saveLabel(txt3.text);
    String groudId = txt7.text; //integer
    String imgUrl = cleanUrl(txt5.text);

    _body = panelId +
        '/' +
        groudId +
        '/' +
        bgColor +
        '/' +
        txColor +
        '/' +
        fontSz +
        '/' +
        label +
        '/' +
        imgUrl;

    String pnlUrl = PosPanelCtrl().getAddGpnlurl(context, _body);

    widget.responseAddPanel.exeAboutPanelToWS(pnlUrl);
    setState(() {
      txt6.text = pnlUrl;
      showResult = true;
    });
  }

  void updateGroupPanel() {
    //http://192.168.2.67:9393/GrpPnl
    //-----id-Panel/Group ID -- bgColor/txtColor/FontSize -- label/imageUrl
    ///u/e/  24/RT003/33/       ff242424/11111111/22         /TEST/temp.jpg
    String _body;
    String panelId = widget.touchPanelId;
    String groudId = txt7.text;
    String bgColor = bgbtnColor.value.toRadixString(16);
    String txColor = textColor.value.toRadixString(16);
    String fontSz = btnFSize.toString().trim();
    String label = saveLabel(txt3.text);
    String imgUrl = cleanUrl(txt5.text);

    _body = widget.bosbtnX.id.toString() +
        '/' +
        panelId +
        '/' +
        groudId +
        '/' +
        bgColor +
        '/' +
        txColor +
        '/' +
        fontSz +
        '/' +
        label +
        '/' +
        imgUrl;

    String pnlUrl = PosPanelCtrl().getUpdateGpnlurl(context, _body);

    widget.responseAddPanel.exeAboutPanelToWS(pnlUrl);
    setState(() {
      txt6.text = pnlUrl;
      showResult = true;
    });
  }

  String cleanUrl(String imgUrl) {
    // String PnlBaseUrl = PosPanelCtrl().getPnlUploadUrl(context);
    return imgUrl
        .replaceAll('https://', '[[')
        .replaceAll('http://', '[')
        .replaceAll('/', '=');
  }

  void deleteGroupPanel() {
    //http://192.168.2.67:9393/GrpPnl/
    //----Panel/Group Id
    //d/  RT/2
    String _body;
    String _tcode = txt1.text;
    String _tdesc = txt2.text;

    // _body = _tcode + '/' + _posscrtype + '/' + _tdesc;
    //String pnlUrl = '';
    String pnlUrl = PosPanelCtrl().getAddPanelurl(context, _body);
    widget.responseAddPanel.exeAboutPanelToWS(pnlUrl);
  }
//----------ITEM PANEL MAINTAIN--------------

  void addItemPanel() {
//http://192.168.2.67:9393/GrpPnl/a/
//RT002/21/21002   /ff898989/fffff/18/    1/FB0103-3-75/   TomYamKung/11947746eb5d4df69a06bca1d485008d.jpg
    String _body;
    String panelId = widget.bosbtnX.panelId;
    String groudId = widget.bosbtnX.groupId.toString();
    String bgColor = bgbtnColor.value.toRadixString(16);
    String txColor = textColor.value.toRadixString(16);
    String fontSz = btnFSize.toString().trim();
    String label = saveLabel(txt3.text);
    String itemid = txt7.text;
    String imgUrl = cleanUrl(txt5.text);
    String linkfg = '0';
    String linkCode = txt4.text;
    if (widget.representC == representCharacter.plu) {
      linkfg = '1';
    } else if (widget.representC == representCharacter.style) {
      linkfg = '2';
    } else if (widget.representC == representCharacter.setPlu) {
      linkfg = '3';
    }
    _body = panelId +
        '/' +
        groudId +
        '/' +
        itemid +
        '/' +
        bgColor +
        '/' +
        txColor +
        '/' +
        fontSz +
        '/' +
        linkfg +
        '/' +
        linkCode +
        '/' +
        label +
        '/' +
        imgUrl;

    String pnlUrl = PosPanelCtrl().getAddItemlurl(context, _body);

    widget.responseAddPanel.exeAboutPanelToWS(pnlUrl);
    setState(() {
      txt6.text = pnlUrl;
      showResult = true;
    });
  }

  String saveLabel(String lbl) {
    if (lbl == '') {
      return '..';
    } else {
      return lbl.padRight(20).substring(0, 19).trim();
    }
  }

  void updateItemPanel() {
    //http://192.168.2.67:9393/PnlItem
    //-----item id -- bgColor/txtColor/FontSize -- lingFg/LinkCode --label/imageUrl
    //u/e/ 17/        ff898989/000000/14           /1/FB0103-3-75    /LabMooTod/11947746eb5d4df69a06bca1d485008d.jpg
    String _body;
    String bgColor = bgbtnColor.value.toRadixString(16);
    String txColor = textColor.value.toRadixString(16);
    String fontSz = btnFSize.toString().trim();
    String label = saveLabel(txt3.text);
    String imgUrl = cleanUrl(txt5.text);
    String itemId = txt7.text;
    String linkfg = '0';
    String linkCode = txt4.text.toString();
    //widget.btnCode;
    if (_representC == representCharacter.plu) {
      linkfg = '1';
    } else if (_representC == representCharacter.style) {
      linkfg = '2';
    } else if (_representC == representCharacter.setPlu) {
      linkfg = '3';
    } else {
      linkfg = '1';
    }
    _body = widget.bosbtnX.id.toString() +
        '/' +
        bgColor +
        '/' +
        txColor +
        '/' +
        fontSz +
        '/' +
        itemId +
        '/' +
        linkfg +
        '/' +
        linkCode +
        '/' +
        label +
        '/' +
        imgUrl;

    String pnlUrl = PosPanelCtrl().getUpdateItemlurl(context, _body);

    widget.responseAddPanel.exeAboutPanelToWS(pnlUrl);
    setState(() {
      txt6.text = pnlUrl;
      showResult = true;
    });
  }

  //----------------------------
  void getPanel() {
    String PnlBaseUrl = PosPanelCtrl().getPnlUploadUrl(context);
    txt7.text = (widget.bosbtnX.itemId == null)
        ? widget.bosbtnX.groupId.toString()
        : widget.bosbtnX.itemId.toString();
    txt3.text = (widget.btnlabel != '')
        ? widget.btnlabel.padRight(20).substring(0, 19)
        : widget.bosbtnX.label.padRight(20).substring(0, 19);
    txt4.text =
        (widget.btnCode != '') ? widget.btnCode.trim() : widget.bosbtnX.kybCode;
    txt5.text = widget.imgUrl;
    setState(() {
      _representC = widget.representC;
    });
  }

  @override
  void onCallPosFncError(String error) {}

  @override
  void onCallPosFncSuccess(String result) {
    txtinputEntry(result);
  }
}
