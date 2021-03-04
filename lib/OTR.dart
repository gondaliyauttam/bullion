import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:visnagarbullion/Home.dart';
import 'package:xml/xml.dart' as xml;
import 'package:connectivity/connectivity.dart';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';

import 'MyConstants.dart';

class OTR extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<OTR> {
  TextEditingController et_name = TextEditingController();
  TextEditingController et_frim_name = TextEditingController();
  TextEditingController et_phone = TextEditingController();
  TextEditingController et_city = TextEditingController();

  ProgressDialog _progressDialog = ProgressDialog();

  String value = '';
  String output = 'Not Checked';

  void functionCall() async {

    String ObjVariable="[{\"Name\":\""+et_name.text+"\"," +
        "\"FirmName\":\""+et_frim_name.text+"\"," +
        "\"City\":\""+et_city.text+"\"," +
        "\"CleintId\":\""+MyConstants.ClientId+"\"," +
        "\"ContactNo\":\""+et_phone.text+"\"}]";


    //print("Otr========" +ObjVariable);

    _progressDialog.showProgressDialog(context, textToBeDisplayed: 'Sending...',
        onDismiss: () {
      //things to do after dismissing -- optional
    });

    List<String> fieldList = [
      '<?xml version="1.0" encoding="utf-8"?>',
      '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">',
      '<soap:Body>',
      '<InsertOtr xmlns="http://tempuri.org/">',
      '<ClientDetails>'+ObjVariable+'</ClientDetails>',
      '</InsertOtr>',
      '</soap:Body>',
      '</soap:Envelope>'
    ];
    var envelope = fieldList.map((v) => '$v').join();
    print(envelope);

    http.Response response = await http.post(
        'http://starlinejewellers.in/WebService/WebService.asmx',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://tempuri.org/InsertOtr",
          "Host": "starlinejewellers.in"
          //"Accept": "text/xml"
        },
        body: envelope);


    var rawXmlResponse = response.body;
    // ignore: deprecated_member_use
      xml.XmlDocument parsedXml = xml.parse(rawXmlResponse);
    _progressDialog.dismissProgressDialog(context);


       // print("Dibesg=====" + parsedXml.text);

       String chekis=parsedXml.text;
       checkTextInputData(chekis);



    // if (parsedXml.text.isNumeric()) {
    //   //Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    //   addStringToSF("OK");
    // } else {
    //   showAlert(context, parsedXml.text);
    // }
  }




  checkTextInputData(String vali) {
    setState(() {
      value = vali;
    });

    print(_isNumeric(value));
    if (_isNumeric(value) == true) {
      setState(() {
        output = 'Value is Number';
        print("Dibesg=====" + output);
        addStringToSF("OK");


      });
    } else {
      setState(() {
        output = 'Value is Not Number';
        print("Dibesg=====" + output);
        showAlert(context,value);


      });
    }
  }

  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }


  addStringToSF(String Otr) async {
    _progressDialog.dismissProgressDialog(context);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Otr', Otr);
    Route route = MaterialPageRoute(builder: (context) => Home());
    Navigator.pushReplacement(context, route);
  }

  showAlert(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('PJ Gold Bullion'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
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
          child: SingleChildScrollView(
            child: Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,

            //width: double.infinity,
            //height: MediaQuery.of(context).size.height * 0.58,
            decoration: new BoxDecoration(
              borderRadius: new BorderRadius.circular(16.0),
              color: Colors.black,
            ),


            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Image.asset('assets/images/logovisnagrsplsee.png',
                          width: 300, height: 80),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'One Time Registration',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: const Color(0xffBD8A3C), fontSize: 20),
                    )),


                Container(
                    padding: EdgeInsets.all(2),
                    child: TextField(
                        autocorrect: true,
                        controller: et_name,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),

                        decoration: InputDecoration(
                          hintText: 'Name',

                          hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffBD8A3C)),
                          ),

                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffBD8A3C)),
                          ),


                        ))),


                Container(
                    padding: EdgeInsets.all(2),
                    child: TextField(
                        autocorrect: true,
                        controller: et_frim_name,
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),

                        decoration: InputDecoration(
                          hintText: 'Firm Name',

                          hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffBD8A3C)),
                          ),

                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffBD8A3C))),
                          ),
                        )),
                Container(
                    padding: EdgeInsets.all(2),
                    child: TextField(
                        autocorrect: true,
                        controller: et_phone,

                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),

                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],

                        maxLength: 10,
                        decoration: InputDecoration(
                          hintText: 'Contact Number',

                          hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffBD8A3C)),
                          ),

                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffBD8A3C)),
                          ),
                        ))),
                Container(
                    padding: EdgeInsets.all(2),
                    child: TextField(
                        autocorrect: true,
                        controller: et_city,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'City',
                          hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffBD8A3C)),
                          ),

                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xffBD8A3C)),
                          ),
                        ))),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    width: double.infinity,
                    child: RaisedButton(
                      textColor: const Color(0xff000000),
                      color: const Color(0xffBD8A3C),
                      padding: EdgeInsets.all(14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Colors.white)),
                      child: Text('REGISTER'),
                      onPressed: () {
                        //print("Name"+nameController.text);
                        //print("Password"+passwordController.text);

                        if (et_name.text.isEmpty) {
                          print("isEmpty");

                          Fluttertoast.showToast(
                            msg: "Please enter Name",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            //timeInSecForIosWeb: 1,
                            //  backgroundColor: Colors.black26,
                            // textColor: Colors.white,
                            //fontSize: 16.0
                          );
                        } else if (et_frim_name.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please enter Firm name",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            //timeInSecForIosWeb: 1,
                            //  backgroundColor: Colors.black26,
                            // textColor: Colors.white,
                            //fontSize: 16.0
                          );
                        } else if (et_phone.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please enter mobile number",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            //timeInSecForIosWeb: 1,
                            //  backgroundColor: Colors.black26,
                            // textColor: Colors.white,
                            //fontSize: 16.0
                          );
                        } else if (et_phone.text.length < 10) {
                          Fluttertoast.showToast(
                            msg: "Please enter valid mobile number",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            //timeInSecForIosWeb: 1,
                            //  backgroundColor: Colors.black26,
                            // textColor: Colors.white,
                            //fontSize: 16.0
                          );
                        } else if (et_city.text.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Please enter city",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.white,
                            textColor: Colors.black,
                            //timeInSecForIosWeb: 1,
                            //  backgroundColor: Colors.black26,
                            // textColor: Colors.white,
                            //fontSize: 16.0
                          );
                        } else {
                          check();
                          print("okk");
                        }
                      },
                    )),
              ],
            ),
          )),
        ));
    // decoration: BoxDecoration(
    //     image: DecorationImage(
    //         image: AssetImage("assets/images/logo.png"), fit: BoxFit.cover)),
  }

  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      functionCall();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      functionCall();
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
}
