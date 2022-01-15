import 'package:com_csith_geniuzpos/data/posfunctions/poscontrolfnc.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/pospanelctrl.dart';
import 'package:com_csith_geniuzpos/models/posmodels/csplu.dart';
import 'package:com_csith_geniuzpos/models/posmodels/groupPanel.dart';
import 'package:com_csith_geniuzpos/models/posmodels/itemPanel.dart';
import 'package:com_csith_geniuzpos/models/posmodels/touchPanel.dart';
import 'package:com_csith_geniuzpos/models/possales/salesItemSummary.dart';
import 'package:com_csith_geniuzpos/models/possales/salesitems.dart';
import 'package:com_csith_geniuzpos/resources/csiconfig.dart';
import 'package:com_csith_geniuzpos/screens/home_screen.dart';
import 'package:com_csith_geniuzpos/screens/panel_config/components/pnlConfig_list.dart';
import 'package:com_csith_geniuzpos/screens/panel_config/components/pnlConfig_body.dart';
import 'package:com_csith_geniuzpos/screens/searchplu/components/plu_list.dart';
import 'package:com_csith_geniuzpos/services/response/panel_response.dart';
import 'package:com_csith_geniuzpos/services/response/posdata_response.dart';
import 'package:com_csith_geniuzpos/utility/normal_dialog.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/curve_button.dart';
import 'package:com_csith_geniuzpos/widgets/buttons/position_button.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/models/buttons/buttuns.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/fncitems.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:com_csith_geniuzpos/resources/styles.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'components/pnlConfig_fb.dart';
import 'components/pnlConfig_group.dart';
import 'components/pnlConfig_menu.dart';
import 'components/pnlConfig_mnt.dart';
import 'components/pnlConfig_retail.dart';

class RetailConfPages extends StatefulWidget {
  @override
  _RetailConfPages createState() => _RetailConfPages();
}

class _RetailConfPages extends State<RetailConfPages>
    implements
        PosFncCallBack,
        PanelCallBack,
        AddPanelCallBack,
        GetPluListCallBack,
        GetPluCallBack,
        GrpPnlListCallBack,
        ItemPnlListCallBack {
  PosFncCallResponse _responseInput;
  LogPanelResponse _responseTouchPanel;
  AddPanelResponse _responseAddPanel;
  GetPluListResponse _reponsePluList;
  GetPluResponse _responsePlu;
  GrpPnlListResponse _responseGrpPnlList;
  ItemPnlListResponse _responseItemPnlList;
  TextEditingController activeTxt;
  String activeTouchPanel, activeCode, activePanel;
  int activeGroupPanel, activePanelId;
  PosButtonX activeposGroup;
  //BuildContext _context;
  List<CsPlu> getPluList;
  CsPlu csPlus;
  PosButtonX bosbtnX, bosbtnIT, bosbtnGP;
  List<TouchPanel> touchpnlList;
  List<GroupPanel> groupPanelList;
  List<ItemPanel> itemPanelList;
  PosButton posGroup;

  var now = DateTime.now();
  int salesitemIndex = -1;
  SalesItemSummary salesitemsum;
  SalesItems selectSalesitem;
  bool kEntry = false;
  int mode = 0;
  int mntMode = 0;
  int lastaction = 0;
  representCharacter _representC = representCharacter.plu;
  touchCharacter _touchC = touchCharacter.RT;
  String baseUrl;
  PosInput _posinput;
  TextEditingController txt1 = new TextEditingController();
  TextEditingController txt2 = new TextEditingController();
  TextEditingController txt3 = new TextEditingController();
  TextEditingController txt4 = new TextEditingController();
  TextEditingController txt5 = new TextEditingController();
  TextEditingController txt7 = new TextEditingController();

  final TrackingScrollController _trackingScrollController =
      TrackingScrollController();
  FocusNode fcn1;
  _RetailConfPages() {
    _responseInput = new PosFncCallResponse(this);
    _responseTouchPanel = new LogPanelResponse(this);
    _responseAddPanel = new AddPanelResponse(this);
    _reponsePluList = new GetPluListResponse(this);
    _responsePlu = new GetPluResponse(this);

    _responseGrpPnlList = new GrpPnlListResponse(this);
    _responseItemPnlList = new ItemPnlListResponse(this);
    fcn1 = FocusNode();
  }
  @override
  void initState() {
    activeTxt = txt4;
    salesitemIndex = -1;
    _posinput = new PosInput();
    getCurPluUrl();

    loadPanel();

    super.initState();
  }

  void getCurPluUrl() async {
    String url = PosControlFnc().getPLUurl(context);
    baseUrl = await PosControlFnc().getCurrentIP(url);
  }

  @override
  void dispose() {
    _trackingScrollController.dispose();
    _posinput.focusnode.dispose();
    super.dispose();
  }

  @override
  void onCallPosFncError(String error) {}

  @override
  void onCallPosFncSuccess(String result) {
    txtinputEntry(result);
  }

  void txtinputEntry(String result) {
    if (result != "") {
      if (result == 'SEARCH') {
        String url = PosPanelCtrl().getPLUpnlurl(context, txt4.text);
        showToast(context, url);
        _reponsePluList.getPluList(url);
      } else if ((result.indexOf(":") > 0)) {
        var comm = result.split(":");
        if (comm[1] == '3') {
        } else {
          if (comm[2] == 'DELTOUCH') {
            delTouchPanel();
          } else if (comm[2] == 'ADDTOUCH') {
            addTouchPanel();
            // } else if (comm[2] == 'COPYTOUCH') {
            //set plu
            //  showToast(context, comm[2]);
          } else if (comm[2] == 'SAVETOUCH') {
            saveTouchPanel();
          } else if (comm[2] == 'ADDPNLGP') {
            addBtnGroupPanel();
          } else if (comm[2] == 'DELPNLGP') {
            delGroupPanel();
          } else if (comm[2] == 'COPYPNLGP') {
            copyPnlGP();
          } else if (comm[2] == 'PASTEPNLGP') {
            pastePnlGP();
          } else if (comm[2] == 'SORTPNLGP') {
            sortPnlGP();
          } else if (comm[2] == 'ADDPNLIT') {
            addBtnItemPanel();
          } else if (comm[2] == 'DELPNLIT') {
            delItemPanel();
          } else if (comm[2] == 'COPYPNLIT') {
            copyPnlIt();
          } else if (comm[2] == 'PASTEPNLIT') {
            pastePnlIt();
          } else if (comm[2] == 'SORTPNLIT') {
            sortPnlIt();
          } else if (comm[2] == 'SWITCHRTFB') {
            setState(() {
              if (mode == 1) {
                mode = 0;
                _touchC = touchCharacter.RT;
              } else {
                mode = 1;
                _touchC = touchCharacter.FB;
              }
            });
          } else if (comm[2] == 'ESC') {
            //---must to update open shift from 'O' - openning to 'P'- pending
            MaterialPageRoute route =
                MaterialPageRoute(builder: (value) => HomeScreen(0));
            Navigator.push(context, route);
          }
        }
      } else {
        if (result == 'EDIT') {
          buttonMnt(context);
        } else if (result == 'OK') {
          Navigator.pop(context);
        } else if (result == 'CANCEL') {
          Navigator.pop(context);
        }
      }
    }
  }

  void sortPnlIt() {
    //http://192.168.2.57:9393/PnlItem/s/FB001/26
    if (activeTouchPanel != null && activeGroupPanel != null) {
      String _body = activeTouchPanel + '/' + activeGroupPanel.toString();
      String pnlUrl = PosPanelCtrl().getSortItpnlurl(context, _body);

      _responseAddPanel.exeAboutPanelToWS(pnlUrl);
      lastaction = 2;
      setState(() {});
    }
  }

  void sortPnlGP() {
    // http://192.168.2.57:9393/GrpPnl/s/RT002/u
    if (activeTouchPanel != null) {
      String _body = activeTouchPanel;
      String pnlUrl = PosPanelCtrl().getSortGPpnlurl(context, _body);

      _responseAddPanel.exeAboutPanelToWS(pnlUrl);
      lastaction = 1;
      setState(() {});
    }
  }

  void copyPnlIt() {
    setState(() {
      if (bosbtnX != null) {
        bosbtnIT = bosbtnX;
      } else {
        bosbtnIT = null;
      }
    });
  }

  void pastePnlIt() {
    // http://192.168.2.57:9393/PnlItem/p/  72/  RT002/31/ 26
    String _body = bosbtnIT.id.toString() +
        '/' +
        activeTouchPanel +
        '/' +
        activeGroupPanel.toString() +
        '/' +
        bosbtnIT.itemId.toString(); //integer
    String pnlUrl = PosPanelCtrl().getPasteIpnlurl(context, _body);

    _responseAddPanel.exeAboutPanelToWS(pnlUrl);
    lastaction = 2;
    setState(() {
      bosbtnIT = null;
    });
  }

  void copyPnlGP() {
    setState(() {
      if (bosbtnX != null) {
        bosbtnGP = bosbtnX;
      } else {
        bosbtnGP = null;
      }
    });
  }

  void pastePnlGP() {
    // http://192.168.2.57:9393/GrpPnl/p/  31/  RT002/  25
    String _body = bosbtnGP.groupId.toString() +
        '/' +
        activeTouchPanel +
        '/' +
        activeGroupPanel.toString(); //integer
    String pnlUrl = PosPanelCtrl().getPasteGpnlurl(context, _body);

    _responseAddPanel.exeAboutPanelToWS(pnlUrl);
    lastaction = 1;
    setState(() {
      bosbtnGP = null;
    });
  }

  void searchPLU(
    BuildContext context,
    List<CsPlu> _cspluslist,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetAnimationDuration: const Duration(milliseconds: 100),
          child: Stack(
            children: [
              Container(
                  // use container to change width and height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.white, spreadRadius: 3),
                    ],
                  ),
                  height: Palette.stdbutton_height * 6,
                  width: Palette.stdbutton_width * 7.3,
                  child: PluSearchList(
                      txt: txt4,
                      responsePlu: _responsePlu,
                      getPluList: _cspluslist)),
            ],
          ),
        );
      },
    );
  }

  void buttonMnt(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetAnimationDuration: const Duration(milliseconds: 100),
          child: Stack(
            children: [
              Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(color: Colors.white, spreadRadius: 3),
                    ],
                  ),
                  height: Palette.stdbutton_height * 6,
                  width: Palette.stdbutton_width * 7.3,
                  child: PnlConfigMntPages(
                      mntMode: mntMode,
                      responseInput: _responseInput,
                      responseAddPanel: _responseAddPanel,
                      bosbtnX: bosbtnX,
                      touchC: _touchC,
                      representC: _representC,
                      touchPanelId: activeTouchPanel,
                      btnlabel: txt3.text,
                      btnCode: txt4.text,
                      imgUrl: txt5.text,
                      actdo: getGroup)),
            ],
          ),
        );
      },
    );
  }

//----------GROUP PANEL MAINTAIN--------------
  void addBtnGroupPanel() {
    _representC = representCharacter.plu;
    PosButtonX bosbtn = new PosButtonX(
      label: '',
      imageUrl: '',
      cmdCode: 'grpInput',
      kybCode: '',
      btnColor: Palette.stdbutton_theme_0,
      btnXwid: 1.5,
      btnFSize: 18,
      txtColor: Colors.black,
      replresentOf: 0,
      panelId: activeTouchPanel,
      groupId: activeGroupPanel,
    );
    _representC = representCharacter.plu;
    getPanel(bosbtn, 'g');
    lastaction = 1;
  }

  void delGroupPanel() {
    //http://192.168.2.67:9393/GrpPnl/d/RT/2
    if (bosbtnX.cmdCode == 'grpInput') {
      String _body = 'd/15';
      String _tcode = bosbtnX.id.toString();

      _body = _tcode;
      String pnlUrl = PosPanelCtrl().getDelGroupPanelurl(context, _body);
      //txt5.text = pnlUrl;
      _responseAddPanel.exeAboutPanelToWS(pnlUrl);
      lastaction = 1;
    } else {
      showToast(context, 'You msut select group of panel button first!');
    }
  }

//----------ITEM PANEL MAINTAIN--------------
  void addBtnItemPanel() {
    _representC = representCharacter.plu;
    PosButtonX bosbtn = new PosButtonX(
      label: '',
      imageUrl: '',
      cmdCode: 'txtInput',
      kybCode: '',
      btnColor: Palette.stdbutton_theme_0,
      btnXwid: 1 * (8 / 6),
      btnFSize: 13,
      txtColor: Colors.black,
      replresentOf: 1,
      panelId: activeTouchPanel,
      groupId: activeGroupPanel,
    );
    _representC = representCharacter.plu;
    getPanel(bosbtn, 'r');
    lastaction = 2;
  }

  void delItemPanel() {
    //https://localhost:44379/PnlItem/d/15
    if (bosbtnX.cmdCode == 'txtInput') {
      String _body = 'd/15';
      String _tcode = bosbtnX.id.toString();

      _body = _tcode;
      String pnlUrl = PosPanelCtrl().getDelItemPanelurl(context, _body);
      // txt5.text = pnlUrl;

      _responseAddPanel.exeAboutPanelToWS(pnlUrl);
    } else {
      showToast(context, 'You msut select panel button first!');
    }
  }

//-----------TOUCH PANEL MAINTAIN---------------
  void addTouchPanel() {
    //http://192.168.2.67:9393/TouchPanel/
    //a/FB002/FB/Food & Beverage Style 002
    String _body;
    String _tcode = txt1.text;
    String _tdesc = txt2.text;
    String _posscrtype = 'RT';
    if (_touchC == touchCharacter.RT) {
      _posscrtype = 'RT';
    } else {
      _posscrtype = 'FB';
    }
    _body = _tcode + '/' + _posscrtype + '/' + _tdesc;
    //String pnlUrl = '';
    String pnlUrl = PosPanelCtrl().getAddPanelurl(context, _body);
    _responseAddPanel.exeAboutPanelToWS(pnlUrl);
    lastaction = 0;
  }

  void saveTouchPanel() {
    //http://192.168.2.67:9393/TouchPanel/u/e/1/RT/Snack Choice
    String _body;
    String _tcode = activePanelId.toString();
    String _tpanel = txt1.text;
    String _tdesc = txt2.text;
    String _posscrtype = 'RT';
    if (_touchC == touchCharacter.RT) {
      _posscrtype = 'RT';
    } else {
      _posscrtype = 'FB';
    }
    _body = _tcode + '/' + _posscrtype + '/' + _tpanel + '/' + _tdesc;

    String pnlUrl = PosPanelCtrl().getSavePanelurl(context, _body);
    _responseAddPanel.exeAboutPanelToWS(pnlUrl);
    lastaction = 0;
    setState(() {});
  }

  void delTouchPanel() {
    //http://192.168.2.67:9393/TouchPanel/
    //d/FB002
    String _body = 'd/FB003';
    String _tcode = txt1.text;

    _body = _tcode;
    String pnlUrl = PosPanelCtrl().getDelPanelurl(context, _body);
    _responseAddPanel.exeAboutPanelToWS(pnlUrl);
    lastaction = 0;
  }

//---------------------
  void getTouchValue(TouchPanel _TouchPanel) {
    clsEntryMnt();
    setState(() {
      activeTouchPanel = _TouchPanel.touchPanelType;
      activePanel = _TouchPanel.touchPanelDesc.trim();
      activePanelId = _TouchPanel.id;
      PosControlFnc().updatePanel(
          context,
          _TouchPanel.posScreenType +
              ' - ' +
              _TouchPanel.touchPanelType +
              ':' +
              activePanel);
      txt1.text = _TouchPanel.touchPanelType;
      txt2.text = _TouchPanel.touchPanelDesc.trim();
      switchRTFB(_TouchPanel.posScreenType);
      groupPanelList = null;
      itemPanelList = null;
    });
    loadGroupPanel();
  }

  void switchRTFB(String posscreenType) {
    if (posscreenType == 'RT') {
      mode = 0;
      _touchC = touchCharacter.RT;
    } else {
      mode = 1;
      _touchC = touchCharacter.FB;
    }
  }

  void switchTouchByClick(touchCharacter posscreenType) {
    if (posscreenType == touchCharacter.RT) {
      mode = 0;
      _touchC = touchCharacter.RT;
    } else {
      mode = 1;
      _touchC = touchCharacter.FB;
    }
  }

  void switchRepresentOf(int repOf) {
    if (repOf == 1) {
      _representC = representCharacter.plu;
    } else if (repOf == 2) {
      _representC = representCharacter.style;
    } else if (repOf == 3) {
      _representC = representCharacter.setPlu;
    } else {
      _representC = representCharacter.plu;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: rtScreenDesktop(context, _responseInput, salesitemsum),
        ));
  }

  Widget rtScreenDesktop(BuildContext context, PosFncCallResponse responseInput,
      SalesItemSummary salesitemsum) {
    final double positionOfButton =
        Palette.stdbutton_width + Palette.stdspacer_widht;

    final double btnheight9 = Palette.stdbutton_height * 6.85 +
        Palette.stdbutton_height * 2 +
        Palette.stdspacer_widht * 2;

    final double btnheight10 =
        btnheight9 + Palette.stdbutton_height + Palette.stdspacer_widht;
    final double btnwidth = positionOfButton * 8.5;
    //Palette.stdbutton_width * 4.75;
    final double btnheight = Palette.stdbutton_height * 6.85 + 30;
    final double btnheight8 = Palette.stdbutton_height * 6.85 +
        Palette.stdbutton_height +
        Palette.stdspacer_widht +
        50;
    return Stack(children: [
      pnlMenu(context),
      PnlConfigBodyPages(),
      Positioned(
          top:
              Palette.fullsalesheadcheight() + Palette.stdspacer_widht * 6 + 26,
          left: Palette.stdspacer_widht,
          child: PnlConfigItem(
            responseInput: _responseInput,
            touchpnlList: touchpnlList,
            actdo: getTouchValue,
            responseTouchPanel: _responseTouchPanel,
          )),
      touchEntryForm(btnheight),
      pnlEntryForm(btnheight),
      positionPosButtons(
          context, _responseInput, stdButtuon7, btnheight, btnwidth, 24),
      positionPosButtons(context, _responseInput, stdButtuon7, btnheight,
          btnwidth + positionOfButton, 25),
      positionPosButtons(context, _responseInput, stdButtuon7, btnheight,
          btnwidth + positionOfButton * 2, (bosbtnIT == null) ? 26 : 32),
      positionPosButtons(context, _responseInput, stdButtuon7, btnheight,
          btnwidth + positionOfButton * 3, 27),
      positionPosButtons(
          context, _responseInput, stdButtuon7, btnheight8, btnwidth, 28),
      positionPosButtons(context, _responseInput, stdButtuon7, btnheight8,
          btnwidth + positionOfButton, 29),
      positionPosButtons(context, _responseInput, stdButtuon7, btnheight8,
          btnwidth + positionOfButton * 2, (bosbtnGP == null) ? 30 : 33),
      positionPosButtons(context, _responseInput, stdButtuon7, btnheight8,
          btnwidth + positionOfButton * 3, 31),

      positionPosButtons(context, _responseInput, stdButtuon10, btnheight10,
          Palette.stdspacer_widht, 20),
      positionPosButtons(context, _responseInput, stdButtuon10, btnheight10,
          positionOfButton * 1.5, 21),
      positionPosButtons(context, _responseInput, stdButtuon10, btnheight10,
          positionOfButton * 2.5, 22),
      // positionPosButtons(context, _responseInput, stdButtuon10, btnheight10,
      //     positionOfButton * 3.5, 23),
      positionPosButtons(context, _responseInput, stdButtuon10, btnheight10,
          positionOfButton * 8.5, 24),
      positionPosButtons(context, _responseInput, stdButtuon9, btnheight10,
          positionOfButton * 10.5, 10),
      (mode == 1) ? getFB() : getRetail(),
      getGroup(),
    ]);
  }

  Widget getGroup() {
    return (groupPanelList == null || groupPanelList.length == 0)
        ? Container()
        : GroupPanelForm(
            starttop: 30,
            startleft: 132 +
                Palette.stdbutton_width * (8 / 6) * 7.26 +
                Palette.stdspacer_widht * 7,
            pnlbtnInputs: (PosButton input) {
              FncItems().poscenter(context, _responseInput, input);
            },
            actdo: getPanel,
            groupPanelList: groupPanelList);
  }

  Widget getFB() {
    return (itemPanelList == null || itemPanelList.length == 0)
        ? Container()
        : Fbpanel(
            starttop: 30,
            startleft: 128 +
                Palette.stdbutton_width * (8 / 6) * 2.26 +
                Palette.stdspacer_widht * 2,
            pnlbtnInputs: (PosButton input) {},
            grpCode: (posGroup != null) ? posGroup : posGroup,
            actdo: getPanel,
            itemPanelList: itemPanelList,
            maxList:
                PosPanelCtrl().maxPanelListByColumns(5, itemPanelList.length),
            pnlCount: 5);
  }

  Widget getRetail() {
    return (itemPanelList == null || itemPanelList.length == 0)
        ? Container()
        : Rtpanel(
            starttop: 30,
            startleft: 142 +
                Palette.stdbutton_width * (8 / 6) * 4.26 +
                Palette.stdspacer_widht * 3,
            pnlbtnInputs: (PosButton input) {},
            grpCode: (posGroup != null) ? posGroup : posGroup,
            actdo: getPanel,
            itemPanelList: itemPanelList,
            maxList:
                PosPanelCtrl().maxPanelListByColumns(3, itemPanelList.length),
            pnlCount: 3);
  }

  Widget pnlEntryForm(double btnheight) {
    final ButtonStyle style = ElevatedButton.styleFrom(
        primary: Palette.stdbutton_theme_4,
        textStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.black));
    return (mntMode == 0)
        ? Container()
        : Stack(
            children: [
              Positioned(
                top: btnheight,
                left: Palette.stdbutton_width * 4.75,
                child: Container(
                  width: Palette.restsalesitemwidth() - 46,
                  height: Palette.stdbutton_height * 3.75,
                  decoration: BoxDecoration(
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
                        top: 8,
                        left: 116,
                        child: Container(
                          width: Palette.stdbutton_width * 2.6,
                          height: Palette.onelineheigth() * 0.6,
                          child: TextField(
                            autofocus: true,
                            controller: txt3,
                            onChanged: (text) {},
                            onSubmitted: (result) {},
                            style: TextStyle(fontSize: 13, height: 1.5),
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
                      (mntMode >= 3)
                          ? Positioned(
                              top: 46,
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
                                                    text: 'GROUP PANEL\r\n' +
                                                        activeGroupPanel
                                                            .toString(),
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
                              top: 56,
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
                      (mntMode >= 3)
                          ? Container()
                          : Positioned(
                              top: 36,
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
                                        onChanged: (representCharacter value) {
                                          setState(() {
                                            _representC = value;
                                          });
                                        },
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
                                        onChanged: (representCharacter value) {
                                          setState(() {
                                            _representC = value;
                                          });
                                        },
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
                                        onChanged: (representCharacter value) {
                                          setState(() {
                                            _representC = value;
                                          });
                                        },
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
                        top: 120,
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
                                              text: (mntMode >= 3)
                                                  ? 'Seq.No.'
                                                  : 'Link.Code.',
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
                        top: 130,
                        left: 116,
                        child: Container(
                          width: Palette.stdbutton_width * 2.0,
                          height: Palette.onelineheigth() * 0.6,
                          child: TextField(
                            onTap: () {
                              activeCode = txt4.text;
                            },
                            controller: txt4,
                            onChanged: (text) {},
                            onSubmitted: (result) {
                              activeCode = result;
                            },
                            style: TextStyle(fontSize: 13, height: 1.5),
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
                      curveButtons(
                          context,
                          _responseInput,
                          stdButtuon0[2],
                          125,
                          272,
                          Palette.stdbutton_width * 0.65,
                          Palette.stdbutton_height * 0.65),
                      Positioned(
                        top: 150,
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
                                        //showToast(context, txt5.text);
                                        showImageByUrl();
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
                        top: 166,
                        left: 116,
                        child: Container(
                          width: Palette.stdbutton_width * 2.6,
                          height: Palette.onelineheigth() * 8,
                          child: TextField(
                            autofocus: true,
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
                          stdButtuon0[9],
                          190,
                          16,
                          Palette.stdbutton_width * 0.8,
                          Palette.stdbutton_height * 0.8),
                    ],
                  ),
                ),
              ),
              //------------
            ],
          );
  }

  void showImageByUrl() async {
    String getCurIp = await PosControlFnc().getCurrentIP(txt5.text);
    //showToast(context, getCurIp);
    _launchURL(getCurIp);
  }

  void getPlu(CsPlu _csplus) {
    if (txt3.text.isEmpty || txt3.text == '') {
      txt3.text = _csplus.pluShortDesc;
    }
    _representC = representCharacter.plu;
    txt4.text = _csplus.pluCode;
    if (txt5.text.isEmpty || txt5.text == '') {
      txt5.text = PosPanelCtrl().getImgUrl(_csplus.pluDesc);
    }
  }

  void getSetPlu(CsPlu _csplus) {
    if (txt3.text.isEmpty || txt3.text == '') {
      txt3.text = _csplus.pluShortDesc;
    }
    _representC = representCharacter.setPlu;
    txt4.text = _csplus.pluCode;
    if (txt5.text.isEmpty || txt5.text == '') {
      txt5.text = PosPanelCtrl().getImgUrl(_csplus.pluDesc);
    }
  }

  void getStyle(CsPlu _csplus) {
    if (txt3.text.isEmpty || txt3.text == '') {
      txt3.text = _csplus.pluShortDesc;
    }
    _representC = representCharacter.style;
    txt4.text = _csplus.pluCode;
    if (txt5.text.isEmpty || txt5.text == '') {
      txt5.text = PosPanelCtrl().getImgUrl(_csplus.pluDesc);
    }
  }

  void getPanel(PosButtonX bosbtn, String btnType) {
    try {
      bosbtnX = bosbtn;
      setState(() {
        if (btnType == 'f') {
          mntMode = 1;
          txt7.text = bosbtn.itemId.toString();
          txt3.text = bosbtn.label;
          txt4.text = bosbtn.kybCode;
          activeCode = bosbtn.kybCode;
          txt5.text = PosPanelCtrl().getImgUrl(bosbtn.imageUrl);
          switchRepresentOf(bosbtn.replresentOf);
        } else if (btnType == 'r') {
          mntMode = 2;
          txt7.text = bosbtn.itemId.toString();
          txt3.text = bosbtn.label;
          txt4.text = bosbtn.kybCode;
          activeCode = bosbtn.kybCode;
          txt5.text = PosPanelCtrl().getImgUrl(bosbtn.imageUrl);
          switchRepresentOf(bosbtn.replresentOf);
        } else if (btnType == 'g') {
          activeposGroup = bosbtn;
          mntMode = 3;
          txt7.text = bosbtn.groupId.toString();
          txt3.text = bosbtn.label;
          txt4.text = bosbtn.kybCode;
          activeCode = bosbtn.kybCode;
          txt5.text = PosPanelCtrl().getImgUrl(bosbtn.imageUrl);
          activeGroupPanel = bosbtn.groupId;

          String groupId = activeGroupPanel.toString();
          String itemPnlUrl = PosPanelCtrl().getItemPanelurl(context);

          _responseItemPnlList
              .itemPnlList(itemPnlUrl + '/' + activeTouchPanel + '/' + groupId);
        } else {
          activeCode = '';
          clsEntryMnt();
        }
      });
    } catch (e) {
      showToast(context, e.toString());
    }
  }

  void clsEntryMnt() {
    txt7.text = '';
    txt3.text = '';
    txt4.text = '';
    txt5.text = '';
  }

  void _launchURL(String _url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  void clsTouch() {
    txt1.text = '';
    txt2.text = '';
  }

  void loadFirstGroupPanel(List<TouchPanel> _vpoTouchPanel) {
    activeTouchPanel = _vpoTouchPanel[0].touchPanelType;
    lastaction = 1;
    // loadGroupPanel();
  }

  void loadPanel() {
    String pnlUrl = PosPanelCtrl().getPanelurl(context);
    //http://192.168.2.71:9393/TouchPanel
    _responseTouchPanel.loadPanel(pnlUrl);
  }

  void loadGroupPanel() {
    String grpPnlUrl = PosPanelCtrl().getGrpPanelurl(context);
    _responseGrpPnlList.grpPnlList(grpPnlUrl + '/' + activeTouchPanel);
  }

  void loadItemPanel() {
    String groupId = activeGroupPanel.toString();
    String itemPnlUrl = PosPanelCtrl().getItemPanelurl(context);

    _responseItemPnlList
        .itemPnlList(itemPnlUrl + '/' + activeTouchPanel + '/' + groupId);
  }

  Widget touchEntryForm(double btnheight) {
    return Stack(
      children: [
        Positioned(
          top: btnheight,
          left: Palette.stdspacer_widht,
          child: Container(
            width: Palette.restsalesitemwidth() - 4,
            height: Palette.stdbutton_height * 2.74,
            decoration: BoxDecoration(
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
                                        text: 'TOUCH CODE',
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
                    width: Palette.stdbutton_width * 2.0,
                    height: Palette.onelineheigth() * 0.6,
                    child: TextField(
                      controller: txt1,
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
                  top: 46,
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
                                        text: 'DESCRIPTION',
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
                  top: 42,
                  left: 116,
                  child: Container(
                    width: Palette.stdbutton_width * 3.0,
                    height: Palette.onelineheigth() * 0.8,
                    child: TextField(
                      controller: txt2,
                      keyboardType: TextInputType.multiline,
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
                  top: 96,
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
                                        text: 'POS SCREEN\r\nTYPE',
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
                  top: 89,
                  left: 108,
                  child: Container(
                    width: Palette.stdbutton_width * 3.6,
                    height: Palette.onelineheigth() * 2,
                    child: Column(children: <Widget>[
                      Container(
                        width: Palette.stdbutton_width * 3.6,
                        height: Palette.onelineheigth() * 0.6,
                        child: ListTile(
                          title: const Text('Retail Screen'),
                          leading: Radio<touchCharacter>(
                            value: touchCharacter.RT,
                            groupValue: _touchC,
                            onChanged: (touchCharacter value) {
                              setState(() {
                                _touchC = value;
                                switchTouchByClick(_touchC);
                              });
                            },
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 0.0),
                          dense: true,
                        ),
                      ),
                      Container(
                        width: Palette.stdbutton_width * 3.6,
                        height: Palette.onelineheigth() * 0.6,
                        child: ListTile(
                          title: const Text('Food & Beverage Screen'),
                          leading: Radio<touchCharacter>(
                            value: touchCharacter.FB,
                            groupValue: _touchC,
                            onChanged: (touchCharacter value) {
                              setState(() {
                                _touchC = value;
                                switchTouchByClick(_touchC);
                              });
                            },
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0.0, horizontal: 0.0),
                          dense: true,
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
        //------------
      ],
    );
  }

  Widget pluForm() {
    return Stack(
      children: [
        Positioned(
          top: 555,
          left: 60,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(
                width: Palette.entrypanelwidth(),
                height: Palette.onelineheigth() * 0.7,
                child: Row(
                  children: [
                    Container(
                      width: Palette.pluinoutwidth(),
                      height: Palette.onelineheigth() * 0.7,
                      padding: const EdgeInsets.all(2),
                      child: TextField(
                        controller: _posinput.txtPlu,
                        // focusNode: fcn1,
                        onSubmitted: (result) {
                          var tl = result.length;
                          if (tl > 0) {
                            txtinputEntry("ENTER");
                          }
                        },
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8.0),
                          labelStyle: TextStyle(color: Colors.grey),
                          labelText: 'Entry: here: ',
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: CsiStyle().primaryColor)),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: Palette.pluinoutwidth() * 0.3,
                      height: Palette.onelineheigth() * 0.7,
                      padding: const EdgeInsets.fromLTRB(2, 2, 8, 2),
                      child: TextField(
                        controller: _posinput.txtQty,
                        onSubmitted: (value) {},
                        onChanged: (text) {},
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8.0),
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: CsiStyle().primaryColor)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void onLogPanelError(String error) {}

  @override
  void onLogPanelSuccess(List<TouchPanel> _vpoTouchPanel) {
    touchpnlList = _vpoTouchPanel;
    // loadFirstGroupPanel(touchpnlList);
  }

  @override
  void onAddPanelError(String error) {}

  @override
  void onAddPanelSuccess(String ok) {
    //setState(() {
    if (lastaction == 0) {
      // loadPanel();
    } else if (lastaction == 1) {
      loadGroupPanel();
    } else if (lastaction == 2) {
      loadItemPanel();
    } else {
      clsTouch();
    }
    //});
  }

  @override
  void onPluListError(String error) {}

  @override
  void onPluListSuccess(List<CsPlu> _cspluslist) {
    searchPLU(context, _cspluslist);
  }

  @override
  void onPluError(String error) {}

  @override
  void onPluSuccess(CsPlu _csplus) {
    //---from searchPLU selection ready
    if (_representC == representCharacter.plu) {
      csPlus = _csplus;
      getPlu(_csplus);
    } else if (_representC == representCharacter.setPlu) {
      getSetPlu(_csplus);
    } else {
      getStyle(_csplus);
    }
  }

  @override
  void ongrpPnlListError(String error) {}

  @override
  void ongrpPnlListSuccess(List<GroupPanel> _vpoTouchPanel) {
    if (_vpoTouchPanel == null || _vpoTouchPanel.length == 0) {
      groupPanelList = null;
    } else {
      activeTouchPanel = _vpoTouchPanel[0].touchPanelType;
      activeGroupPanel = _vpoTouchPanel[0].groupButtonId;
      groupPanelList = _vpoTouchPanel;
      // setCurGroupImgUrl();
      setState(() {});
      loadItemPanel();
    }
  }

  @override
  void onitemPnlListError(String error) {}

  @override
  void onitemPnlListSuccess(List<ItemPanel> _vpoTouchPanel) {
    if (_vpoTouchPanel == null || _vpoTouchPanel.length == 0) {
      itemPanelList = null;
    } else {
      itemPanelList = _vpoTouchPanel;
      //  setCurImgUrl();
      setState(() {});
    }
  }

  // void setCurImgUrl() async {
  //   for (var itm in itemPanelList) {
  //     itm.itemButtonImage =
  //         await PosPanelCtrl().getCurrentIP(itm.itemButtonImage);
  //   }
  // }

  // void setCurGroupImgUrl() async {
  //   for (var itm in groupPanelList) {
  //     itm.groupButtonImage =
  //         await PosPanelCtrl().getCurrentIP(itm.groupButtonImage);
  //   }
  // }
}
