import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:visnagarbullion/Home.dart';
import 'package:visnagarbullion/Markettrendz.dart';
import 'package:visnagarbullion/MyConstants.dart';
import 'OTR.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;


import 'Test.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainActivityCustom());
  }
}

class MainActivityCustom extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();


}

class _State extends State<MainActivityCustom> {


  String AndroidVertion = '';


  @override
  void initState() {
    super.initState();
    getVerionApplication();
    MyConstants.getContactData(context);
    MyConstants.getContactData2(context);
    MyConstants.GetMainData(context);
    MyConstants.GetChartData(context);

  }




  getVerionApplication() async {

    if (Platform.isIOS) {
      print('is a IOS');

    } else if (Platform.isAndroid) {
      print('is a Andriod');

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String versionName = packageInfo.version;
      AndroidVertion = packageInfo.buildNumber;
      functionCall();
      //print('Android $AndroidVertion');
    } else {

    }
  }



  void functionCall() async {

    String ObjVariable="{\"Client\":\""+MyConstants.ClientId+"\"}";

    List<String> fieldList = [
      '<?xml version="1.0" encoding="utf-8"?>',
      '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">',
      '<soap:Body>',
      '<GetVersion xmlns="http://tempuri.org/">',
      '<Obj>'+ObjVariable+'</Obj>',
      '</GetVersion>',
      '</soap:Body>',
      '</soap:Envelope>'
    ];
    var envelope = fieldList.map((v) => '$v').join();
    print(envelope);

    http.Response response = await http.post(
        'http://starlinejewellers.in/WebService/WebService.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://tempuri.org/GetVersion",
          "Host": "starlinejewellers.in"
          //"Accept": "text/xml"
        },
        body: envelope);


    var rawXmlResponse = response.body;
    // ignore: deprecated_member_use
    xml.XmlDocument parsedXml = xml.parse(rawXmlResponse);


    String chekis=parsedXml.text;
    //print("Dibesg=====" + chekis);
   // print("Dibesg=====" + response.body);
   // print("Dibesg=====" + ObjVariable);


    int ApiVersion = int.parse(chekis);
    int AppVersion = int.parse(AndroidVertion);

     print(AppVersion);
     print("Dibesg=====" + AndroidVertion);
     print(ApiVersion);

     if (AppVersion<ApiVersion) {
       ShowUpdateDialog(context);
     }else{
       getStringValuesSF();
     }

  }



  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('Otr');
    if(stringValue=='OK'){
      print("Dibesg=====" + 'Ok');
      Route route = MaterialPageRoute(builder: (context) => Home());
      Navigator.pushReplacement(context, route);

    }else{
      print("Dibesg=====" + 'NOT');
      Route route = MaterialPageRoute(builder: (context) => OTR());
      Navigator.pushReplacement(context, route);


    }


  }

  ShowUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,

      builder: (BuildContext context) {
        return AlertDialog(
          //title: new Text('Visnagar Bullion'),
         // content: Text("fff"),
          actions: <Widget>[
            Visibility(
              visible: true,
              child: Container(
                  width: MediaQuery.of(context).size.width * 100,
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.all(0),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(3.0),
                    color: Colors.transparent,

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
                                        alignment: Alignment.center,

                                        padding: EdgeInsets.all(10),
                                        width: MediaQuery.of(context).size.width * 100,
                                        child : Text("Update Available!!",
                                          textAlign: TextAlign.left,

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )

                                    ),

                                    Container(
                                        color: const Color(0xff293462),
                                        padding: EdgeInsets.all(10),
                                        child: Image.asset('assets/images/logomain.png',
                                            width: 80, height: 80)),
                                    Container(
                                        alignment: Alignment.center,

                                        padding: EdgeInsets.all(10),
                                        width: MediaQuery.of(context).size.width * 100,
                                        child : Text("New version is available, please update now for exploring best features of "+MyConstants.NameApp,
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )

                                    ),

                                    Container(
                                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        width: double.infinity,
                                        child: RaisedButton(
                                          textColor: Colors.white,
                                          color: const Color(0xff293462),
                                          padding: EdgeInsets.all(0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(5.0),
                                              side: BorderSide(color: const Color(0xff293462))),
                                          child: Text('Update Now'),
                                          onPressed: () {
                                            StoreRedirect.redirect(androidAppId: MyConstants.PackeageName,iOSAppId: MyConstants.iOSAppId);
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: const Color(0xff293462),
        body: Center(
          child: Container(
              child: Container(
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.all(0),
                alignment: Alignment.center,

                child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(0),
                    child:Image.asset('assets/images/logovisnagrsplsee.png',
                        width: 250, height: 250)
                ),
              )),
        ));
  }


}

