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
    home: FlullSccrnDialog(),
  ));
}
class FlullSccrnDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();


}

class _State extends State<FlullSccrnDialog> {




  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return SizedBox.expand( // makes widget fullscreen
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 95,
           child:Container(
             color: Colors.white,
             child: SizedBox.expand(child: Image.network(MyConstants.ADVERTISEBANNERURL)),
           ),
           // child: SizedBox.expand(child: Image.network(MyConstants.ADVERTISEBANNERURL, fit: BoxFit.none)),
          ),
          Expanded(
            flex: 6,
            child: SizedBox.expand(
              child: RaisedButton(
                color: Colors.black,
                child: Text(
                  "SKIP",
                  style: TextStyle(fontSize: 16),
                ),
                textColor: Colors.white,
                onPressed: (){
                  Navigator.of(context).pop();

                },
              ),
            ),
          ),
        ],
      ),
    );
  }


}