import 'package:com_csith_geniuzpos/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:com_csith_geniuzpos/resources/palette.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_contents.dart';
import 'package:com_csith_geniuzpos/screens/retails/components/rt_framebtn.dart';

class RetailsBody extends StatelessWidget {
  // final TrackingScrollController scrollController;

  const RetailsBody({
    Key key,
    //  @required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(children: [
        // frameBUtton(scrollController),
        //  retailsContents(scrollController),
        // frameBUtton(),
        retailsContents(),
        //  frmaebtn7(context),
        Container(child: pluForm())
      ]),
    );
  }

  // var txt = TextEditingController();
  // var focusnode = FocusNode();
  Widget pluForm() {
    return Stack(
      children: [
        Positioned(
          bottom: 140,
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
                        //textInputAction: TextInputAction.go,
                        autofocus: true,
                        //controller: txt,
                        //focusNode: focusnode,
                        onSubmitted: (value) {
                          // getBISTOH(value.trim());
                        },
                        onChanged: (text) {
                          // getBISTOH(text.trim());
                        },
                        // onChanged: (value) => _name = value.trim(),
                        decoration: InputDecoration(
                          // prefixIcon: Icon(
                          //   Icons.add_business_rounded,
                          //   color: MyStyle().darkColor,
                          // ),
                          labelStyle: TextStyle(color: Colors.grey),
                          // labelText: 'Entry: Plu here: ',
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
                      padding: const EdgeInsets.all(2),
                      child: TextField(
                        //textInputAction: TextInputAction.go,
                        autofocus: true,
                        //controller: txt,
                        //focusNode: focusnode,
                        onSubmitted: (value) {
                          // getBISTOH(value.trim());
                        },
                        onChanged: (text) {
                          // getBISTOH(text.trim());
                        },
                        // onChanged: (value) => _name = value.trim(),
                        decoration: InputDecoration(
                          // prefixIcon: Icon(
                          //   Icons.add_business_rounded,
                          //   color: MyStyle().darkColor,
                          // ),
                          labelStyle: TextStyle(color: Colors.grey),
                          //labelText: 'Entry: Plu here: ',
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
}
