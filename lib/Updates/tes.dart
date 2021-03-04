import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visnagarbullion/Updates/update_module.dart';
import 'dart:convert';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;




class Updates extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();

}

class _State extends State<Updates> {


  final List<UpdateModule> items = [];


  DateTime selectedDate2 = DateTime.now();
  var Date2 = DateFormat("dd/MM/yyyy").format(DateTime.now());
  var ApiDate2 = DateFormat("dd/MM/yyyy").format(DateTime.now());

  DateTime selectedDate1 = DateTime.now();
  var Date1 = DateFormat("dd/MM/yyyy").format(DateTime.now());
  var ApiDate1 = DateFormat("dd/MM/yyyy").format(DateTime.now());


  @override
  void initState() {
    super.initState();
    getNews();
  }


  _selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate2, // Refer step 1
      firstDate: DateTime(0),
      lastDate: DateTime(9090),

    );
    if (picked != null && picked != selectedDate2)
      setState(() {
        final DateTime now = picked;
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        final String formatted = formatter.format(now);
        print(formatted);
        print(picked);
        Date2 = formatted;

        final DateTime now2 = picked;
        final DateFormat formatter2 = DateFormat('dd/MM/yyyy');
        final String formatter52 = formatter2.format(now2);
        ApiDate2 = formatter52;
        print("ApiDate2"+ApiDate2);


      });


  }
  _selectDate1(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate1, // Refer step 1
      firstDate: DateTime(0),
      lastDate: DateTime(9090),

    );
    if (picked != null && picked != selectedDate1)
      setState(() {
        final DateTime now = picked;
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        final String formatted = formatter.format(now);
        print(formatted);
        print(picked);
        Date1 = formatted;

        final DateTime now2 = picked;
        final DateFormat formatter2 = DateFormat('dd/MM/yyyy');
        final String formatter52 = formatter2.format(now2);
        ApiDate1 = formatter52;
        print("ApiDate2"+ApiDate1);


      });


  }

  void getNews() async {
    String BullionID="5";
    String ObjVariable="{\"EndDate\":\""+ApiDate2+"\",\"Client\":\""+BullionID+"\",\"StartDate\":\""+ApiDate1+"\"}";

    List<String> fieldList = ['<?xml version="1.0" encoding="utf-8"?>',
      '<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">',
      '<soap:Body>',
      '<GetNewsDateWise xmlns="http://tempuri.org/">',
      '<Obj>'+ObjVariable+'</Obj>',
      '</GetNewsDateWise>',
      '</soap:Body>',
      '</soap:Envelope>'];
    var envelope  = fieldList.map((v) => '$v').join();
    print(envelope);

    http.Response response =
    await http.post('http://starlinejewellers.in/WebService/WebService.asmx?',
        headers: {
          "Content-Type": "text/xml; charset=utf-8",
          "SOAPAction": "http://tempuri.org/GetNewsDateWise",
          "Host": "starlinejewellers.in"
          //"Accept": "text/xml"
        },
        body: envelope);

    var rawXmlResponse = response.body;
    xml.XmlDocument parsedXml = xml.parse(rawXmlResponse);
    print("NewsResponces" + parsedXml.text);
    String rawJson = '{"bankdetails":'+parsedXml.text+'}';
    final Map<String, dynamic> responseData = json.decode(rawJson);
    responseData['bankdetails'].forEach((newsDetail) {
      final UpdateModule news = UpdateModule(
          Day: newsDetail['Day'],
          Year: newsDetail['Year'],
          Time: newsDetail['Time'],
          Month: newsDetail['Month'],
          Title: newsDetail['Title'],
          Description: newsDetail['Description'],
          Sortnews: newsDetail['Sortnews'],
          Cdate: newsDetail['Cdate'],
          Mdate: newsDetail['Mdate']


      );

      setState(() {
        items.add(news);
      });
    });

  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(2),
                  child : Row(
                    children: <Widget>[
                      Expanded(
                        flex: 15,
                        child: Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(0.0),
                              color: Colors.white,

                            ),
                            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            child : Text(
                              'Date',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,

                              ),
                            )

                        ),
                      ),
                      Expanded(
                        flex: 30,
                        child: Container(
                            height: 30,
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(5.0),
                              color: Colors.black,

                            ),
                            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            padding: EdgeInsets.all(7),
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Colors.black,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Colors.black)
                              ),
                              child: Text('${Date1}',textAlign: TextAlign.center,
                              ),

                              onPressed: () => _selectDate1(context), // Refer step 3
                            )),


                      ),
                      Expanded(
                        flex: 15,

                        child: Container(
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(0.0),
                              color: Colors.white,

                            ),
                            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            padding: EdgeInsets.all(7),

                            child : Text(
                              'To',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,

                              ),
                            )

                        ),
                      ),
                      Expanded(
                        flex: 30,
                        child: Container(
                            height: 30,
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(5.0),
                              color: Colors.black,

                            ),
                            margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                            padding: EdgeInsets.all(7),
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Colors.black,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Colors.black)
                              ),
                              child: Text('${Date2}',textAlign: TextAlign.center,
                              ),

                              onPressed: () => _selectDate2(context), // Refer step 3
                            )),


                      ),
                      Expanded(
                        flex: 30,
                        child: Container(
                            height: 30,
                            decoration: new BoxDecoration(
                              borderRadius: new BorderRadius.circular(5.0),
                              color: Colors.black,

                            ),
                            margin: EdgeInsets.fromLTRB(5, 7, 5, 0),
                            padding: EdgeInsets.all(7),
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Colors.black,
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(color: Colors.black)
                              ),
                              child: Text('Search',textAlign: TextAlign.center,
                              ),

                              onPressed: () => { getNews() }, // Refer step 3
                            )),


                      ),
                    ],
                  )
              ),
              Container(
                color: Colors.black,
                height: 0.5,
                margin: EdgeInsets.all(5),
              ),
              Container(
                color: Colors.black,
                height: 0.5,
                margin: EdgeInsets.all(5),
              )
            ],
          )
          ,
        )

    );
    // decoration: BoxDecoration(
    //     image: DecorationImage(
    //         image: AssetImage("assets/images/logo.png"), fit: BoxFit.cover)),



  }
  Widget _listViewItemBuilder(BuildContext context, int index){
    var newsDetail = this.items[index];
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(1),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(5.0),
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
                              child : Text('::    '+newsDetail.Description+'',
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
                              child : Text('::    '+newsDetail.Description+'',
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
                              child : Text('::    '+newsDetail.Description+'',
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
                              child : Text('::    '+newsDetail.Description+'',
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
                              child : Text('::    '+newsDetail.Description+'',
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




}

class DateUtil {
  static const DATE_FORMAT = 'dd/mm/yyyy';
  String formattedDate(DateTime dateTime) {
    print('dateTime ($dateTime)');
    return DateFormat(DATE_FORMAT).format(dateTime);
  }
}


