import 'dart:async';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:connectivity/connectivity.dart';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:convert' as JSON;
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;


import 'package:url_launcher/url_launcher.dart';

import '../MyConstants.dart';
import '../Notiflyvariblae.dart'; // named import (importing convert lib as JSON)

class ContactUs extends StatefulWidget {



  @override
  State<StatefulWidget> createState() => new _State();


}

class _State extends State<ContactUs> {

  var Address_client = "";
  var Address_client2 = "";
  var Address_client3 = "";

  var BookingNo1 = "";
  var BookingNo2 = "";
  var BookingNo3 = "";
  var BookingNo4 = "";
  var BookingNo5 = "";
  var BookingNo6 = "";
  var BookingNo7 = "";

  var Email1 = "";
  var Email2 = "";

  bool addressmainbar = false ;
  bool address_visible1 = false ;
  bool address_visible2 = false ;
  bool address_visible3 = false ;

  bool emailmain = false ;
  bool email_visible1 = false ;
  bool email_visible2 = false ;

  bool mainbooking = false ;
  bool booking_vsible1 = false ;
  bool booking_vsible2 = false ;
  bool booking_vsible3 = false ;
  bool booking_vsible4 = false ;
  bool booking_vsible5 = false ;
  bool booking_vsible6 = false ;
  bool booking_vsible7 = false ;


  TextEditingController et_name = TextEditingController();
  TextEditingController et_email = TextEditingController();
  TextEditingController et_message = TextEditingController();
  TextEditingController et_phone = TextEditingController();
  TextEditingController et_subject = TextEditingController();
  ProgressDialog _progressDialog = ProgressDialog();



  @override
  void initState() {

    NotifySocketUpdate.controller = StreamController();

    super.initState();
  //  getContactData();
    getcontactData();

    NotifySocketUpdate.controller.stream.asBroadcastStream().listen((event) {
      print("!!!!!!!!!! Socket Update Notify");
      getcontactData();
    });

  }

  @override
  void dispose() {
    NotifySocketUpdate.controller?.close();
    super.dispose();
  }


  /*@override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      getcontactData();
    });
  }*/

 
  // bool widgetVisible = true ;
  // void showWidget(){
  //   setState(() {
  //   });
  // }
  // void hideWidget(){
  //   setState(() {
  //     widgetVisible = false ;
  //   });
  // }

 /* void _clearCache() {
    DefaultCacheManager().emptyCache();
    setState(() {
    });
  }*/


  getcontactData() async {

    //_clearCache();

   // DefaultCacheManager manager = new DefaultCacheManager();
    //manager.emptyCache();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('ClientDataContact');

    //String stringValue =MyConstants.ClientDattaa;
    var Liverates = jsonDecode(stringValue)['Data'];
    final List responseBody = JSON.jsonDecode(Liverates);

    if(mounted) {
      setState(() {
        Address_client = responseBody[0]['Address_client'];
        Address_client2 = responseBody[0]['Address_client2'];
        Address_client3 = responseBody[0]['Address_client3'];
        BookingNo1 = responseBody[0]['BookingNo1'];
        BookingNo2 = responseBody[0]['BookingNo2'];
        BookingNo3 = responseBody[0]['BookingNo3'];
        BookingNo4 = responseBody[0]['BookingNo4'];
        BookingNo5 = responseBody[0]['BookingNo5'];
        BookingNo6 = responseBody[0]['BookingNo6'];
        BookingNo7 = responseBody[0]['BookingNo7'];
        Email1 = responseBody[0]['Email1'];
        Email2 = responseBody[0]['Email2'];

        if(Address_client.isEmpty && Address_client2.isEmpty && Address_client3.isEmpty){
          addressmainbar=false;
        }else{
          addressmainbar=true;
          if(Address_client.isEmpty){
            address_visible1 = false;
          }else{
            address_visible1 = true;

          }

          if(Address_client2.isEmpty){
            address_visible2 = false;
          }else{
            address_visible2 = true;

          }

          if(Address_client3.isEmpty){
            address_visible3 = false;
          }else{
            address_visible3 = true;

          }
        }

        //ooooooooooooo
        if(Email1.isEmpty && Email1.isEmpty){
          emailmain=false;
        }else{
          emailmain=true;
          if(Email1.isEmpty){
            email_visible1 = false;
          }else{
            email_visible1 = true;

          }

          if(Email2.isEmpty){
            email_visible2 = false;
          }else{
            email_visible2 = true;

          }
        }

        if(BookingNo1.isEmpty && BookingNo2.isEmpty && BookingNo3.isEmpty && BookingNo4.isEmpty && BookingNo5.isEmpty && BookingNo6.isEmpty && BookingNo7.isEmpty){
          mainbooking=false;
        }else{
          mainbooking=true;

          if(BookingNo1.isEmpty){
            booking_vsible1 = false;
          }else{
            booking_vsible1 = true;

          }

          if(BookingNo2.isEmpty){
            booking_vsible2 = false;
          }else{
            booking_vsible2 = true;

          }

          if(BookingNo3.isEmpty){
            booking_vsible3 = false;
          }else{
            booking_vsible3 = true;

          }

          if(BookingNo4.isEmpty){
            booking_vsible4 = false;
          }else{
            booking_vsible4 = true;

          }

          if(BookingNo5.isEmpty){
            booking_vsible5 = false;
          }else{
            booking_vsible5 = true;

          }

          if(BookingNo6.isEmpty){
            booking_vsible6 = false;
          }else{
            booking_vsible6 = true;

          }

          if(BookingNo7.isEmpty){
            booking_vsible7 = false;
          }else{
            booking_vsible7 = true;

          }



        }


      });
    }

    // using with name

  }


  setClientdata(String Responce) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('ClientDataContact', Responce);
    getcontactData();


  }

  // getContactData() async {
  //   print("Run");
  //   SocketIOManager manager = SocketIOManager();
  //   SocketIO socket = await manager.createInstance(SocketOptions('http://starlinejewellers.in:10004'));
  //   socket.connect();
  //   if(socket.isConnected() != null){
  //        print("connected...");
  //        socket.emit("ClientData", ["visnagarspot"]);
  //        socket.emit("ClientHeaderDetails", ["visnagarspot"]);
  //        socket.on('ClientHeaderDetails', (data2) {
  //
  //          print("RUNNNNNNN");
  //
  //          setState(() {
  //              setClientdata(json.encode(data2));
  //           });
  //
  //
  //
  //        });
  //
  //
  //   }else{
  //     print("Not connected...");
  //
  //   }
  // }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      SendFeedback();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      SendFeedback();
    } else {
      Fluttertoast.showToast(
        msg: "No Internet Connecttion",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        //timeInSecForIosWeb: 1,
        //  backgroundColor: Colors.black26,
        // textColor: Colors.white,
        //fontSize: 16.0
      );
    }
  }


  void SendFeedback() async {




    String ObjVariable = "{\"Name\":\"" + et_name.text +
        "\",\"Email\":\"" + et_email.text +
        "\",\"Phone\":\"" + et_phone.text +
        "\",\"Client\":\"" + MyConstants.ClientId +
        "\",\"Message\":\"" + et_message.text +
        "\",\"Sub\":\""+et_subject.text+"\"}";

    _progressDialog.showProgressDialog(context, textToBeDisplayed: 'Sending...',
        onDismiss: () {
          //things to do after dismissing -- optional
        });

    List<String> fieldList = [
      '<?xml version="1.0" encoding="utf-8"?>',
      '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">',
      '<soap:Body>',
      '<Feedback xmlns="http://tempuri.org/">',
      '<Obj>'+ObjVariable+'</Obj>',
      '</Feedback>',
      '</soap:Body>',
      '</soap:Envelope>'


    ];
    var envelope = fieldList.map((v) => '$v').join();
    print(envelope);

    http.Response response = await http.post(
        'http://starlinejewellers.in/WebService/WebService.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://tempuri.org/Feedback",
          "Host": "starlinejewellers.in"
          //"Accept": "text/xml"
        },
        body: envelope);

    var rawXmlResponse = response.body;
    // ignore: deprecated_member_use
    xml.XmlDocument parsedXml = xml.parse(rawXmlResponse);
    print("DataIs========" + parsedXml.text);
    _progressDialog.dismissProgressDialog(context);

    if (parsedXml.text
        .toString()
        .isEmpty) {

    } else {
      et_name.clear();
      et_email.clear();
      et_message.clear();
      et_phone.clear();
      et_subject.clear();

      _showMyDialog();

    }
  }


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Visnagar Bullion'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Thank You For Valuable Feedback.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
        children: <Widget>[

          Visibility(
            visible: addressmainbar,
            child: Container(
              width: MediaQuery.of(context).size.width * 100,
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(1),
              decoration: new BoxDecoration(
                borderRadius: new BorderRadius.circular(3.0),
                color: const Color(0xff293462),

              ),
              child : Container(
                  color: const Color(0xffFFFFFF),
                  child: Row(
              children: <Widget>[
              Expanded(
                flex: 20,
                child: Container(
                    child : Column(
                        children: <Widget>[
                          Icon(
                            Icons.location_on_outlined,
                            color: const Color(0xff293462),
                            size: 30.0,
                          ),


                        ]

                    )

                ),
              ),
      Expanded(
        flex: 80,
        child: Container(
            child : Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.all(2),
                      width: MediaQuery.of(context).size.width * 100,
                      child : Text("Address",
                        textAlign: TextAlign.left,

                        style: TextStyle(
                            color: const Color(0xff293462),
                            fontWeight: FontWeight.bold,

                            fontSize: 16),
                      )

                  ),
                  Visibility(
                      visible: address_visible1,
                      child:Container(
                      padding: EdgeInsets.all(2),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: MediaQuery.of(context).size.width * 100,
                      child : Text(Address_client,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16),
                      )

                  )),
                  Visibility(
                      visible: address_visible2,
                      child:Container(
                      padding: EdgeInsets.all(2),
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),

                          width: MediaQuery.of(context).size.width * 100,
                      child : Text(Address_client2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16),
                      )

                  )),
                  Visibility(
                      visible: address_visible3,
                      child:Container(
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.fromLTRB(0, 5, 0, 0),

                          width: MediaQuery.of(context).size.width * 100,
                          child : Text(Address_client3,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16),
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
            visible: emailmain,
            child: Container(
                width: MediaQuery.of(context).size.width * 100,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(1),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(3.0),
                  color: const Color(0xff293462),

                ),
                child : Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 20,
                        child: Container(
                            child : Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.email_outlined,
                                    color: const Color(0xff293462),
                                    size: 30.0,
                                  ),


                                ]

                            )

                        ),
                      ),
                      Expanded(
                        flex: 80,
                        child: Container(
                            child : Column(
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(2),
                                      width: MediaQuery.of(context).size.width * 100,
                                      child : Text("Email",
                                        textAlign: TextAlign.left,

                                        style: TextStyle(
                                            color: const Color(0xff293462),
                                            fontWeight: FontWeight.bold,

                                            fontSize: 16),
                                      )

                                  ),
                                  Visibility(
                                      visible: email_visible1,
                                      child:GestureDetector(
                                        onTap: (){
                                          launch("mailto:"+Email1);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(2),
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            width: MediaQuery.of(context).size.width * 100,
                                            child : Text(Email1,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )

                                        ),
                                      )
                                  ),
                                  Visibility(
                                      visible: email_visible2,
                                      child:GestureDetector(
                                        onTap: (){
                                          launch("mailto:"+Email2);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(2),
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            width: MediaQuery.of(context).size.width * 100,
                                            child : Text(Email2,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )

                                        ),
                                      )
                                  ),





                                ]

                            )

                        ),
                      )
                    ],
                  ),


                )

            ),),

          Visibility(
            visible: mainbooking,
            child: Container(
                width: MediaQuery.of(context).size.width * 100,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(1),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(3.0),
                  color: const Color(0xff293462),

                ),
                child : Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 20,
                        child: Container(
                            child : Column(
                                children: <Widget>[
                                  Icon(
                                    Icons.mobile_screen_share,
                                    color: const Color(0xff293462),
                                    size: 30.0,
                                  ),


                                ]

                            )

                        ),
                      ),
                      Expanded(
                        flex: 80,
                        child: Container(
                            child : Column(
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(2),
                                      width: MediaQuery.of(context).size.width * 100,
                                      child : Text("Booking Number",
                                        textAlign: TextAlign.left,

                                        style: TextStyle(
                                            color: const Color(0xff293462),
                                            fontWeight: FontWeight.bold,

                                            fontSize: 16),
                                      )

                                  ),
                                  Visibility(
                                      visible: booking_vsible1,
                                      child:GestureDetector(
                                        onTap: (){
                                          launch("tel://"+BookingNo1);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(2),
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            width: MediaQuery.of(context).size.width * 100,
                                            child : Text(BookingNo1,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )

                                        ),
                                      )
                                  ),
                                  Visibility(
                                      visible: booking_vsible2,
                                      child:GestureDetector(
                                        onTap: (){
                                          launch("tel://"+BookingNo2);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(2),
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            width: MediaQuery.of(context).size.width * 100,
                                            child : Text(BookingNo2,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )

                                        ),
                                      )
                                  ),
                                  Visibility(
                                      visible: booking_vsible3,
                                      child:GestureDetector(
                                        onTap: (){
                                          launch("tel://"+BookingNo3);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(2),
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            width: MediaQuery.of(context).size.width * 100,
                                            child : Text(BookingNo3,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )

                                        ),
                                      )
                                  ),
                                  Visibility(
                                      visible: booking_vsible4,
                                      child:GestureDetector(
                                        onTap: (){
                                          launch("tel://"+BookingNo4);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(2),
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            width: MediaQuery.of(context).size.width * 100,
                                            child : Text(BookingNo4,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )

                                        ),
                                      )
                                  ),
                                  Visibility(
                                      visible: booking_vsible5,
                                      child:GestureDetector(
                                        onTap: (){
                                          launch("tel://"+BookingNo5);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(2),
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            width: MediaQuery.of(context).size.width * 100,
                                            child : Text(BookingNo5,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )

                                        ),
                                      )
                                  ),
                                  Visibility(
                                      visible: booking_vsible6,
                                      child:GestureDetector(
                                        onTap: (){
                                          launch("tel://"+BookingNo6);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(2),
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            width: MediaQuery.of(context).size.width * 100,
                                            child : Text(BookingNo6,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )

                                        ),
                                      )
                                  ),
                                  Visibility(
                                      visible: booking_vsible7,
                                      child:GestureDetector(
                                        onTap: (){
                                          launch("tel://"+BookingNo7);
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(2),
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            width: MediaQuery.of(context).size.width * 100,
                                            child : Text(BookingNo7,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            )

                                        ),
                                      )
                                  ),



                                ]

                            )

                        ),
                      )
                    ],
                  ),


                )

            ),),

          Visibility(
            visible: true,
            child: Container(
                width: MediaQuery.of(context).size.width * 100,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(1),
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(3.0),
                  color: const Color(0xff293462),

                ),
                child : Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 100,
                        child: Container(
                            child : Column(
                                children: <Widget>[
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width * 100,
                                      child : Text("Write a Message",
                                        textAlign: TextAlign.center,

                                        style: TextStyle(
                                            color: const Color(0xff293462),
                                            fontSize: 16),
                                      )

                                  ),
                                  Container(
                                      padding: EdgeInsets.all(2),
                                      width: MediaQuery.of(context).size.width * 100,
                                      child : Text("Have Any Questions ? ",
                                        textAlign: TextAlign.center,

                                        style: TextStyle(
                                            color: const Color(0xff293462),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      )

                                  ),

                                  Container(
                                      padding: EdgeInsets.all(2),
                                      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                      child :TextField(
                                        controller: et_name,

                                        decoration: new InputDecoration(
                                            border: new OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(
                                                const Radius.circular(50.0),
                                              ),
                                            ),
                                            filled: true,
                                            hintStyle: new TextStyle(color: Colors.grey[800]),
                                            hintText: "Please Enter Your Name.",
                                            fillColor: Colors.white70),
                                      )

                                  ),
                                  Container(
                                      padding: EdgeInsets.all(2),
                                      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),


                                      child :TextField(
                                        controller: et_email,
                                        decoration: new InputDecoration(
                                            border: new OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(
                                                const Radius.circular(50.0),
                                              ),
                                            ),
                                            filled: true,
                                            hintStyle: new TextStyle(color: Colors.grey[800]),
                                            hintText: "Please Enter Your E-mail.",
                                            fillColor: Colors.white70),
                                      )

                                  ),
                                  Container(
                                      padding: EdgeInsets.all(2),
                                      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),


                                      child :TextField(
                                        controller: et_phone,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                                        maxLength: 10,
                                        decoration: new InputDecoration(
                                            border: new OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(
                                                const Radius.circular(50.0),
                                              ),
                                            ),
                                            filled: true,
                                            hintStyle: new TextStyle(color: Colors.grey[800]),
                                            hintText: "Please Enter Your Phone.",
                                            fillColor: Colors.white70),
                                      )

                                  ),

                                  Container(
                                      padding: EdgeInsets.all(2),
                                      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                      child :TextField(
                                        controller: et_subject,

                                        decoration: new InputDecoration(
                                            border: new OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(
                                                const Radius.circular(50.0),
                                              ),
                                            ),
                                            filled: true,
                                            hintStyle: new TextStyle(color: Colors.grey[800]),
                                            hintText: "Please Enter Your Subject.",
                                            fillColor: Colors.white70),
                                      )

                                  ),

                                  Container(
                                      padding: EdgeInsets.all(2),
                                      margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                                      child :TextField(
                                        controller: et_message,

                                        decoration: new InputDecoration(
                                            border: new OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(
                                                const Radius.circular(50.0),
                                              ),
                                            ),
                                            filled: true,
                                            hintStyle: new TextStyle(color: Colors.grey[800]),
                                            hintText: "Message For Me.",
                                            fillColor: Colors.white70),
                                      )

                                  ),
                                  Container(

                                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                      width: 250,
                                      child: RaisedButton(
                                        textColor: Colors.white,
                                        color: const Color(0xff293462),
                                        padding: EdgeInsets.all(15),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(50.0),
                                            side: BorderSide(color: const Color(0xff293462))
                                        ),
                                        child: Text('SEND MESSAGE'),
                                        onPressed: () {
                                          //print("Name"+nameController.text);
                                          //print("Password"+passwordController.text);


                                            Pattern pattern =
                                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                            RegExp regex = new RegExp(pattern);


                                          if (et_name.text.isEmpty) {
                                            print("isEmpty");

                                            Fluttertoast.showToast(
                                              msg: "Please enter name",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              //timeInSecForIosWeb: 1,
                                              //  backgroundColor: Colors.black26,
                                              // textColor: Colors.white,
                                              //fontSize: 16.0
                                            );
                                          } else if (et_email.text.isEmpty) {
                                            Fluttertoast.showToast(
                                              msg: "Please enter email",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              //timeInSecForIosWeb: 1,
                                              //  backgroundColor: Colors.black26,
                                              // textColor: Colors.white,
                                              //fontSize: 16.0
                                            );
                                          }
                                          else if (!regex.hasMatch(et_email.text)) {
                                            Fluttertoast.showToast(
                                              msg: "Please enter valid email",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              //timeInSecForIosWeb: 1,
                                              //  backgroundColor: Colors.black26,
                                              // textColor: Colors.white,
                                              //fontSize: 16.0
                                            );
                                          }

                                          else if (et_phone.text.isEmpty) {
                                          Fluttertoast.showToast(
                                          msg: "Please enter phone",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.black,
                                          //timeInSecForIosWeb: 1,
                                          //  backgroundColor: Colors.black26,
                                          // textColor: Colors.white,
                                          //fontSize: 16.0
                                          );}
                                          else if (et_subject.text.isEmpty) {
                                          Fluttertoast.showToast(
                                          msg: "Please enter subject",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.black,
                                          //timeInSecForIosWeb: 1,
                                          //  backgroundColor: Colors.black26,
                                          // textColor: Colors.white,
                                          //fontSize: 16.0
                                          );
                                          }
                                          else if (et_message.text.isEmpty) {
                                            Fluttertoast.showToast(
                                              msg: "Please enter message",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              //timeInSecForIosWeb: 1,
                                              //  backgroundColor: Colors.black26,
                                              // textColor: Colors.white,
                                              //fontSize: 16.0
                                            );
                                          }else {
                                            check();
                                            print("okk");
                                          }
                                        },
                                      )),







                                ]

                            )

                        ),
                      )
                    ],
                  ),


                )

            ),),







        ],
      ),

    );
  }
}

