import 'dart:async';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:convert' as JSON;
import 'package:visnagarbullion/LiveRate/rate_module.dart';
import '../MyConstants.dart';
import '../Notiflyvariblae.dart';
import 'comex_module.dart';

class LiveRate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsScreenState();
  }
}


class _NewsScreenState extends State<LiveRate> {
  final List<RateModel> itemsRate = [];
  final List<ComexModel> comexArry = [];
  final List<ComexModel> FutureArry = [];
  final List<ComexModel> NextArry = [];

  List RateShares=null;
  List ComexShared=null;
  List FutureShared=null;
  List NextShared=null;

  List<String> ComexTemporery = [];
  List<String> FutureTemporery = [];
  List<String> NextTemporery = [];


  String RateOldData='';
  String ComexOld='';
  String FutureOld='';
  String NextOld='';


  bool buy_visible = false ;
  bool sell_visible = false ;
  bool high_visible = false ;
  bool low_visible = false ;
  bool lable_high_low = false ;
  bool liverate_availble = false ;
  bool lablelive = false ;


  bool _selectedIndex = false;


  bool comexheadingline =false;
  bool comexlistview =false;

  bool futureheadingline =false;
  bool futurelistview =false;

  bool Nextheadingline =false;
  bool Nextlistview =false;

  var Lable="HIGH/LOW";
  var Referance_Data="";
  String Bid="";
  String Ask="";
  String High="";
  String Low="";

 // var text_color=null;
 // var text_colorAsk=null;






  @override
  void initState() {
    NotifySocketUpdate.controller_maindata = StreamController();


    super.initState();
     // getContactData();
    getMainRate();


    NotifySocketUpdate.controller_maindata.stream.asBroadcastStream().listen((event) {
      print("!!!!!!!!!! Socket Update Notify");
      getMainRate();
    });
  }

  @override
  void dispose() {
    NotifySocketUpdate.controller_maindata?.close();
    super.dispose();
  }






  // bool widgetVisible = true ;
  // void showWidget(){
  //   setState(() {
  //     widgetVisible = true ;
  //   });
  // }
  // void hideWidget(){
  //   setState(() {
  //     widgetVisible = false ;
  //   });
  // }

  // getContactData() async {
  //
  //   SocketIOManager manager = SocketIOManager();
  //   SocketIO socket = await manager.createInstance(SocketOptions('http://starlinejewellers.in:10004'));
  //   socket.connect();
  //   if(socket.isConnected() != null){
  //     //print("connected...");
  //     socket.emit("ClientData", ["visnagarspot"]);
  //     socket.emit("room", ["visnagarspot"]);
  //     socket.on('ClientData', (Referance_Data2) {
  //       Referance_Data=json.encode(Referance_Data2);
  //
  //       setClientData(json.encode(Referance_Data2));
  //      // print(Referance_Data);
  //
  //
  //     });
  //     socket.on('ClientHeaderDetails', (data2) {
  //
  //       setClientHeaderDetails(json.encode(data2));
  //
  //     });
  //
  //     socket.on('message', (data) {
  //       setMainRate(json.encode(data));
  //
  //
  //     });
  //
  //
  //
  //    }
  //
  //
  //
  // }



  /*setMainRate(String Responce) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('MainRate', Responce);
    getMainRate();
  }
*/
  // setClientHeaderDetails(String Responce) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('ClientHeaderDetails', Responce);
  //
  // }




  getMainRate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String dataNaib = prefs.getString('MainRate');
    String data222 = prefs.getString('ClientHeaderDetails');
    Referance_Data = prefs.getString('ClientData');

    var Liverates = jsonDecode(data222)['Data'];
    final List responseBody = JSON.jsonDecode(Liverates);
    buy_visible = responseBody[0]['BuyRate'];
    sell_visible = responseBody[0]['SellRate'];
    high_visible = responseBody[0]['HighRate'];
    low_visible = responseBody[0]['LowRate'];
    liverate_availble = responseBody[0]['RateDisplay'];
    if(mounted) {
      setState(() {
        if(responseBody[0]['HighRate']==false && responseBody[0]['LowRate']==false){
          lable_high_low=false;
        }else{
          lable_high_low=true;
          if(responseBody[0]['HighRate']==true && responseBody[0]['LowRate']==true){
            Lable="HIGH/LOW";
          }else{
            if(responseBody[0]['HighRate']==true){
              Lable="HIGH";
            } else{
              Lable="LOW";

            }

          }
        }

        if(responseBody[0]['RateDisplay']==false){
          lablelive=true;
        }else{
          lablelive=false;

        }
      });
    }

    //-------------------------



    itemsRate.clear();
    comexArry.clear();
    FutureArry.clear();
    NextArry.clear();


    ComexTemporery.clear();
    FutureTemporery.clear();
    NextTemporery.clear();





      final Map<String, dynamic> responseData = json.decode(dataNaib);
      responseData['Rate'].forEach((newsDetail) {
        final RateModel news = RateModel(
            SymbolId: newsDetail['SymbolId'],
            Symbol: newsDetail['Symbol'],
            Bid: newsDetail['Bid'],
            Ask: newsDetail['Ask'],
            High: newsDetail['High'],
            Low: newsDetail['Low'],
            Source: newsDetail['Source'],
            colorvarask:Colors.white,
            testcolorask:Colors.black,
            colorvarsell:Colors.white,
            testcolorsell:Colors.black

        );

        if(mounted) {
          setState(() {
            itemsRate.add(news);

          });
        }
      });

      RateOldData=dataNaib;





    // print(Referance_Data);


    final List Referance_DataRes = JSON.jsonDecode(Referance_Data);
    final List Refrance = jsonDecode(dataNaib)['Refrance'] as List;
    // print(Refrance.length);
    // print(Referance_DataRes.length);


// using with name

    for(var j = 0; j < Referance_DataRes.length; j++){
      for(var i = 0; i < Refrance.length; i++){
        if(Refrance[i]['symbol']==Referance_DataRes[j]['Source']){
          Bid=Refrance[i]['Bid'].toString();
          Ask=Refrance[i]['Ask'].toString();
          High=Refrance[i]['High'].toString();
          Low=Refrance[i]['Low'].toString();
        }
      }

      if(Referance_DataRes[j]['IsDisplay'].toString()=='true'){
        if(Referance_DataRes[j]['Source'].toString()=='XAGUSD'||Referance_DataRes[j]['Source'].toString()=='XAUUSD'||Referance_DataRes[j]['Source'].toString()=='INRSpot'){


          ComexTemporery.add("{\"Bid\":\""+Bid+"\"," +
              "\"Ask\":\""+Ask+"\"}");


          ComexModel comnews = ComexModel(
              Symbol_Name: ''+Referance_DataRes[j]['Symbol_Name'],
              Bid: ''+Bid,
              Ask: ''+Ask,
              High: ''+High,
              Low: ''+Low,
              backcolorcomexBID: Colors.white,
              testcolorcomexBID: Colors.black,
              backcolorcomexSELL: Colors.white,
              testcolorcomexSELL: Colors.black
          );

          ComexOld="{\"comexold\":"+ComexTemporery.toString()+"}";
          //print(ComexOld);
          comexArry.add(comnews);


        }

        //ComexOldData=FutureArry as String;


      }
      if(comexArry.length == 0){
        comexheadingline=false;
        comexlistview=false;
      }else{
        comexheadingline=true;
        comexlistview=true;
      }
    }


    //futurearry
    for(var j = 0; j < Referance_DataRes.length; j++){
      for(var i = 0; i < Refrance.length; i++){
        if(Refrance[i]['symbol']==Referance_DataRes[j]['Source']){
          Bid=Refrance[i]['Bid'].toString();
          Ask=Refrance[i]['Ask'].toString();
          High=Refrance[i]['High'].toString();
          Low=Refrance[i]['Low'].toString();
        }
      }

      if(Referance_DataRes[j]['IsDisplay'].toString()=='true'){
        if(Referance_DataRes[j]['Source'].toString()=='gold'||Referance_DataRes[j]['Source'].toString()=='silver'){

          FutureTemporery.add("{\"Bid\":\""+Bid+"\"," +
              "\"Ask\":\""+Ask+"\"}");

          ComexModel comnews = ComexModel(
              Symbol_Name: ''+Referance_DataRes[j]['Symbol_Name'],
              Bid: ''+Bid,
              Ask: ''+Ask,
              High: ''+High,
              Low: ''+Low,
              backcolorcomexBID: Colors.white,
              testcolorcomexBID: Colors.black,
              backcolorcomexSELL: Colors.white,
              testcolorcomexSELL: Colors.black
          );

          FutureOld="{\"comexold\":"+FutureTemporery.toString()+"}";
          print(ComexOld);
          FutureArry.add(comnews);
        }

      }
      if(FutureArry.length == 0){
        futureheadingline=false;
        futurelistview=false;
      }else{
        futureheadingline=true;
        futurelistview=true;
      }
    }

    //next
    for(var j = 0; j < Referance_DataRes.length; j++){
      for(var i = 0; i < Refrance.length; i++){
        if(Refrance[i]['symbol']==Referance_DataRes[j]['Source']){
          Bid=Refrance[i]['Bid'].toString();
          Ask=Refrance[i]['Ask'].toString();
          High=Refrance[i]['High'].toString();
          Low=Refrance[i]['Low'].toString();
        }
      }

      if(Referance_DataRes[j]['IsDisplay'].toString()=='true'){
        if(Referance_DataRes[j]['Source'].toString()=='goldnext'||Referance_DataRes[j]['Source'].toString()=='silvernext'){

          NextTemporery.add("{\"Bid\":\""+Bid+"\"," +
              "\"Ask\":\""+Ask+"\"}");

          ComexModel comnews = ComexModel(
              Symbol_Name: ''+Referance_DataRes[j]['Symbol_Name'],
              Bid: ''+Bid,
              Ask: ''+Ask,
              High: ''+High,
              Low: ''+Low,
              backcolorcomexBID: Colors.white,
              testcolorcomexBID: Colors.black,
              backcolorcomexSELL: Colors.white,
              testcolorcomexSELL: Colors.black
          );


          NextOld="{\"comexold\":"+NextTemporery.toString()+"}";
          NextArry.add(comnews);
        }


      }
      if(NextArry.length == 0){
        Nextheadingline=false;
        Nextlistview=false;
      }else{
        Nextheadingline=true;
        Nextlistview=true;
      }
    }




  }

  // setClientData(String Responce) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('ClientData', Responce);
  //
  // }

  // SharevalueRate(List SharevalueRate) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setStringList('SharevalueRate', SharevalueRate);
  //
  // }


  // OldValueLiveRateBid(String bid) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //
  //   String bidvalue = prefs.getString('liveratebid');
  //   if(bidvalue.isEmpty){
  //     text_color = Colors.black;
  //
  //   }else{
  //     double BidLiveRateOld=double.parse(bidvalue);
  //     double BidLiveRateNew= double.parse(bid);
  //     if(BidLiveRateOld>BidLiveRateNew){
  //       text_color = Colors.red;
  //       prefs.setString('liveratebid', bid);
  //
  //
  //     }else if(BidLiveRateOld>BidLiveRateNew){
  //       text_color = Colors.green;
  //       prefs.setString('liveratebid', bid);
  //
  //     }
  //     else if(BidLiveRateOld==BidLiveRateNew){
  //       text_color = Colors.black;
  //       prefs.setString('liveratebid', bid);
  //
  //
  //     }
  //   }
  //
  //
  // }
  //
  // OldValueLiveRateAsk(String Ask,String index) async {
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String bidvalue = prefs.getString(index);
  //   if(bidvalue==null){
  //     text_colorAsk = Colors.black;
  //     prefs.setString(index, Ask);
  //     print('dineshhhhhhh==Black');
  //
  //
  //   }else{
  //
  //     if(mounted) {
  //       setState(() {
  //         double BidLiveRateOld=double.parse(bidvalue);
  //         double BidLiveRateNew= double.parse(Ask);
  //
  //         print('dineshhhhhhhOld==$BidLiveRateOld');
  //         print('dineshhhhhhh==$BidLiveRateNew');
  //
  //         if(BidLiveRateOld>BidLiveRateNew){
  //           text_colorAsk = Colors.red;
  //          // print('dineshhhhhhh==red');
  //           prefs.setString(index, Ask);
  //
  //
  //         }else{
  //           text_colorAsk = Colors.green;
  //          // print('dineshhhhhhh==greenn');
  //           prefs.setString(index, Ask);
  //
  //         }
  //
  //
  //
  //       });
  //     }
  //
  //
  //   }
  //
  //
  // }


  Widget build(BuildContext context) {


    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Visibility(child: Container(
              width: MediaQuery.of(context).size.width * 100,
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(0.0),
                color: Colors.white,

              ),
              child : Container(
                color:const Color(0xffDAE1E7),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          child : Column(
                              children: <Widget>[
                              Visibility(
                              visible: liverate_availble,
                                child:Container(
                                    padding: EdgeInsets.all(5),
                                    width: MediaQuery.of(context).size.width * 100,
                                    child : Text("Live Rate",
                                      textAlign: TextAlign.left,

                                      style: TextStyle(
                                          color: const Color(0xffBD8A3C),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )

                                ),
                              ),



                                Visibility(
                                    visible: liverate_availble,

                                    child:Container(
                                       width: MediaQuery.of(context).size.width * 100,
                                        child : Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 45,
                                              child: Container(
                                                  padding: EdgeInsets.all(7),

                                                  decoration: new BoxDecoration(
                                                    borderRadius: new BorderRadius.circular(0.0),
                                                    color: const Color(0xff293462),

                                                  ),
                                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  child : Text(
                                                    'PRODUCT',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,

                                                    ),
                                                  )

                                              ),
                                            ),
                                        Visibility(
                                          visible: buy_visible,
                                          child:Expanded(
                                            flex: 18,
                                            child: Container(
                                                padding: EdgeInsets.all(7),
                                                decoration: new BoxDecoration(
                                                  borderRadius: new BorderRadius.circular(0.0),
                                                  color: const Color(0xff293462),

                                                ),
                                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                child : Text(
                                                  'BUY',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,

                                                  ),
                                                )

                                            ),
                                          ),

                                        ),
                                        Visibility(
                                          visible: sell_visible,
                                          child:Expanded(
                                            flex: 18,
                                            child: Container(
                                                padding: EdgeInsets.all(7),

                                                decoration: new BoxDecoration(
                                                  borderRadius: new BorderRadius.circular(0.0),
                                                  color: const Color(0xff293462),

                                                ),
                                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                child : Text(
                                                  'SELL',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,

                                                  ),
                                                )

                                            ),
                                          ),

                                        ),
                                        Visibility(
                                          visible: lable_high_low,
                                          child:Expanded(
                                            flex: 27,
                                            child: Container(
                                                padding: EdgeInsets.all(7),

                                                decoration: new BoxDecoration(
                                                  borderRadius: new BorderRadius.circular(0.0),
                                                  color: const Color(0xff293462),

                                                ),
                                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                child : Text(Lable,
                                                  overflow: TextOverflow.ellipsis,

                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,

                                                  ),
                                                )

                                            ),
                                          ),
                                        ),



                                          ],
                                        )

                                )),
                                Visibility(
                                    visible: lablelive,
                                    child:Container(
                                        width: MediaQuery.of(context).size.width * 100,
                                        child:Container(
                                            padding: EdgeInsets.all(5),
                                            width: MediaQuery.of(context).size.width * 100,

                                            child : Text("Live Rate currently not available",
                                              textAlign: TextAlign.center,

                                              style: TextStyle(
                                                  color: const Color(0xffBD8A3C),
                                                  fontSize: 16),
                                            )

                                        ),


                                    )),


                              ]

                          )

                      ),
                    )
                  ],
                ),


              )

          ),),
          Visibility(
           visible: liverate_availble,
           child: ListView.builder(
          shrinkWrap: true, // new line
          physics: const ClampingScrollPhysics(),// new line
          itemCount: this.itemsRate.length,
          itemBuilder: _listViewItemBuilder
      ),
    ),

          Visibility(
            visible: comexheadingline,
            child: Container(
              width: MediaQuery.of(context).size.width * 100,
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(0.0),
                color: Colors.white,

              ),
              child : Container(
                color: const Color(0xffDAE1E7),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          child : Column(
                              children: <Widget>[
                                Visibility(
                                  child:Container(
                                      padding: EdgeInsets.all(5),
                                      width: MediaQuery.of(context).size.width * 100,
                                      child : Text("Comex Rate",
                                        textAlign: TextAlign.left,

                                        style: TextStyle(
                                            color:const Color(0xffBD8A3C),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )

                                  ),
                                ),



                                Visibility(
                                    visible: comexheadingline,
                                    child:Container(
                                        width: MediaQuery.of(context).size.width * 100,
                                        child : Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 40,
                                              child: Container(
                                                  padding: EdgeInsets.all(7),

                                                  decoration: new BoxDecoration(
                                                    borderRadius: new BorderRadius.circular(0.0),
                                                    color: const Color(0xff293462),

                                                  ),
                                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                  child : Text(
                                                    'SYMBOL',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,

                                                    ),
                                                  )

                                              ),
                                            ),
                                            Visibility(
                                              child:Expanded(
                                                flex: 20,
                                                child: Container(
                                                    padding: EdgeInsets.all(7),
                                                    decoration: new BoxDecoration(
                                                      borderRadius: new BorderRadius.circular(0.0),
                                                      color: const Color(0xff293462),

                                                    ),
                                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                    child : Text(
                                                      'BID',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,

                                                      ),
                                                    )

                                                ),
                                              ),

                                            ),
                                            Visibility(
                                              visible: sell_visible,
                                              child:Expanded(
                                                flex: 25,
                                                child: Container(
                                                    padding: EdgeInsets.all(7),

                                                    decoration: new BoxDecoration(
                                                      borderRadius: new BorderRadius.circular(0.0),
                                                      color: const Color(0xff293462),

                                                    ),
                                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                    child : Text(
                                                      'ASK',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,

                                                      ),
                                                    )

                                                ),
                                              ),

                                            ),
                                            Visibility(
                                              child:Expanded(
                                                flex: 25,
                                                child: Container(
                                                    padding: EdgeInsets.all(7),

                                                    decoration: new BoxDecoration(
                                                      borderRadius: new BorderRadius.circular(0.0),
                                                      color: const Color(0xff293462),

                                                    ),
                                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                    child : Text('HIGH',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,

                                                      ),
                                                    )

                                                ),
                                              ),
                                            ),
                                            Visibility(
                                              child:Expanded(
                                                flex: 20,
                                                child: Container(
                                                    padding: EdgeInsets.all(7),

                                                    decoration: new BoxDecoration(
                                                      borderRadius: new BorderRadius.circular(0.0),
                                                      color: const Color(0xff293462),

                                                    ),
                                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                    child : Text('LOW',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,

                                                      ),
                                                    )

                                                ),
                                              ),
                                            ),




                                          ],
                                        )

                                    )),


                              ]

                          )

                      ),
                    )
                  ],
                ),


              )

          ),),
          Visibility(
            visible: comexlistview,
            child: ListView.builder(
                shrinkWrap: true, // new line
                physics: const ClampingScrollPhysics(),// new line
                itemCount: this.comexArry.length,
                itemBuilder: _listViewItemBuilderComexrate
            ),
          ),


          Visibility(
            visible: futureheadingline,
            child: Container(
                width: MediaQuery.of(context).size.width * 100,
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(0.0),
                  color: Colors.white,

                ),
                child : Container(
                  color: const Color(0xffDAE1E7),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            child : Column(
                                children: <Widget>[
                                  Visibility(
                                    child:Container(
                                        padding: EdgeInsets.all(5),
                                        width: MediaQuery.of(context).size.width * 100,
                                        child : Text("Future Rate",
                                          textAlign: TextAlign.left,

                                          style: TextStyle(
                                              color: const Color(0xffBD8A3C),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )

                                    ),
                                  ),



                                  Visibility(
                                      visible: comexheadingline,
                                      child:Container(
                                          width: MediaQuery.of(context).size.width * 100,
                                          child : Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 40,
                                                child: Container(
                                                    padding: EdgeInsets.all(7),

                                                    decoration: new BoxDecoration(
                                                      borderRadius: new BorderRadius.circular(0.0),
                                                      color: const Color(0xff293462),

                                                    ),
                                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                    child : Text(
                                                      'SYMBOL',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,

                                                      ),
                                                    )

                                                ),
                                              ),
                                              Visibility(
                                                child:Expanded(
                                                  flex: 25,
                                                  child: Container(
                                                      padding: EdgeInsets.all(7),
                                                      decoration: new BoxDecoration(
                                                        borderRadius: new BorderRadius.circular(0.0),
                                                        color: const Color(0xff293462),

                                                      ),
                                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                      child : Text(
                                                        'BID',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,

                                                        ),
                                                      )

                                                  ),
                                                ),

                                              ),
                                              Visibility(
                                                visible: sell_visible,
                                                child:Expanded(
                                                  flex: 25,
                                                  child: Container(
                                                      padding: EdgeInsets.all(7),

                                                      decoration: new BoxDecoration(
                                                        borderRadius: new BorderRadius.circular(0.0),
                                                        color:const Color(0xff293462),

                                                      ),
                                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                      child : Text(
                                                        'ASK',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,

                                                        ),
                                                      )

                                                  ),
                                                ),

                                              ),
                                              Visibility(
                                                child:Expanded(
                                                  flex: 20,
                                                  child: Container(
                                                      padding: EdgeInsets.all(7),

                                                      decoration: new BoxDecoration(
                                                        borderRadius: new BorderRadius.circular(0.0),
                                                        color: const Color(0xff293462),

                                                      ),
                                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                      child : Text('HIGH',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,

                                                        ),
                                                      )

                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                child:Expanded(
                                                  flex: 20,
                                                  child: Container(
                                                      padding: EdgeInsets.all(7),

                                                      decoration: new BoxDecoration(
                                                        borderRadius: new BorderRadius.circular(0.0),
                                                        color: const Color(0xff293462),

                                                      ),
                                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                      child : Text('LOW',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,

                                                        ),
                                                      )

                                                  ),
                                                ),
                                              ),




                                            ],
                                          )

                                      )),


                                ]

                            )

                        ),
                      )
                    ],
                  ),


                )

            ),),
          Visibility(
            visible: futurelistview,
            child: ListView.builder(
                shrinkWrap: true, // new line
                physics: const ClampingScrollPhysics(),// new line
                itemCount: this.FutureArry.length,
                itemBuilder: _listViewItemBuilderFuture
            ),
          ),


          Visibility(
            visible: Nextlistview,
            child: Container(
                width: MediaQuery.of(context).size.width * 100,
                margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(0.0),
                  color: Colors.white,

                ),
                child : Container(
                  color: const Color(0xffDAE1E7),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                            child : Column(
                                children: <Widget>[
                                  Visibility(
                                    child:Container(
                                        padding: EdgeInsets.all(5),
                                        width: MediaQuery.of(context).size.width * 100,
                                        child : Text("Next Rate",
                                          textAlign: TextAlign.left,

                                          style: TextStyle(
                                              color: const Color(0xff293462),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )

                                    ),
                                  ),



                                  Visibility(
                                      visible: comexheadingline,
                                      child:Container(
                                          width: MediaQuery.of(context).size.width * 100,
                                          child : Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 40,
                                                child: Container(
                                                    padding: EdgeInsets.all(7),

                                                    decoration: new BoxDecoration(
                                                      borderRadius: new BorderRadius.circular(0.0),
                                                      color: const Color(0xff293462),

                                                    ),
                                                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                    child : Text(
                                                      'SYMBOL',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,

                                                      ),
                                                    )

                                                ),
                                              ),
                                              Visibility(
                                                child:Expanded(
                                                  flex: 25,
                                                  child: Container(
                                                      padding: EdgeInsets.all(7),
                                                      decoration: new BoxDecoration(
                                                        borderRadius: new BorderRadius.circular(0.0),
                                                        color: const Color(0xff293462),

                                                      ),
                                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                      child : Text(
                                                        'BID',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,

                                                        ),
                                                      )

                                                  ),
                                                ),

                                              ),
                                              Visibility(
                                                visible: sell_visible,
                                                child:Expanded(
                                                  flex: 25,
                                                  child: Container(
                                                      padding: EdgeInsets.all(7),

                                                      decoration: new BoxDecoration(
                                                        borderRadius: new BorderRadius.circular(0.0),
                                                        color: const Color(0xff293462),

                                                      ),
                                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                      child : Text(
                                                        'ASK',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,

                                                        ),
                                                      )

                                                  ),
                                                ),

                                              ),
                                              Visibility(
                                                child:Expanded(
                                                  flex: 20,
                                                  child: Container(
                                                      padding: EdgeInsets.all(7),

                                                      decoration: new BoxDecoration(
                                                        borderRadius: new BorderRadius.circular(0.0),
                                                        color: const Color(0xff293462),

                                                      ),
                                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                      child : Text('HIGH',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,

                                                        ),
                                                      )

                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                child:Expanded(
                                                  flex: 20,
                                                  child: Container(
                                                      padding: EdgeInsets.all(7),

                                                      decoration: new BoxDecoration(
                                                        borderRadius: new BorderRadius.circular(0.0),
                                                        color: const Color(0xff293462),

                                                      ),
                                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                                      child : Text('LOW',
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16,

                                                        ),
                                                      )

                                                  ),
                                                ),
                                              ),




                                            ],
                                          )

                                      )),


                                ]

                            )

                        ),
                      )
                    ],
                  ),


                )

            ),),
          Visibility(
            visible: Nextlistview,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),// new line
                itemCount: this.NextArry.length,
                itemBuilder: _listViewItemBuilderNext
            ),
          ),




        ],
      ),

    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index){

      var newsDetail = this.itemsRate[index];


    /* if(index==3){
        RateShares = jsonDecode(RateOldData)['Rate'] as List;

      }*/
     // int llll=RateShares.length;





    //OldValueLiveRateBid(newsDetail.Bid);
   // OldValueLiveRateAsk(itemsRate[index].Ask,itemsRate[index].SymbolId);

    //print(index);
    return Container(


      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      padding: EdgeInsets.fromLTRB(0.5, 0, 0.5, 0.5),

      constraints: const BoxConstraints(minWidth: double.infinity),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(0.0),
        color: Colors.black,
      ),
      child: Container(

          child:new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              new Column(
                children: <Widget>[
                  Container(
                    color:Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 45,
                          child: Container(
                              padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                              child : Text(newsDetail.Symbol+'',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14),
                              )

                          ),
                        ),

                    Visibility(
                      visible: buy_visible,
                      child: Expanded(
                        flex: 18,
                        child: Container(
                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(1),
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(5.0),
                              color: newsDetail.colorvarask,
                            ),
                            child : Text(newsDetail.Bid+'',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: newsDetail.testcolorask,
                                  fontSize: 14),
                            )



                      ),
                      ),
                    ),

                    Visibility(
                      visible: sell_visible,
                      child:Expanded(
                        flex: 18,
                        child: Container(

                            padding: EdgeInsets.all(4),
                            margin: EdgeInsets.all(1),

                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(5.0),
                              color: newsDetail.colorvarsell,
                            ),
                            child : Text(newsDetail.Ask+'',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: newsDetail.testcolorsell,
                                  fontSize: 14),
                            )

                        ),
                      ),


                    ),

                    Visibility(
                      visible: lable_high_low,
                      child:Expanded(
                        flex: 27,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            new Column(
                              children: <Widget>[
                                Container(
                                  color:Colors.white,
                                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                                  child: Row(
                                    children: <Widget>[
                                      Visibility(
                                        visible: high_visible,
                                        child:Expanded(
                                          child: Container(
                                              child : Text(newsDetail.High+'',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                              )

                                          ),
                                        ),

                                      ),

                                    ],
                                  ),

                                ),
                                Container(
                                  color:Colors.white,
                                  child: Row(
                                    children: <Widget>[
                                      Visibility(
                                        visible: low_visible,
                                        child: Expanded(
                                          child: Container(
                                              padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                                              child : Text(newsDetail.Low+'',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                              )

                                          ),
                                        ),
                                      )

                                    ],
                                  ),

                                ),
                              ],
                            ),


                          ],
                        ),
                      ),
                    ),


                      ],
                    ),

                  ),


                ],
              ),


            ],
          ),

      ),
    );
    //print(Referance_DataRes[i]['Symbol_Name']);

  }


  Widget _listViewItemBuilderComexrate(BuildContext context, int index){
    var newsDetail = this.comexArry[index];








    //var body = json.decode(comexArry.toString());

    //print(ComexShared);

 /*   var teshhh=comexArry.whereType<String>();
    print(teshhh); // {0: cricket, 1: football, 2: tennis, 3: baseball}*/


    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      padding: EdgeInsets.fromLTRB(0.5, 0, 0.5, 0.5),

      constraints: const BoxConstraints(minWidth: double.infinity),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(0.0),
        color: Colors.black,
      ),
      child: Container(

        child:new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            new Column(
              children: <Widget>[
                Container(
                  color:Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 40,
                        child: Container(
                            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),

                            child : Text(newsDetail.Symbol_Name+'',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14),
                            )

                        ),
                      ),

                      Visibility(
                        child:Expanded(
                          flex: 25,
                          child: Container(

                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.all(1),

                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                color: newsDetail.backcolorcomexBID,
                              ),
                              child : Text(newsDetail.Bid+'',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: newsDetail.testcolorcomexBID,
                                    fontSize: 14),
                              )

                          ),
                        ),
                      ),

                      Visibility(
                        child:Expanded(
                          flex: 25,
                          child: Container(

                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.all(1),
                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                color: newsDetail.backcolorcomexSELL,
                              ),
                              child : Text(newsDetail.Ask+'',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: newsDetail.testcolorcomexSELL,
                                    fontSize: 14),
                              )

                          ),
                        ),


                      ),
                      Visibility(
                        child:Expanded(
                          flex: 20,
                          child: Container(
                              child : Text(newsDetail.High+'',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14),
                              )

                          ),
                        ),


                      ),

                      Visibility(
                        child:Expanded(
                          flex: 20,
                          child: Container(
                              child : Text(newsDetail.Low+'',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14),
                              )

                          ),
                        ),


                      ),






                    ],
                  ),

                ),











              ],
            ),


          ],
        ),

      ),
    );


  }

  Widget _listViewItemBuilderFuture(BuildContext context, int index){
    var newsDetail = this.FutureArry[index];







    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      padding: EdgeInsets.fromLTRB(0.5, 0, 0.5, 0.5),

      constraints: const BoxConstraints(minWidth: double.infinity),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(0.0),
        color: Colors.black,
      ),
      child: Container(

        child:new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            new Column(
              children: <Widget>[
                Container(
                  color:Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 40,
                        child: Container(
                            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),

                            child : Text(newsDetail.Symbol_Name+'',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14),
                            )

                        ),
                      ),

                      Visibility(
                        child:   Expanded(
                          flex: 25,
                          child: Container(
                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.all(1),

                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                color: newsDetail.backcolorcomexBID,
                              ),
                              child : Text(newsDetail.Bid+'',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: newsDetail.testcolorcomexBID,
                                    fontSize: 14),
                              )

                          ),
                        ),
                      ),

                      Visibility(
                        child:Expanded(
                          flex: 25,
                          child: Container(
                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.all(1),

                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                color: newsDetail.backcolorcomexSELL,
                              ),

                              child : Text(newsDetail.Ask+'',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: newsDetail.testcolorcomexSELL,
                                    fontSize: 14),
                              )

                          ),
                        ),


                      ),
                      Visibility(
                        child:Expanded(
                          flex: 20,
                          child: Container(
                              child : Text(newsDetail.High+'',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14),
                              )

                          ),
                        ),


                      ),

                      Visibility(
                        child:Expanded(
                          flex: 20,
                          child: Container(
                              child : Text(newsDetail.Low+'',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14),
                              )

                          ),
                        ),


                      ),






                    ],
                  ),

                ),











              ],
            ),


          ],
        ),

      ),
    );


  }

  Widget _listViewItemBuilderNext(BuildContext context, int index){
    var newsDetail = this.NextArry[index];







    return Container(
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      padding: EdgeInsets.fromLTRB(0.5, 0, 0.5, 0.5),

      constraints: const BoxConstraints(minWidth: double.infinity),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(0.0),
        color: Colors.black,
      ),
      child: Container(

        child:new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            new Column(
              children: <Widget>[
                Container(
                  color:Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 40,
                        child: Container(
                            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),

                            child : Text(newsDetail.Symbol_Name+'',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14),
                            )

                        ),
                      ),

                      Visibility(
                        child:   Expanded(
                          flex: 25,
                          child: Container(

                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.all(1),

                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                color: newsDetail.backcolorcomexBID,
                              ),

                              child : Text(newsDetail.Bid+'',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: newsDetail.testcolorcomexBID,
                                    fontSize: 14),
                              )

                          ),
                        ),
                      ),

                      Visibility(
                        child:Expanded(
                          flex: 25,
                          child: Container(

                              padding: EdgeInsets.all(4),
                              margin: EdgeInsets.all(1),

                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                color: newsDetail.backcolorcomexSELL,
                              ),

                              child : Text(newsDetail.Ask+'',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: newsDetail.testcolorcomexSELL,
                                    fontSize: 14),
                              )

                          ),
                        ),


                      ),
                      Visibility(
                        child:Expanded(
                          flex: 20,
                          child: Container(
                              child : Text(newsDetail.High+'',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14),
                              )

                          ),
                        ),


                      ),

                      Visibility(
                        child:Expanded(
                          flex: 20,
                          child: Container(
                              child : Text(newsDetail.Low+'',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14),
                              )

                          ),
                        ),


                      ),






                    ],
                  ),

                ),











              ],
            ),


          ],
        ),

      ),
    );


  }



}



