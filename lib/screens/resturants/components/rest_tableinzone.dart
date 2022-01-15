import 'package:com_csith_geniuzpos/data/possales/tableusagemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/models/buttons/padbuttons.dart';
import 'package:com_csith_geniuzpos/screens/resturants/components/rest_tableonposition.dart';
import 'package:com_csith_geniuzpos/services/response/posfnc_response.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RestSeatTableInZone extends StatefulWidget {
  final PosFncCallResponse responseInput;
  const RestSeatTableInZone({Key key, @required this.responseInput})
      : super(key: key);

  @override
  _RestSeatTableInZone createState() => _RestSeatTableInZone();
}

class _RestSeatTableInZone extends State<RestSeatTableInZone>
    implements TableAddCallBack {
  TableAddCallResponse _tablectrl;
  @override
  void dispose() {
    super.dispose();
    // Hive.close();
  }

  @override
  void initState() {
    _tablectrl = new TableAddCallResponse(this);
    super.initState();
  }

  @override
  void onCallTableAddError(String error) {}

  @override
  void onCallTableAddSuccess(String result) {
    setState(() {});
  }

  bool checkList = false;
  int countTable = 0;

  final _formKey = GlobalKey<FormState>();
  final df = new NumberFormat("##0.00", "en_US");

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  double layoutheight = Palette.stdbutton_height * 8 + 15;
  double layoutwidth =
      (Palette.stdbutton_width + Palette.stdspacer_widht - 1.25) * 12.5 / 9 * 8;
  PadButton poszone = stdButtuon14[0];
  double _x;
  double _y;
  @override
  Widget build(BuildContext context) {
    context.watch<RestTableUsageModel>().getItem();
    return Consumer<RestTableUsageModel>(builder: (context, model, child) {
      //  _tables();
      return Stack(
        children: [
          Positioned(
            top: Palette.fullsalesheadcheight() + 30,
            left: Palette.stdspacer_widht,
            child: GestureDetector(
              onTapDown: (TapDownDetails details) => _onTapDown(details),
              onTapUp: (TapUpDetails details) => _onTapUp(details),
              onTap: () {
                inputItemDialog(context, 'add', 100, _x - 67, _y - 62);
              },
              child: Container(
                height: layoutheight,
                width: layoutwidth,
                decoration: BoxDecoration(
                    color: Palette.stdbutton_theme_4,
                    border: Border(
                      top: BorderSide(width: 1.0, color: Colors.grey),
                      left: BorderSide(width: 1.0, color: Colors.grey),
                      right: BorderSide(width: 1.0, color: Colors.grey),
                      bottom: BorderSide(width: 1.0, color: Colors.grey),
                    )),
                child: Container(
                  height: layoutheight * 0.8,
                  width: layoutwidth * 0.6,
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                        image: ExactAssetImage(poszone.imageUrl),
                        fit: BoxFit.fitHeight,
                      ),
                      // image: DecorationImage(
                      //   image: NetworkImage(poszone.imageUrl),
                      //   fit: BoxFit.fill,
                      // ),
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.transparent),
                        left: BorderSide(width: 1.0, color: Colors.transparent),
                        right:
                            BorderSide(width: 1.0, color: Colors.transparent),
                        bottom:
                            BorderSide(width: 1.0, color: Colors.transparent),
                      )),
                  child: SingleChildScrollView(
                      child: Theme(
                    data:
                        Theme.of(context).copyWith(dividerColor: Colors.white),
                    child: Container(),
                  )),
                ),
              ),
            ),
          ),
          for (var i in model.inventoryList)
            tableOnPositionButtons(
                context, widget.responseInput, stdButtuon14[1], i)
        ],
      );
    });
  }

  _onAddTable(BuildContext context, String zoneno, String tableno, String info,
      double _x, double _y) {
    _tablectrl.doAddTable(context, zoneno, tableno, info, _x, _y);
  }

  _onTapDown(TapDownDetails details) {
    _x = details.globalPosition.dx;
    _y = details.globalPosition.dy;
  }

  _onTapUp(TapUpDetails details) {
    _x = details.globalPosition.dx;
    _y = details.globalPosition.dy;
  }

  inputItemDialog(
      BuildContext context, String action, int index, double _x, double _y) {
    var inventoryDb = Provider.of<RestTableUsageModel>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            height: layoutheight * 0.6,
            width: layoutwidth * 0.6,
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 40,
            ),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      action == 'add' ? 'Add Tables' : 'Update Tables',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: nameController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Table No. cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Table No.',
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Item description cannot be empty';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Item description',
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                if (action == 'add') {
                                  _onAddTable(
                                      context,
                                      'Z02',
                                      nameController.text,
                                      descriptionController.text,
                                      _x,
                                      _y);
                                }

                                nameController.clear();
                                descriptionController.clear();

                                inventoryDb.getItem();

                                Navigator.pop(context);
                              }
                            },
                            color: Colors.green[600],
                            child: Text(
                              action == 'add' ? 'Add' : 'update',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 200,
                          ),
                          RaisedButton(
                              color: Palette.facebookbluee,
                              child: Text(
                                'Cacel',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
