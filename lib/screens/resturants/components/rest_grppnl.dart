import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/data/constdata.dart';
import 'package:com_csith_geniuzpos/models/models.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_grppanel.dart';
import 'package:com_csith_geniuzpos/data/posfunctions/posinput.dart';

typedef void GrpPnlBtnListCallback(PosButton input);

class ResttproductGroupPanel extends StatefulWidget {
  final double starttop;
  final double startleft;
  final GrpPnlBtnListCallback pnlbtnInputs;

  const ResttproductGroupPanel({
    Key key,
    @required this.starttop,
    @required this.startleft,
    @required this.pnlbtnInputs,
  }) : super(key: key);
  @override
  _ResttproductGroupPanel createState() => _ResttproductGroupPanel();
}

class _ResttproductGroupPanel extends State<ResttproductGroupPanel> {
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
            width: Palette.stdbutton_width * (8 / 6) + Palette.stdspacer_widht,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(width: 1.0, color: Colors.white),
                    left: BorderSide(width: 1.0, color: Colors.white),
                    right: BorderSide(width: 1.0, color: Colors.white),
                    bottom: BorderSide(width: 1.0, color: Colors.white),
                  )),
              child: InkWell(
                onTap: () {},
                child: SingleChildScrollView(
                  child: Theme(
                    data:
                        Theme.of(context).copyWith(dividerColor: Colors.white),
                    child: DataTable2(
                      dataRowHeight:
                          Palette.stdbutton_height + Palette.stdspacer_widht,
                      headingRowHeight: 0,
                      columnSpacing: 0,
                      horizontalMargin: 0,
                      minWidth:
                          Palette.stdbutton_width + Palette.stdspacer_widht,
                      showCheckboxColumn: false,
                      columns: PosInput().kTableColumn1,
                      rows: List<DataRow>.generate(stdButtuon3.length, (index) {
                        PosButton bosbtn = stdButtuon3[index];
                        return DataRow.byIndex(index: index, cells: <DataCell>[
                          DataCell(Container(
                              decoration: BoxDecoration(
                                  color: Palette.stdbutton_theme_6,
                                  border: Border(
                                    top: BorderSide(
                                        width: 1.0, color: Colors.white),
                                    left: BorderSide(
                                        width: 1.0, color: Colors.white),
                                    right: BorderSide(
                                        width: 1.0, color: Colors.white),
                                    bottom: BorderSide(
                                        width: 1.0, color: Colors.white),
                                  )),
                              child: SizedBox(
                                height: Palette.stdbutton_height +
                                    Palette.stdspacer_widht,
                                width: Palette.stdbutton_width * (8 / 6) +
                                    Palette.stdspacer_widht,
                                child: Center(
                                    child: PanelBox(
                                        user: bosbtn,
                                        pnlbtnInput: (PosButton input) {
                                          widget.pnlbtnInputs(input);
                                        })),
                              ))),
                        ]);
                      }),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
