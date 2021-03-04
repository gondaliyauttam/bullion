import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visnagarbullion/MyConstants.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Navigate to Next Screen',
    home: EcomomicCalendar(),
  ));
}
class EcomomicCalendar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();


}

class _State extends State<EcomomicCalendar> {


  Completer<WebViewController> _controller = Completer<WebViewController>();
  ProgressDialog _progressDialog = ProgressDialog();

  @override
  void initState() {
    super.initState();
    _progressDialog.showProgressDialog(context, textToBeDisplayed: 'Loading...wait...',
        onDismiss: () {
          //things to do after dismissing -- optional
        });

  }









  @override
  Widget build(BuildContext context) {



    return new Scaffold(
/*
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0), // here the desired height
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
// Don't show the leading button
          title: new Container(
            height: 0,
            decoration: new BoxDecoration(color: Color(0xff528CE6)),
            child: new Row(
              children: [
                new Container(

                ),
              ],
            ),
          ),
        ),
      ),
*/


      body: Column(
        children: <Widget>[
          Container(
            child: Container(
              constraints: const BoxConstraints(minWidth: double.infinity),
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              child: Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(0.0),
                    border: Border.all(color: Colors.transparent),

                    gradient: new LinearGradient(
                        colors: [
                          const Color(0xff293462),
                          const Color(0xff293462),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),


                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new Column(
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
                            margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 15,
                                  child: Container(

                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(0),
                                          bottomRight: Radius.circular(0)),
                                      border: Border.all(
                                          color: Colors.transparent),

                                      gradient: new LinearGradient(
                                          colors: [
                                            //const Color(0xffFFFFFF).withOpacity(0.7),
                                            //const Color(0xffFFFFFF).withOpacity(0.9),
                                            Colors.transparent,
                                            Colors.transparent,

                                          ],
                                          begin: const FractionalOffset(
                                              0.0, 0.0),
                                          end: const FractionalOffset(1.0, 0.0),
                                          stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp),
                                    ),

                                    child: IconButton(
                                      icon: Icon(
                                          Icons.arrow_back,
                                          size: 35,
                                          color: Colors.white
                                      ),
                                      tooltip: 'Back',
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 85,
                                  child: Container(
                                      padding: EdgeInsets.fromLTRB(0, 2, 0, 0),

                                      child: Text('Economic calendar',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )


                                  ),
                                ),

                              ],
                            ),

                          ),


                        ],
                      ),


                    ],
                  )
              ),
            ),),
          Expanded(
          child: WebView(
          initialUrl: 'https://www.mql5.com/en/economic-calendar/widget?mode=1&utm_source=www.pritamspot.com',
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (String url) {
              // should be called when page finishes loading
              setState(() {
                _progressDialog.dismissProgressDialog(context);
              });
            },

            onWebViewCreated: (WebViewController webViewController) {
    _controller.complete(webViewController);

    },
    )),

        ],

      ),

    );
  }


}