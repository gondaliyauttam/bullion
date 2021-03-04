import 'dart:async';

import 'package:adhara_socket_io/manager.dart';
import 'package:adhara_socket_io/options.dart';
import 'package:adhara_socket_io/socket.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visnagarbullion/MyConstants.dart';
import 'package:xml/xml.dart' as xml;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:image/image.dart' as ImageProcess;



import 'MyConstants.dart';
import 'MyConstants.dart';
import 'Notiflyvariblae.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Navigate to Next Screen',
    home: Markettrendz(),
  ));
}
class Markettrendz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();


}

class _State extends State<Markettrendz> {

  var Gold='';
  var Silver='';
  Uint8List _bytesImage;
  Uint8List _bytesImage2;


  @override
  void initState() {
    NotifySocketUpdate.controller_chart = StreamController();
    super.initState();



    getcontactData();

    NotifySocketUpdate.controller_chart.stream.asBroadcastStream().listen((event) {
      print("Refresspage");
      getcontactData();
    });

  }


  getcontactData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('chart');


      setState(() {
        Gold = jsonDecode(stringValue)['Gold'];
        _bytesImage = base64.decode(Gold);

      });
      setState(() {
        Silver = jsonDecode(stringValue)['Silver'];
        _bytesImage2 = base64.decode(Silver);

      });








    print('images=$Gold');


  }


  @override
  void dispose() {
    NotifySocketUpdate.controller_chart?.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {


    //_bytesImage = Base64Decoder().convert(MyConstants.Images64);
  //  _bytesImage = Base64Decoder().convert(Gold);

   // var uri='data:image/gif;base64,$Gold';



    // _bytesImage = ('data:image/gif;'+Gold) as Uint8List


    //  _bytesImage = base64.decode(uri);

    //var parts = Gold.split(',');
    //var prefix = parts[0].trim();                 // prefix: "date"




    return new Scaffold(
     /* appBar: PreferredSize(
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
      ),*/

      body: SingleChildScrollView(
         child: Column(
           children: <Widget>[
             Container(
               child: Container(
                 constraints: const BoxConstraints(minWidth: double.infinity),
                 margin: EdgeInsets.all(0),
                 padding: EdgeInsets.all(0),
                 child: Container(
                     margin: EdgeInsets.all(0),
                     padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                               margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
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

                                         child: Text('Market trendz',
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


             Container(
                 margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                 padding: EdgeInsets.all(10),
                 color: const Color(0xff293462),
                 alignment: Alignment.center,

                 child: Text('GOLD (10 GM)',
                   textAlign: TextAlign.center,
                   style: TextStyle(color: Colors.white, fontSize: 18),
                 )),
             Container(
                 margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                 padding: EdgeInsets.all(4),
                 color: const Color(0xff293462),
                 alignment: Alignment.center,
                 child:  Image.memory(_bytesImage,
                   height: 250,
                   gaplessPlayback: true,

                   fit: BoxFit.fill,

                 )


             ),

             Container(
                 margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                 padding: EdgeInsets.all(10),
                 color: const Color(0xff293462),
                 alignment: Alignment.center,

                 child: Text(
                   'SILVER (1 KG)',
                   textAlign: TextAlign.center,
                   style: TextStyle(color: Colors.white, fontSize: 18),
                 )),
             Container(
                 margin: EdgeInsets.fromLTRB(5, 0.2, 5, 0),
                 padding: EdgeInsets.all(5),
                 color: const Color(0xff293462),
                 alignment: Alignment.center,
                 child: Image.memory(_bytesImage2,
                   height: 250,
                   gaplessPlayback: true,
                   fit: BoxFit.fill,

                 )





             ),

           ],

         ),
      ),


    );
  }


}