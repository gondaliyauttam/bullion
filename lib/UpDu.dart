import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Updates extends StatelessWidget {

  String Date1 = DateFormat("dd-MM-yyyy").format(DateTime.now());
  String Date2 = DateFormat("dd-MM-yyyy").format(DateTime.now());



  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(
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
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(5.0),
                            color: Colors.black,

                          ),
                          margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                          padding: EdgeInsets.all(7),

                          child : Text(Date1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,

                            ),
                          )

                      ),
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
                      flex: 35,
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
                            child: Text(Date2),
                            onPressed: () {

                            },
                          )),


                    ),
                    Expanded(
                      flex: 30,

                      child: Container(
                          decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.circular(5.0),
                            color: Colors.black,

                          ),
                          margin: EdgeInsets.fromLTRB(5, 7, 5, 0),
                          padding: EdgeInsets.all(7),

                          child : Text(
                            'Search',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,

                            ),
                          )

                      ),
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
                padding: EdgeInsets.all(2),
                child : Text(
                  'Listview',
                  textAlign: TextAlign.center,

                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20),
                )

            ),
          ],
        )
    );
  }
}