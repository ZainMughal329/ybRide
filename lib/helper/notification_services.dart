import 'dart:convert';
import 'dart:developer';
import 'dart:math' as m;

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void initFirebase() async {
    FirebaseMessaging.onMessage.listen((message) {
      print("Message received ${message.data}");

      initNotifications(message);
      // showNotifications(message);

      //  if(Platform.isIOS){
      //   foregroundMessage();
      //   showNotifications(message);
      //
      // }
      //
      //
      // if (Platform.isAndroid) {
      //   initNotifications(message);
      //   showNotifications(message);
      // }
    });
  }

  void initNotifications(RemoteMessage message) async {
    var androidInitSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOSInitSettings = DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
      android: androidInitSettings,
      iOS: iOSInitSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (payload) {
          handleNotification(message);
        });

    // showNotifications(message);
  }

  void showNotifications(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        m.Random.secure().nextInt(100000).toString(), 'My first notification',
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: 'The channel description is here',
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
    );
    DarwinNotificationDetails darwinNotificationDetails =
    DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentBanner: true,
      presentList: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          1,
          message.notification!.title.toString(),
          message.notification!.body.toString(),
          notificationDetails);
    });
  }

  setupBackgroundInteractMsg() async {
    RemoteMessage? msg = await FirebaseMessaging.instance.getInitialMessage();
    if (msg != null) {
      handleNotification(msg);
    }
    await FirebaseMessaging.onMessageOpenedApp.listen((event) {
      showNotifications(event);
    });
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      showNotifications(message);
    });
  }

  void requestPermissions() async {
    NotificationSettings settings = await messaging.requestPermission(
      sound: true,
      badge: true,
      provisional: true,
      alert: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // log('Permission granted');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // log('Provisional Permission granted');
    } else {
      AppSettings.openAppSettings(
        type: AppSettingsType.notification,
      );
      // log('denied');
    }
  }

  Future<String> getToken() async {
    // String? token = await messaging.getToken();
    return "";
  }

  void refreshToken() {
    messaging.onTokenRefresh.listen((event) {
      // event.toString();
      // log('event');
    });
  }

  void handleNotification(RemoteMessage message) async {
    if (message.data['type'] == 'chat') {
      log('id:' + message.data['id']);
    } else {
      log('something  went wrong');
    }
  }

  Future foregroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  sendNotification(String title, String Notificbody, String token,
      String snackbarMsg) async {
    print('token:${token}');
    var data = {
      'to': token,
      'priority': 'high',
      'notification': {'title': title, 'body': Notificbody},
    };
    await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
          'key=AAAAsN6_Nmw:APA91bE6GuiCNsWPrJJKrId0gXzEMQHswcDv7v046zztKzcdMPVaVYQhn2-1UdlfK1a0cEVpu1LGw_i6fVuxWeY3Ctnnjr5YQX9jkLbBQ9aA5fkzKfJZR1HB1yf7onWmY86MNqmnic3m'
        }).then((value) {
      // Snackbar.showSnackBar('${snackbarMsg}.', Icons.send);
      log('send success');
    }).onError((error, stackTrace) {
      // Snackbar.showSnackBar('Error: ${error}.', Icons.send);
      log('failed with error::::::::$error');
    });
  }



  sendFcmNotification(
      String receiverId, String senderName, String message) async {
    var data = {
      "topic": receiverId,
      "data": {
        "sender": senderName,
        "message": message,
        "type": "notification"
      },
      "notification": {"title": senderName, "body": message}
    };
    var body = await jsonEncode(data);
    try{
      var res = await http.post(Uri.parse("https://rightredroof94.conveyor.cloud/api/Elai/SendNotificationChatGo"),
          headers: {
            "Content-Type": "application/json",
            'Accept': 'application/json',
          },
          body: body);
    }catch(e){
      print(e);
      print("Exception");
    }

  }
}