
import 'package:elite_provider/global/AppColours.dart';
import 'package:elite_provider/global/CommonWidgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class HomeScreen extends StatefulWidget
{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
bool ifOnline=false;
SheetController controller = SheetController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Google Map",style: TextStyle(color: AppColours.white),),
              InkWell(
                onTap: (){
                  controller.show();
                },
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Text("All the requests will apear here one by one through a popup. Remember you have to accept or reject the 1st request to see the second request. For now to see the a dummy request please tap on this text",textAlign: TextAlign.center,style: TextStyle(color: AppColours.white),),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: RaisedButton(
                padding: EdgeInsets.all(18),
                color: ifOnline?Colors.green:Colors.red,
                child: Column(
                  children: [
                    Text(ifOnline?"Go Offline":"Go Online",style: TextStyle(color: AppColours.white,fontWeight: FontWeight.bold,fontSize: 18),),
                    Text(ifOnline?"You are now Online":"You are now Offline",style: TextStyle(color: AppColours.white,fontSize: 12),),
                     ],
                ),
                onPressed: (){
                    setState(() {
                      ifOnline=!ifOnline;
                    });
                }),
          ),
          buildSheet()
        ],
      )
    );
  }

Widget buildSheet() {
  return SlidingSheet(
    duration: const Duration(milliseconds: 600),
    //controller: controller,
    color: Colors.white,
    shadowColor: Colors.black26,
    elevation: 12,
    controller: controller,
    cornerRadius: 16,
    cornerRadiusOnFullscreen: 0.0,
    addTopViewPaddingOnFullscreen: true,
    isBackdropInteractable: true,
    snapSpec: SnapSpec(
      snap: true,
      positioning: SnapPositioning.relativeToAvailableSpace,
      snappings: const [
        SnapSpec.headerFooterSnap,
        0.6,
        SnapSpec.expanded,
      ],
      onSnap: (state, snap) {
       // print('Snapped to $snap');
      },
    ),
    //body: bui(),
    headerBuilder: (context, state) {
      return Container(
        height: 70,
        color: AppColours.golden_button_bg,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Row(
                children: [
                  Icon(Icons.request_page_outlined,color: AppColours.white,size: 35,),
                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('New Request (\$370)',
                        style: TextStyle(color: AppColours.white,fontSize: 18,fontWeight: FontWeight.bold),
                      ),
                      Text('Pull me up please',
                        style: TextStyle(color: AppColours.white,fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.keyboard_arrow_up,color: AppColours.white,size: 35,),
                      SizedBox(width: 10,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
    builder: buildChild,
  );
}

Widget buildChild(BuildContext context, SheetState state) {
  return Container(
    color: AppColours.black,
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CommonWidgets().requestTextContainer("From","Poplar St, Tyldesley, Manchester M29 8AX, United Kingdom",Icons.location_on_outlined),
          CommonWidgets().requestTextContainer("To","145 Elliott St, Tyldesley, Manchester M29 8FL, United Kingdom",Icons.location_on_outlined),
          Row(
            children: [
              Expanded(
                child: CommonWidgets().requestTextContainer("Date","24th March",Icons.date_range_outlined),

              ),
              SizedBox(width: 20,),
              Expanded(
                child: CommonWidgets().requestTextContainer("Time","9:25 AM",Icons.time_to_leave_outlined),
              )
            ],
          ),
          CommonWidgets().requestTextContainer("Comments","Be on time Please",Icons.comment_bank_outlined),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(child: RaisedButton(
                color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("Reject",style: TextStyle(color: AppColours.white,fontSize: 18),),
                  ),
                  onPressed: (){

                      controller.hide();
                  })),
              SizedBox(width: 20,),
              Expanded(child: RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("Accept",style: TextStyle(color: AppColours.white,fontSize: 18),),
                  ),
                  onPressed: (){
                    controller.hide();

                  })),
            ],
          )
        ],
      ),
    ),
  );
}
}