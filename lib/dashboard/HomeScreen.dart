
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
bool hasRequest=false;
final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
SheetController controller = SheetController();

@override
  void initState() {
    controller.hide();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                  setState(() {
                    controller.show();
                  });
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('New Request',
                style: TextStyle(color: AppColours.white,fontSize: 18,fontWeight: FontWeight.bold),
              ),
              Text('Pull me up please',
                style: TextStyle(color: AppColours.white,fontSize: 12),
              ),
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
          Padding(
            padding: const EdgeInsets.only(left: 6,bottom: 6),
            child: Text("From",style: TextStyle(color: AppColours.white,fontSize: 16),),
          ),
          CommonWidgets().requestTextContainer("text",Icons.location_on_outlined),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 6,bottom: 6),
            child: Text("To",style: TextStyle(color: AppColours.white,fontSize: 16),),
          ),
          CommonWidgets().requestTextContainer("text",Icons.location_on_outlined),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6,bottom: 6),
                      child: Text("Date",style: TextStyle(color: AppColours.white,fontSize: 16),),
                    ),
                    CommonWidgets().requestTextContainer("text",Icons.location_on_outlined),
                  ],
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 6,bottom: 6),
                      child: Text("Time",style: TextStyle(color: AppColours.white,fontSize: 16),),
                    ),
                    CommonWidgets().requestTextContainer("text",Icons.location_on_outlined),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 6,bottom: 6),
            child: Text("Comments",style: TextStyle(color: AppColours.white,fontSize: 16),),
          ),
          CommonWidgets().requestTextContainer("text",Icons.location_on_outlined),
          SizedBox(height: 20,),
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