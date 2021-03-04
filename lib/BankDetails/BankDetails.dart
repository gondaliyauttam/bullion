import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visnagarbullion/BankDetails/bank_modlue.dart';
import 'package:xml/xml.dart' as xml;

import '../MyConstants.dart';


class BankDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NewsScreenState();
  }
}

class _NewsScreenState extends State<BankDetails> {
  final List<BankModule> items = [];

  int flesx1=9;
  int flesx2=0;

  bool address_visible1 = true ;
  bool address_visible2 = false;

  @override
  void initState() {
       super.initState();
       getNews();
       getStringValuesSF();
  }

  BankResponce(String Responce) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Bankresponce', Responce);

  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('Bankresponce');

    if(stringValue=='[]'){

      if (mounted) {
        setState(() {
          items.clear();


          flesx1=0;
          flesx2=9;

          address_visible1 = false ;
          address_visible2 = true;

        });
      }

    }else {
      String rawJson = '{"bankdetails":' + stringValue + '}';
      final Map<String, dynamic> responseData = json.decode(rawJson);
      responseData['bankdetails'].forEach((newsDetail) {
        final BankModule news = BankModule(
            BankID: newsDetail['BankID'],
            ClientID: newsDetail['ClientID'],
            AccountName: newsDetail['AccountName'],
            BankName: newsDetail['BankName'],
            AccountNo: newsDetail['AccountNo'],
            Ifsc: newsDetail['Ifsc'],
            BranchName: newsDetail['BranchName'],
            Mdate: newsDetail['Mdate'],
            OnlyDate: newsDetail['OnlyDate'],
            OnlyTime: newsDetail['OnlyTime'],
            BankLogo: newsDetail['BankLogo']
        );

        if (mounted) {
          setState(() {

            flesx1=9;
            flesx2=0;

            address_visible1 = true;
            address_visible2 = false;


            items.add(news);


          });
        }
      });
    }


}

  @override
  Widget build(BuildContext context){

    return Scaffold(
      backgroundColor: const Color(0xffDAE1E7),
        body:Container(
          child: new Container(
            child: new Column(
              children: [

                new Expanded(
                  child: new Visibility(
                    visible: address_visible1,
                    child: ListView.builder(
                        itemCount: this.items.length,
                        itemBuilder: _listViewItemBuilder
                    )
                  ),
                  flex: flesx1,
                ),
                new Expanded(
                  child: new Visibility(
                      visible: address_visible2,
                      child:Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(2),
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: MediaQuery.of(context).size.width * 100,
                          height: MediaQuery.of(context).size.width * 100,
                          child : Text('Bankdetails Not Available',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16),
                          )

                      )),

                  flex: flesx2,
                ),
              ],
            ),
          ),
        ),
    );
  }



  Widget _listViewItemBuilder(BuildContext context, int index){
    var newsDetail = this.items[index];
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(0.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(2.0),
        color: Colors.black,
      ),
      child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(1),
          padding: EdgeInsets.fromLTRB(15, 5, 5, 5),

          child:new Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              new Image.network(newsDetail.BankLogo, fit: BoxFit.fill),
              new Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    color:Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 40,
                          child: Container(
                              child : Text(
                                'Bank Name',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16),
                              )

                          ),
                        ),
                        Expanded(
                          flex: 60,
                          child: Container(
                              child : Text('::    '+newsDetail.BankName+'',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16),
                              )

                          ),
                        )
                      ],
                    ),

                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    color:Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 40,
                          child: Container(
                              child : Text(
                                'Account Name',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16),
                              )

                          ),
                        ),
                        Expanded(
                          flex: 60,
                          child: Container(
                              child : Text('::    '+newsDetail.AccountName+'',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16),
                              )

                          ),
                        )
                      ],
                    ),

                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    color:Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 40,
                          child: Container(
                              child : Text(
                                'Account No',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16),
                              )

                          ),
                        ),
                        Expanded(
                          flex: 60,
                          child: Container(
                              child : Text('::    '+newsDetail.AccountNo+'',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16),
                              )

                          ),
                        )
                      ],
                    ),

                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    color:Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 40,
                          child: Container(
                              child : Text(
                                'IFSC Code',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16),
                              )

                          ),
                        ),
                        Expanded(
                          flex: 60,
                          child: Container(
                              child : Text('::    '+newsDetail.Ifsc+'',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16),
                              )

                          ),
                        )
                      ],
                    ),

                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    color:Colors.white,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 40,
                          child: Container(
                              child : Text(
                                'Branch Name',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16),
                              )

                          ),
                        ),
                        Expanded(
                          flex: 60,
                          child: Container(
                              child : Text('::    '+newsDetail.BranchName+'',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16),
                              )

                          ),
                        )
                      ],
                    ),

                  ),










                ],
              ),


            ],
          )
      ),
    );
  }




  // Widget _itemTitle(BankModule newsDetail){
  //   return Text(newsDetail.AccountName);
  // }

  void getNews() async {
    List<String> fieldList = ['<?xml version="1.0" encoding="utf-8"?>',
      '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">',
      '<soap:Body>',
      '<BankDetail xmlns="http://tempuri.org/">',
      '<CleintId>'+MyConstants.ClientId+'</CleintId>',
      '</BankDetail>',
      '</soap:Body>',
      '</soap:Envelope>'];
    var envelope  = fieldList.map((v) => '$v').join();
    print(envelope);

    http.Response response =
    await http.post('http://starlinejewellers.in/WebService/WebService.asmx?',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://tempuri.org/BankDetail",
          "Host": "starlinejewellers.in"
          //"Accept": "text/xml"
        },
        body: envelope);

    var rawXmlResponse = response.body;
    // ignore: deprecated_member_use
    xml.XmlDocument parsedXml = xml.parse(rawXmlResponse);
   // print("DataIs========" + );
    BankResponce(parsedXml.text);
    items.clear();
    getStringValuesSF();


  }
}