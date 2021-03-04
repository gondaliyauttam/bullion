import 'dart:convert';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ContactUs/ContactUs.dart';
import 'Notiflyvariblae.dart';

class MyConstants extends InheritedWidget {
  static MyConstants of(BuildContext context) => context. dependOnInheritedWidgetOfExactType<MyConstants>();

  const MyConstants({Widget child, Key key}): super(key: key, child: child);

  static const String successMessage = 'Some message';
  static String ClientDattaa = '';
  static String Chart = '';
  static String ADVERTISEBANNERURL  = '';
  static String MyPage = '1';


  static String ClientId = '14';
  static String ClientName = 'punjabjewellers';
  static String PackeageName = 'com.PJGoldBullion';
  static String iOSAppId = '1466761389';
  static String NameApp = 'PJ Gold Bullion';







  static getContactData(BuildContext context) async {
    SocketIOManager manager = SocketIOManager();
    SocketIO socket = await manager.createInstance(SocketOptions('http://starlinejewellers.in:10004'));
    socket.connect();
    if(socket.isConnected() != null){
      print("dididididididdiid...");
      socket.emit("ClientData", [ClientName]);


      socket.emit("ClientHeaderDetails", [ClientName]);
      socket.emit("room", [ClientName]);

      socket.on('ClientHeaderDetails', (data2) {
        print('dinesh=====$data2');
       // MyConstants.ClientDattaa=json.encode(data2);
        MyConstants.ClientDattaa=json.encode(data2);
        setClientdata(MyConstants.ClientDattaa);
        NotifySocketUpdate.controller.add(json.encode(data2));




      });


    }else{
      print("Not connected...");

    }



  }


  static getContactData2(BuildContext context) async {
    SocketIOManager manager = SocketIOManager();
    SocketIO socket = await manager.createInstance(SocketOptions('http://starlinejewellers.in:10004'));
    socket.connect();
    if(socket.isConnected() != null){
     // print("dididididididdiid...");
      socket.emit("ClientData", [ClientName]);


      socket.emit("ClientHeaderDetails", [ClientName]);
      socket.emit("room", [ClientName]);

      socket.on('ClientHeaderDetails', (data2) {
       // print('dinesh=====$data2');
        // MyConstants.ClientDattaa=json.encode(data2);
        MyConstants.ClientDattaa=json.encode(data2);
        setClientdata(MyConstants.ClientDattaa);
        NotifySocketUpdate.controller_home.add(MyConstants.ClientDattaa);



      });


    }else{
      print("Not connected...");

    }



  }


  static GetMainData(BuildContext context) async {
    SocketIOManager manager = SocketIOManager();
    SocketIO socket = await manager.createInstance(SocketOptions('http://starlinejewellers.in:10004'));
    socket.connect();
    if(socket.isConnected() != null){
      socket.emit("ClientData", [ClientName]);
      socket.emit("room", [ClientName]);
      socket.on('ClientData', (Referance_Data2) {
        setClientData(json.encode(Referance_Data2));

      });
      socket.on('ClientHeaderDetails', (data2) {
        setClientHeaderDetails(json.encode(data2));
       // print("tetstssttsttstststs");


        NotifySocketUpdate.controller_maindata.add(json.encode(data2));


      });
      socket.on('message', (data) {
        setMainRate(json.encode(data));

        print("kfjldfkljdkljfdklfjdlfj="+json.encode(data));

        NotifySocketUpdate.controller_maindata.add(json.encode(data));

      });



    }



  }

  static GetChartData(BuildContext context) async {

    SocketIOManager manager = SocketIOManager();
    SocketIO socket = await manager.createInstance(SocketOptions('http://starlinechart.in:8089'));
    socket.onConnect((data){
    });
    socket.on("chart", (data){   //sample event
     // print("chart");
     // print(data);
      MyConstants.Chart=json.encode(data);
      setchart(MyConstants.Chart);

      NotifySocketUpdate.controller_chart.add(MyConstants.Chart);



    });
    socket.connect();

  }



  @override
  bool updateShouldNotify(MyConstants oldWidget) => false;

}

setClientData(String Responce) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('ClientData', Responce);

}
setClientHeaderDetails(String Responce) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('ClientHeaderDetails', Responce);

}

setMainRate(String Responce) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('MainRate', Responce);
}

setClientdata(String Responce) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('ClientDataContact', Responce);
}

setchart(String Responce) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('chart', Responce);
}


