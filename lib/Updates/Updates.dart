import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visnagarbullion/Updates/update_module.dart';
import 'dart:convert';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;

import '../MyConstants.dart';







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

  UpdateResponce(String Responce) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('updateresponce', Responce);

  }

  getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('updateresponce');
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

    }else{
      String rawJson = '{"bankdetails":'+stringValue+'}';
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


  _selectDate2(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate2, // Refer step 1
      firstDate: DateTime(0),
      lastDate: DateTime(9090),

      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Theme.of(context).copyWith(
            /* primaryColor: Colors.black,
            accentColor: Colors.amber,*/

            cursorColor: Colors.grey,
            dialogBackgroundColor: Colors.white,
            colorScheme: ColorScheme.light(primary: const Color(0xff293462)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            highlightColor: Colors.grey[400],
            textSelectionColor: Colors.grey,

          ),

          child: child,
        );
      },


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


      // builder: (BuildContext context, Widget child) {
      //   return Theme(
      //     data: ThemeData.light().copyWith(
      //       colorScheme: ColorScheme.dark(
      //         primary: const Color(0xff293462),
      //         onPrimary: Colors.white,
      //         surface: const Color(0xff293462),
      //         onSurface: Colors.black,
      //       ),
      //       dialogBackgroundColor:Colors.white,
      //     ),
      //     child: child,
      //   );
      // },

      builder: (BuildContext context, Widget child) {
        return Theme(
          data: Theme.of(context).copyWith(
           /* primaryColor: Colors.black,
            accentColor: Colors.amber,*/

            cursorColor: Colors.grey,
            dialogBackgroundColor: Colors.white,
            colorScheme: ColorScheme.light(primary: const Color(0xff293462)),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            highlightColor: Colors.grey[400],
            textSelectionColor: Colors.grey,

          ),

          child: child,
        );
      },




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

    String ObjVariable="{\"EndDate\":\""+ApiDate2+"\",\"Client\":\""+MyConstants.ClientId+"\",\"StartDate\":\""+ApiDate1+"\"}";

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
     UpdateResponce(parsedXml.text);
     items.clear();
     getStringValuesSF();

  }



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: const Color(0xffDAE1E7),
      body: new Container(
      child: new Container(
        child: new Column(
          children: [
            new Expanded(
              child: new Container(
                child:Container(
                    color: Colors.white,

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
                                  color: const Color(0xff293462),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,

                                ),
                              )

                          ),
                        ),
                        Expanded(
                          flex: 35,
                          child: Container(
                              height: 30,
                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                color: const Color(0xff293462),

                              ),
                              margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                              padding: EdgeInsets.all(7),
                              child: RaisedButton(
                                textColor: Colors.white,
                                color: const Color(0xff293462),
                                padding: EdgeInsets.all(0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(color: const Color(0xff293462))
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
                                  color: const Color(0xff293462),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold

                                ),
                              )

                          ),
                        ),
                        Expanded(
                          flex: 35,
                          child: Container(
                              height: 30,
                              decoration: new BoxDecoration(
                                borderRadius: new BorderRadius.circular(5.0),
                                color:
                                const Color(0xff293462),

                              ),
                              margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                              padding: EdgeInsets.all(7),
                              child: RaisedButton(
                                textColor: Colors.white,
                                color:
                                const Color(0xff293462),
                                padding: EdgeInsets.all(0),

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
                                color: const Color(0xff293462),

                              ),
                              margin: EdgeInsets.fromLTRB(5, 7, 5, 0),
                              padding: EdgeInsets.all(7),
                              child: RaisedButton(
                                textColor: Colors.white,
                                color:
                                const Color(0xff293462),
                                padding: EdgeInsets.all(0),

                                child: Text('Search',textAlign: TextAlign.center,
                                ),

                                onPressed: () => { getNews() }, // Refer step 3
                              )),


                        ),
                      ],
                    )
                ),

              ),
              flex: 1,
            ),
            new Container(
              width: MediaQuery.of(context).size.width * 100,
              color:
              const Color(0xff293462),
              height: 1,

            ),

            new Expanded(
              child: new Visibility(
                visible: address_visible1,
                child:ListView.builder(
                    itemCount: this.items.length,
                    itemBuilder: _listViewItemBuilder
                ),
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
                      child : Text('Updates Not Available',
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
    // decoration: BoxDecoration(
    //     image: DecorationImage(
    //         image: AssetImage("assets/images/logo.png"), fit: BoxFit.cover)),



  }
  Widget _listViewItemBuilder(BuildContext context, int index){
    var newsDetail = this.items[index];
    return Container(
      constraints: const BoxConstraints(minWidth: double.infinity),
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(0.0),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(2.0),
        color: const Color(0xff293462),
      ),
      child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(1),
          padding: EdgeInsets.fromLTRB(0, 5, 5, 5),

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
                          flex: 25,
                          child: Container(
                              child : Column(
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.all(2),
                                        child : Text(newsDetail.Day,
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                              color:
                                              const Color(0xff293462),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        )

                                    ),
                                    Container(
                                        padding: EdgeInsets.all(2),
                                        child : Text(newsDetail.Month+'\''+newsDetail.Year.toString(),
                                          textAlign: TextAlign.center,

                                          style: TextStyle(
                                              color: const Color(0xffBD8A3C),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        )

                                    ),


                                  ]

                              )

                          ),
                        ),
                        Expanded(
                          flex: 75,
                          child: Container(
                              child : Column(
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.all(2),
                                        width: MediaQuery.of(context).size.width * 100,

                                        child : Text(newsDetail.Title,
                                          textAlign: TextAlign.left,

                                          style: TextStyle(
                                              color: const Color(0xff293462),
                                              fontWeight: FontWeight.bold,

                                              fontSize: 14),
                                        )

                                    ),
                                    Container(
                                        padding: EdgeInsets.all(2),
                                        width: MediaQuery.of(context).size.width * 100,

                                        child : Text(newsDetail.Time,
                                          textAlign: TextAlign.left,

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        )

                                    ),
                                    Container(
                                        padding: EdgeInsets.all(2),
                                        width: MediaQuery.of(context).size.width * 100,

                                        child : Text(newsDetail.Description,
                                          textAlign: TextAlign.left,

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14),
                                        )

                                    ),



                                  ]

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






