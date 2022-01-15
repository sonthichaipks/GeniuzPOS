import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/models/models.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_grppanel.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';

typedef void PanelBtnListCallback(PosButton input);

class Rtproductpanel extends StatefulWidget {
  final double starttop;
  final double startleft;
  final PanelBtnListCallback pnlbtnInputs;
  final PosButton grpCode;

  const Rtproductpanel({
    Key key,
    @required this.starttop,
    @required this.startleft,
    @required this.pnlbtnInputs,
    @required this.grpCode,
  }) : super(key: key);
  @override
  _Rtproductpanel createState() => _Rtproductpanel();
}

class _Rtproductpanel extends State<Rtproductpanel> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.starttop,
      left: widget.startleft,
      child: Row(
        children: [
          Container(
            height: Palette.stdbutton_height * 6 + Palette.stdspacer_widht * 6,
            width: Palette.stdbutton_width * (8 / 6) * 3 +
                Palette.stdspacer_widht * 3,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.white),
                    left: BorderSide(width: 1.0, color: Colors.white),
                    right: BorderSide(width: 1.0, color: Colors.white),
                    bottom: BorderSide(width: 1.0, color: Colors.white),
                  )),
              child: SingleChildScrollView(
                child: Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.white),
                  child: DataTable2(
                    dataRowHeight:
                        Palette.stdbutton_height + Palette.stdspacer_widht,
                    headingRowHeight: 0,
                    columnSpacing: 6,
                    horizontalMargin: 6,
                    minWidth:
                        (Palette.stdbutton_width + Palette.stdspacer_widht) * 3,
                    showCheckboxColumn: false,
                    columns: PosInput().kTableColumn3,
                    rows: List<DataRow>.generate(stdButtuon5.length, (index) {
                      //int index = stdButtuon4.length;
                      PosButton bosbtn;
                      PosButton bosbtn1;
                      PosButton bosbtn2;
                      if (widget.grpCode.kybCode == '100000001') {
                        bosbtn = stdButtuon21[index];
                        bosbtn1 = stdButtuon23[index];
                        bosbtn2 = stdButtuon21[index];
                      } else {
                        bosbtn = stdButtuon5[index];
                        bosbtn1 = stdButtuon51[index];
                        bosbtn2 = stdButtuon52[index];
                      }
                      return DataRow.byIndex(index: index, cells: <DataCell>[
                        DataCell(Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 0),
                          child: Center(
                              child: PanelBox(
                                  user: bosbtn,
                                  pnlbtnInput: (PosButton input) {
                                    widget.pnlbtnInputs(input);
                                  })),
                        )),
                        DataCell(Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 0),
                          child: Center(
                              child: PanelBox(
                                  user: bosbtn1,
                                  pnlbtnInput: (PosButton input) {
                                    widget.pnlbtnInputs(input);
                                  })),
                        )),
                        DataCell(Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(0, 0.0, 0, 0),
                          child: Center(
                              child: PanelBox(
                                  user: bosbtn2,
                                  pnlbtnInput: (PosButton input) {
                                    widget.pnlbtnInputs(input);
                                  })),
                        )),
                      ]);
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
