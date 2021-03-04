// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:visnagarbullion/OTR.dart';
//
//
// void main() => runApp(MyApp());
//
//
//
// class MyApp extends StatelessWidget {
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Otr()));
//
//     // this._context = context;
//     //
//     //
//      getStringValuesSF();
//
//     return MaterialApp(
//
//         debugShowCheckedModeBanner: false,
//         home: Scaffold(
//           // body: Center(
//           //     child: Image.network(
//           //       'https://flutter-examples.com/wp-content/uploads/2021/01/happy_mothers_Day.gif',
//           //       width: 300,
//           //       height: 400,
//           //       fit: BoxFit.contain,
//           //     )),
//         ));
//
//
//   }
//
// getStringValuesSF() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String stringValue = prefs.getString('name');
//
//   if (stringValue != null && stringValue.isNotEmpty) {
//     print("login");
//     Navigator.of(_context).pushReplacement(MaterialPageRoute(builder: (context) => Otr()));
//     // Navigator.of(context).pushReplacementNamed('/HomeScreen');
//     // navigatorKey.currentState.pushNamed('/LoginPage');
//
//
//
//   }
//   else{
//     print("notlogin");
//     // navigatorKey.currentState.pushNamed('/someRoute');
//     //navigatorKey.currentState.pushNamed('/Otr');
//     Navigator.of(_context).pushReplacement(MaterialPageRoute(builder: (context) => Otr()));
//
//     // Navigator.of(context).pushReplacementNamed('/LoginPage');
//
//   }
// }
//
//
//
// }