import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget
{
  @override
  _MyAppstate createState() => _MyAppstate();

}

class _MyAppstate extends State<MyApp> {
  String text = "Hello World";
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    firebaseMessaging.configure(
        onLaunch: (Map<String, dynamic> msg)  {
      print(" on Launch called");
      return;
    }, onResume: (Map<String, dynamic> msg) {
      print(" on resume called");
      return;
    }, onMessage: (Map<String, dynamic> msg)   {
      print(" on message called");
      return;
    });

    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, alert: true, badge: true));
    firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings setting)
    {
      print("Ios Setting registered");
    });
    firebaseMessaging.getToken().then((token){
      update(token);
    });


    super.initState();
  }

  update (String token)
  {
    text=token;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Notification app',
      home: Scaffold(
        appBar: AppBar(
           title: Text("Notification App"),
        ),
        body: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
