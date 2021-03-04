import 'dart:async';

import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:marquee/marquee.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visnagarbullion/BankDetails/BankDetails.dart';
import 'package:visnagarbullion/ContactUs/ContactUs.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:visnagarbullion/EcomomicCalendar.dart';
import 'dart:convert';
import 'dart:convert' as JSON;

import 'FlullSccrnDialog.dart';
import 'LiveRate/LiveRate.dart';
import 'Markettrendz.dart';
import 'MyConstants.dart';
import 'Notiflyvariblae.dart';
import 'Updates/Updates.dart';

void main() => runApp(new Home());

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Bottom Navigation',
      theme: new ThemeData(
        primaryColor: const Color(0xff293462),
        primaryColorDark: const Color(0xFF167F67),
        accentColor: const Color(0xFFFFAD32),
      ),
      home:FeatureDiscovery.withProvider(
        persistenceProvider: NoPersistenceProvider(),
        child: DashboardScreen(title: 'Bottom Navigation'),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key, this.title}) : super(key: key);

  final String title;



  @override
  _DashboardScreenState createState() => new _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
  GlobalKey<EnsureVisibleState> ensureVisibleGlobalKey = GlobalKey<EnsureVisibleState>();

  PageController _pageController;
  int _page = 0;
  bool marquee_top = false ;
  bool marquee_bottom = false ;
  var Marquee1="";
  var Marquee2="";

  bool booking_vsible1 = false ;
  bool booking_vsible2 = false ;
  bool booking_vsible3 = false ;
  bool booking_vsible4 = false ;
  bool booking_vsible5 = false ;
  bool booking_vsible6 = false ;
  bool booking_vsible7 = false ;
  bool mainbooking = false ;

  var BookingNo1 = "";
  var BookingNo2 = "";
  var BookingNo3 = "";
  var BookingNo4 = "";
  var BookingNo5 = "";
  var BookingNo6 = "";
  var BookingNo7 = "";
  var bit = "";
  var contrycode = "+91";
  var Whatapp1 = "";



  @override
  void initState() {
    NotifySocketUpdate.controller_home = StreamController();
    super.initState();


    getDataNew();

    FlullScrrn();

    NotifySocketUpdate.controller_home.stream.asBroadcastStream().listen((event) {
      print("!!!!!!!!!! Socket Update Notify");
      getDataNew();
    });


    _pageController = new PageController();



    var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidRecieveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
    _firebaseMessaging.subscribeToTopic(MyConstants.ClientName);
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message ${message}');
        displayNotification(message);
        },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
        },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');

        },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);
    });



  }

  Future displayNotification(Map<String, dynamic> message) async{
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'channelid', 'flutterfcm', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      message['notification']['title'],
      message['notification']['body'],
      platformChannelSpecifics,
      payload: 'hello',);
  }

  Future onSelectNotification(String payload) async {
    print("Click Notifiaction2");

  }
  Future onDidRecieveLocalNotification(int id, String title, String body, String payload) async {

  }





  getDataNew() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('ClientDataContact');

    var Liverates = jsonDecode(stringValue)['Data'];
    final List responseBody = JSON.jsonDecode(Liverates); // using with name
    setState(() {
      Marquee1 = responseBody[0]['Marquee'];
      Marquee2 = responseBody[0]['Marquee2'];

      BookingNo1 = responseBody[0]['BookingNo1'];
      BookingNo2 = responseBody[0]['BookingNo2'];
      BookingNo3 = responseBody[0]['BookingNo3'];
      BookingNo4 = responseBody[0]['BookingNo4'];
      BookingNo5 = responseBody[0]['BookingNo5'];
      BookingNo6 = responseBody[0]['BookingNo6'];
      BookingNo7 = responseBody[0]['BookingNo7'];
      Whatapp1 = responseBody[0]['whatsapp_no1'];

      MyConstants.ADVERTISEBANNERURL=responseBody[0]['BannerApp1'];


      if (BookingNo1.isEmpty && BookingNo2.isEmpty && BookingNo3.isEmpty &&
          BookingNo4.isEmpty && BookingNo5.isEmpty && BookingNo6.isEmpty &&
          BookingNo7.isEmpty) {
        mainbooking = false;
      } else {
        mainbooking = true;

        if (BookingNo1.isEmpty) {
          booking_vsible1 = false;
        } else {
          booking_vsible1 = true;
        }

        if (BookingNo2.isEmpty) {
          booking_vsible2 = false;
        } else {
          booking_vsible2 = true;
        }

        if (BookingNo3.isEmpty) {
          booking_vsible3 = false;
        } else {
          booking_vsible3 = true;
        }

        if (BookingNo4.isEmpty) {
          booking_vsible4 = false;
        } else {
          booking_vsible4 = true;
        }

        if (BookingNo5.isEmpty) {
          booking_vsible5 = false;
        } else {
          booking_vsible5 = true;
        }

        if (BookingNo6.isEmpty) {
          booking_vsible6 = false;
        } else {
          booking_vsible6 = true;
        }

        if (BookingNo7.isEmpty) {
          booking_vsible7 = false;
        } else {
          booking_vsible7 = true;
        }
      }


      if (Marquee1.isEmpty) {
        marquee_top = false;
      } else {
        marquee_top = true;
      }

      if (Marquee2.isEmpty) {
        marquee_bottom = false;
      } else {
        marquee_bottom = true;
      }
    });

  }

  @override
  void dispose() {
    NotifySocketUpdate.controller_home?.close();
    super.dispose();
    _pageController.dispose();
  }




  void navigationTapped(int page) {
    // Animating to the page.
    // You can use whatever duration and curve you like
    _pageController.animateToPage(page,duration: const Duration(milliseconds: 100), curve: Curves.ease);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;

    });
  }

  void whatsAppOpen() async {
    await FlutterLaunch.launchWathsApp(phone: "+91"+Whatapp1, message: "");
  }


  CallDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: <Widget>[
            Visibility(
              visible: mainbooking,
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
                                        margin: EdgeInsets.fromLTRB(15, 5, 0, 5),

                                        padding: EdgeInsets.all(2),
                                        width: MediaQuery.of(context).size.width * 100,
                                        child : Text("Booking Number",
                                          textAlign: TextAlign.left,

                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              decoration: TextDecoration.underline,
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
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(3),
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              width: MediaQuery.of(context).size.width * 100,
                                            child:Row(
                                              mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                                              crossAxisAlignment: CrossAxisAlignment.center ,//Center Row contents vertically,
                                              children: [
                                                Align(
                                                    child: Icon(
                                                      Icons.call,
                                                      color: Colors.black,
                                                      size: 18.0,
                                                    )
                                                ),
                                                Container(
                                                    margin: const EdgeInsets.only(left: 5.0 ),
                                                    child: Text(BookingNo1,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 14),
                                                    )
                                                )
                                              ],
                                            ),
                                          ),
                                        ),

                                    ),


                                    Visibility(
                                        visible: booking_vsible2,
                                        child:GestureDetector(
                                          onTap: (){
                                            launch("tel://"+BookingNo2);
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(3),
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              width: MediaQuery.of(context).size.width * 100,
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              width: MediaQuery.of(context).size.width * 100,
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                                                crossAxisAlignment: CrossAxisAlignment.center ,//Center Row contents vertically,
                                                children: [
                                                  Align(
                                                      child: Icon(
                                                        Icons.call,
                                                        color: Colors.black,
                                                        size: 18.0,
                                                      )
                                                  ),
                                                  Container(
                                                      margin: const EdgeInsets.only(left: 5.0 ),
                                                      child: Text(BookingNo2,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                      )
                                                  )
                                                ],
                                              ),
                                            ),


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
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(3),
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            width: MediaQuery.of(context).size.width * 100,
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              width: MediaQuery.of(context).size.width * 100,
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                                                crossAxisAlignment: CrossAxisAlignment.center ,//Center Row contents vertically,
                                                children: [
                                                  Align(
                                                      child: Icon(
                                                        Icons.call,
                                                        color: Colors.black,
                                                        size: 18.0,
                                                      )
                                                  ),
                                                  Container(
                                                      margin: const EdgeInsets.only(left: 5.0 ),
                                                      child: Text(BookingNo3,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                      )
                                                  )
                                                ],
                                              ),
                                            ),


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
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(3),
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            width: MediaQuery.of(context).size.width * 100,
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              width: MediaQuery.of(context).size.width * 100,
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                                                crossAxisAlignment: CrossAxisAlignment.center ,//Center Row contents vertically,
                                                children: [
                                                  Align(
                                                      child: Icon(
                                                        Icons.call,
                                                        color: Colors.black,
                                                        size: 18.0,
                                                      )
                                                  ),
                                                  Container(
                                                      margin: const EdgeInsets.only(left: 5.0 ),
                                                      child: Text(BookingNo4,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                      )
                                                  )
                                                ],
                                              ),
                                            ),


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
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(3),
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            width: MediaQuery.of(context).size.width * 100,
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              width: MediaQuery.of(context).size.width * 100,
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                                                crossAxisAlignment: CrossAxisAlignment.center ,//Center Row contents vertically,
                                                children: [
                                                  Align(
                                                      child: Icon(
                                                        Icons.call,
                                                        color: Colors.black,
                                                        size: 18.0,
                                                      )
                                                  ),
                                                  Container(
                                                      margin: const EdgeInsets.only(left: 5.0 ),
                                                      child: Text(BookingNo5,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                      )
                                                  )
                                                ],
                                              ),
                                            ),


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
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(3),
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            width: MediaQuery.of(context).size.width * 100,
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              width: MediaQuery.of(context).size.width * 100,
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                                                crossAxisAlignment: CrossAxisAlignment.center ,//Center Row contents vertically,
                                                children: [
                                                  Align(
                                                      child: Icon(
                                                        Icons.call,
                                                        color: Colors.black,
                                                        size: 18.0,
                                                      )
                                                  ),
                                                  Container(
                                                      margin: const EdgeInsets.only(left: 5.0 ),
                                                      child: Text(BookingNo6,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                      )
                                                  )
                                                ],
                                              ),
                                            ),


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
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.all(3),
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                            width: MediaQuery.of(context).size.width * 100,
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(5),
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              width: MediaQuery.of(context).size.width * 100,
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.center ,//Center Row contents horizontally,
                                                crossAxisAlignment: CrossAxisAlignment.center ,//Center Row contents vertically,
                                                children: [
                                                  Align(
                                                      child: Icon(
                                                        Icons.call,
                                                        color: Colors.black,
                                                        size: 18.0,
                                                      )
                                                  ),
                                                  Container(
                                                      margin: const EdgeInsets.only(left: 5.0 ),
                                                      child: Text(BookingNo7,
                                                        textAlign: TextAlign.left,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14),
                                                      )
                                                  )
                                                ],
                                              ),
                                            ),


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

          ],
        );
      },
    );
  }


  FlullScrrn() {
    new Future.delayed(const Duration(seconds: 4), () {

      if(MyConstants.ADVERTISEBANNERURL.isEmpty || MyConstants.ADVERTISEBANNERURL=='null'){

      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => FlullSccrnDialog()));

      }


    });


 //   Route route = MaterialPageRoute(builder: (context) => HomePage());
  //  Navigator.pushReplacement(context, route);
    // showGeneralDialog(
    //   context: context,
    //   barrierColor: Colors.black12.withOpacity(0.6), // background color
    //   barrierDismissible: false, // should dialog be dismissed when tapped outside
    //   barrierLabel: "Dialog", // label for barrier
    //   transitionDuration: Duration(milliseconds: 400), // how long it takes to popup dialog after button click
    //   pageBuilder: (_, __, ___) { // your widget implementation
    //     return SizedBox.expand( // makes widget fullscreen
    //       child: Column(
    //         children: <Widget>[
    //           Expanded(
    //             flex: 95,
    //             child: SizedBox.expand(child: FlutterLogo()),
    //           ),
    //           Expanded(
    //             flex: 6,
    //             child: SizedBox.expand(
    //               child: RaisedButton(
    //                 color: Colors.black,
    //                 child: Text(
    //                   "SKIP",
    //                   style: TextStyle(fontSize: 16),
    //                 ),
    //                 textColor: Colors.white,
    //                 onPressed: () => Navigator.pop(context),
    //               ),
    //             ),
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }


    @override
  Widget build(BuildContext context) {

    GlobalKey<EnsureVisibleState> ensureVisibleGlobalKey = GlobalKey<EnsureVisibleState>();


    return new Scaffold(
      backgroundColor: const Color(0xffDAE1E7),

      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0), // here the desired height
          child:  AppBar(
            automaticallyImplyLeading: false,
            titleSpacing: 0.0,
// Don't show the leading button
            title:new Container(
              height: 0,
              decoration: new BoxDecoration(color:Color(0xff293462)),
              child: new Row(
                children: [
                  new Container(
                      child: Image.asset('assets/images/logo.png',width: 0, height: 0)
                  ),
                ],
              ),
            ),
          ),
      ),
      endDrawerEnableOpenDragGesture: true, // THIS WAY IT WILL NOT OPEN

      drawer: Drawer(

          child:Container(
            color: Colors.white,
            child: ListView(

              padding: EdgeInsets.zero,
              children: [

                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
              color:Color(0xff293462),
              child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      new Image.asset('assets/images/logomain.png',
                          width: 150, height: 150),
                    ],
                  ),
                ),


                InkWell(
                    child: Center(
                        child: Container(

                            child: Container(

                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              color: Colors.white,
                              child:Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 15,
                                    child: Container(

                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight:  Radius.circular(0),bottomRight:  Radius.circular(0)),
                                        border: Border.all(color: Colors.transparent),

                                        gradient: new LinearGradient(
                                            colors: [
                                              //const Color(0xffFFFFFF).withOpacity(0.7),
                                              //const Color(0xffFFFFFF).withOpacity(0.9),
                                              Colors.transparent,
                                              Colors.transparent,

                                            ],
                                            begin: const FractionalOffset(0.0, 0.0),
                                            end: const FractionalOffset(1.0, 0.0),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                      ),

                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),

                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 85,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child : Text(
                                        'Liverate',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.normal),
                                      ),

                                    ),
                                  ),

                                ],
                              ),

                            )
                        )
                    ),
                    onTap:() {
                      Navigator.of(context).pop();
                      onPageChanged(0);
                      navigationTapped(0);

                    }
                ),
                InkWell(
                    child: Center(
                        child: Container(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              color: Colors.white,
                              child:Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 15,
                                    child: Container(

                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight:  Radius.circular(0),bottomRight:  Radius.circular(0)),
                                        border: Border.all(color: Colors.transparent),

                                        gradient: new LinearGradient(
                                            colors: [
                                              //const Color(0xffFFFFFF).withOpacity(0.7),
                                              //const Color(0xffFFFFFF).withOpacity(0.9),
                                              Colors.transparent,
                                              Colors.transparent,

                                            ],
                                            begin: const FractionalOffset(0.0, 0.0),
                                            end: const FractionalOffset(1.0, 0.0),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                      ),

                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),

                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 85,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child : Text(
                                        'Updates',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.normal),
                                      ),

                                    ),
                                  ),

                                ],
                              ),

                            )
                        )
                    ),
                    onTap:() {
                      Navigator.of(context).pop();
                      onPageChanged(1);
                      navigationTapped(1);


                    }
                ),
                InkWell(
                    child: Center(
                        child: Container(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              color: Colors.white,
                              child:Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 15,
                                    child: Container(

                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight:  Radius.circular(0),bottomRight:  Radius.circular(0)),
                                        border: Border.all(color: Colors.transparent),

                                        gradient: new LinearGradient(
                                            colors: [
                                              //const Color(0xffFFFFFF).withOpacity(0.7),
                                              //const Color(0xffFFFFFF).withOpacity(0.9),
                                              Colors.transparent,
                                              Colors.transparent,

                                            ],
                                            begin: const FractionalOffset(0.0, 0.0),
                                            end: const FractionalOffset(1.0, 0.0),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                      ),

                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),

                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 85,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child : Text(
                                        'Bankdetails',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.normal),
                                      ),

                                    ),
                                  ),

                                ],
                              ),

                            )
                        )
                    ),
                    onTap:() {
                      Navigator.of(context).pop();

                      onPageChanged(2);
                      navigationTapped(2);


                    }
                ),
                InkWell(
                    child: Center(
                        child: Container(
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              color: Colors.white,
                              child:Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 15,
                                    child: Container(

                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.only(topRight:  Radius.circular(0),bottomRight:  Radius.circular(0)),
                                        border: Border.all(color: Colors.transparent),

                                        gradient: new LinearGradient(
                                            colors: [
                                              //const Color(0xffFFFFFF).withOpacity(0.7),
                                              //const Color(0xffFFFFFF).withOpacity(0.9),
                                              Colors.transparent,
                                              Colors.transparent,

                                            ],
                                            begin: const FractionalOffset(0.0, 0.0),
                                            end: const FractionalOffset(1.0, 0.0),
                                            stops: [0.0, 1.0],
                                            tileMode: TileMode.clamp),
                                      ),

                                      child: Container(
                                        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),

                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 85,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child : Text(
                                        'Contact us',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.normal),
                                      ),

                                    ),
                                  ),

                                ],
                              ),

                            )
                        )
                    ),
                    onTap:() {
                      Navigator.of(context).pop();

                      onPageChanged(3);
                      navigationTapped(3);


                    }
                ),
                InkWell(
                  child: Center(
                      child: Container(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            color: Colors.white,
                            child:Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 15,
                                  child: Container(

                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.only(topRight:  Radius.circular(0),bottomRight:  Radius.circular(0)),
                                      border: Border.all(color: Colors.transparent),

                                      gradient: new LinearGradient(
                                          colors: [
                                            //const Color(0xffFFFFFF).withOpacity(0.7),
                                            //const Color(0xffFFFFFF).withOpacity(0.9),
                                            Colors.transparent,
                                            Colors.transparent,

                                          ],
                                          begin: const FractionalOffset(0.0, 0.0),
                                          end: const FractionalOffset(1.0, 0.0),
                                          stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp),
                                    ),

                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child: Image.asset('assets/images/markettrend.png',
                                          width: 25, height: 25),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 85,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child : Text(
                                      'Market trendz',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.normal),
                                    ),

                                  ),
                                ),

                              ],
                            ),

                          )
                      )
                  ),
                  onTap:() {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Markettrendz()));

                  }
              ),
                InkWell(
                  child: Center(
                      child: Container(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            color: Colors.white,
                            child:Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 15,
                                  child: Container(

                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.only(topRight:  Radius.circular(0),bottomRight:  Radius.circular(0)),
                                      border: Border.all(color: Colors.transparent),

                                      gradient: new LinearGradient(
                                          colors: [
                                            //const Color(0xffFFFFFF).withOpacity(0.7),
                                            //const Color(0xffFFFFFF).withOpacity(0.9),
                                            Colors.transparent,
                                            Colors.transparent,

                                          ],
                                          begin: const FractionalOffset(0.0, 0.0),
                                          end: const FractionalOffset(1.0, 0.0),
                                          stops: [0.0, 1.0],
                                          tileMode: TileMode.clamp),
                                    ),

                                    child: Container(
                                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      child:Image.asset('assets/images/ecocalendar.png',
                                          width: 25, height: 25),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 85,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child : Text(
                                      'Economic calendar',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.normal),
                                    ),

                                  ),
                                ),

                              ],
                            ),

                          )
                      )
                  ),
                  onTap:() {
                    Navigator.of(context).pop();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EcomomicCalendar()));

                  }
              ),



              ],
            ),

          )
        ),


        // body: PageView(
      //   children: [
      //     new LiveRate(),
      //     new Updates(),
      //     new BankDetails(),
      //     new ContactUs(),
      //   ],
      //   onPageChanged: onPageChanged,
      //   controller: _pageController,
      // ),

      body: Builder(
        builder: (context) =>
            Column(
              children: <Widget>[
                // Container(
                //   alignment: Alignment.center,
                //   margin: EdgeInsets.all(5),
                //   child: Row(
                //     mainAxisSize: MainAxisSize.max,
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Image.asset('assets/images/logo.png',width: 250, height: 50),
                //     ],
                //   ),),

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
                          border: Border.all(color: const Color(0xff293462)),

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


                        child:new Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            new Column(
                              children: <Widget>[
                                Container(
                                  color:const Color(0xff293462),
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 15,
                                        child: Container(


                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.only(topRight:  Radius.circular(0),bottomRight:  Radius.circular(0)),
                                            border: Border.all(color: Colors.transparent),

                                            gradient: new LinearGradient(
                                                colors: [
                                                  //const Color(0xffFFFFFF).withOpacity(0.7),
                                                  //const Color(0xffFFFFFF).withOpacity(0.9),
                                                  Colors.transparent,
                                                  Colors.transparent,

                                                ],
                                                begin: const FractionalOffset(0.0, 0.0),
                                                end: const FractionalOffset(1.0, 0.0),
                                                stops: [0.0, 1.0],
                                                tileMode: TileMode.clamp),
                                          ),

                                          child: IconButton(
                                            icon: Icon(
                                                Icons.menu,
                                                size: 30,
                                                color:Colors.white
                                            ),
                                            tooltip: 'Menu',
                                            onPressed: () {
                                              // _scaffoldKey.currentState.openDrawer();
                                              Scaffold.of(context).openDrawer();
                                              // _scaffoldKey.currentState.openDrawer();



                                            },
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 60,
                                        child: Container(
                                          color: Colors.transparent,
                                          alignment: Alignment.centerLeft,
                                          child : Image.asset('assets/images/logo.png',height: 50),

                                        ),
                                      ),
                                      Expanded(
                                        flex: 15,
                                        child: Container(
                                          alignment: Alignment.centerRight,

                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          color: Colors.transparent,

                                          // decoration: new BoxDecoration(
                                          //   borderRadius: BorderRadius.only(topRight:  Radius.circular(50),bottomRight:  Radius.circular(50)),
                                          //   border: Border.all(color: Colors.transparent),
                                          //
                                          //   gradient: new LinearGradient(
                                          //       colors: [
                                          //         const Color(0xffffffff),
                                          //         const Color(0xffffffff),
                                          //       ],
                                          //       begin: const FractionalOffset(0.0, 0.0),
                                          //       end: const FractionalOffset(1.0, 0.0),
                                          //       stops: [0.0, 1.0],
                                          //       tileMode: TileMode.clamp),
                                          // ),
                                          child:IconButton(
                                            icon: Image.asset('assets/images/whatsappnew.png',width: 80, height: 80),
                                            tooltip: 'call',
                                            onPressed: () {
                                              whatsAppOpen();
                                            },
                                          ),

                                        ),
                                      ),
                                      Expanded(
                                        flex: 15,
                                        child: Container(
                                          alignment: Alignment.centerLeft,

                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          color: Colors.transparent,

                                          // decoration: new BoxDecoration(
                                          //   borderRadius: BorderRadius.only(topRight:  Radius.circular(50),bottomRight:  Radius.circular(50)),
                                          //   border: Border.all(color: Colors.transparent),
                                          //
                                          //   gradient: new LinearGradient(
                                          //       colors: [
                                          //         const Color(0xffffffff),
                                          //         const Color(0xffffffff),
                                          //       ],
                                          //       begin: const FractionalOffset(0.0, 0.0),
                                          //       end: const FractionalOffset(1.0, 0.0),
                                          //       stops: [0.0, 1.0],
                                          //       tileMode: TileMode.clamp),
                                          // ),
                                          child:IconButton(
                                            icon: Icon(
                                                Icons.phone,
                                                size: 30,
                                                color:Colors.white
                                            ),
                                            tooltip: 'call',
                                            onPressed: () {
                                              CallDialog(context);
                                            },
                                          ),

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
                  color: Colors.grey,
                  width: double.infinity,
                  height: 1,

                ),


                Visibility(
                  visible: marquee_top,
                  child:Expanded(
                    flex: 4,
                    child: Container(
                        color: const Color(0xffBD8A3C),
                        margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                        child: Marquee(

                          text: Marquee1,
                          blankSpace: 400,


                          style: TextStyle(
                              backgroundColor:const Color(0xffBD8A3C),
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          velocity: 90,
                        )

                    ),


                  ),

                ),

                Expanded(
                  flex: 80,
                  child: PageView(

                    children: [
                      new LiveRate(),
                      new Updates(),
                      new BankDetails(),
                      new ContactUs(),


                    ],
                    onPageChanged: onPageChanged,
                    controller: _pageController,

                  ),

                ),


                Visibility(
                  visible: marquee_bottom,
                  child:Expanded(
                    flex: 4,
                    child: Container(
                        color: const Color(0xffBD8A3C),
                        child: Marquee(
                          blankSpace: 400,
                          text: Marquee2,
                          style: TextStyle(
                              backgroundColor:const Color(0xffBD8A3C),
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),
                          scrollAxis: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          velocity: 90,
                        )

                    ),


                  ),

                ),
              ],
            )
      ),







      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: const Color(0xffBD8A3C),

        ), // sets the inactive color of the `BottomNavigationBar`
        child: new BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          selectedItemColor: const Color(0xff293462),
          unselectedItemColor: const Color(0xff000000),
          type: BottomNavigationBarType.fixed,
          items: [
            new BottomNavigationBarItem(
                icon: new Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 2),

                ),
                title: new Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                  child: Text("LIVERATE",style: TextStyle(fontFamily: 'RobotoRegular')),

                )),
            new BottomNavigationBarItem(
                icon: new Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 2),

                ),
                title: new Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                  child: Text("UPDATES",style: TextStyle(fontFamily: 'RobotoRegular')),

                )),
            new BottomNavigationBarItem(
                icon: new Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 2),

                ),
                title: new Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                  child: Text("BANKDETAILS",style: TextStyle(fontFamily: 'RobotoRegular')),

                )),
            new BottomNavigationBarItem(
                icon: new Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 2),

                ),
                title: new Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                  child: Text("CONTACT US",style: TextStyle(fontFamily: 'RobotoRegular')),

                )),
          ],
          onTap: navigationTapped,
          currentIndex: _page,

        ),
      ),


    );
  }
}




//Image.asset('assets/images/logo.png',width: 50, height: 50)