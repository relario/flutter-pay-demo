import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:relario_flutter_demo/relario/models/new_transaction.dart';
import 'package:relario_flutter_demo/relario/relario.dart';
import 'dart:developer' as developer;
import 'dart:async';

import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case "SmsSubscription123":
        developer.log("Sending Background SMS");
        RelarioService relario =
            RelarioService("6c0da5e46c7a42aaa33e0aa28545475d");
        return relario.getPublicIp().then((value) {
          developer.log("Got the IP Address ${value.ip}");
          return relario.createTransaction(NewTransaction(
              "sms",
              "Flutter Demo Client",
              "asphalt9",
              "Asphalt 9 App",
              value.ip,
              null,
              null,
              1));
        }).then((value) async {
          developer.log("Sending SMS to ${value.androidClickToSmsUrl}");
          var result = await const MethodChannel("com.relario.demo/bg_send").invokeMethod("SendSms",
              {'phoneList': value.phoneNumbersList, 'smsBody': value.smsBody});
          developer.log("Result for invoking native code is: $result");
          return result;
        }).then((value) {
          return true;
        }).catchError((error) {
          developer.log("Error ${error}");
          return false;
        });

        break;
    }
    return Future.value(true);
  });
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel("com.relario.demo/background_send");
  int _counter = 0;
  late Future<Ip> publicIp;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void sendSms() {
    developer.log("Sending SMS");
    RelarioService relario = RelarioService("6c0da5e46c7a42aaa33e0aa28545475d");
    relario.getPublicIp().then((value) {
      developer.log("Got the IP Address ${value.ip}");
      return relario.createTransaction(NewTransaction(
          "sms",
          "Flutter Demo Client",
          "asphalt9",
          "Asphalt 9 App",
          value.ip,
          null,
          null,
          1));
    }).then((value) {
      developer.log("Sending SMS to ${value.androidClickToSmsUrl}");
      Uri uri = Uri.parse(value.androidClickToSmsUrl!);
      return launchUrl(uri);
    });
    // }).then((value) => Timer.periodic(const Duration(seconds: 2), (timer) {
    //   relario.getTransaction(value.transactionId!);
    // }));
  }

  void sendBackgroundSms() {
    developer.log("Sending Background SMS");
    RelarioService relario = RelarioService("6c0da5e46c7a42aaa33e0aa28545475d");
    relario.getPublicIp().then((value) {
      developer.log("Got the IP Address ${value.ip}");
      return relario.createTransaction(NewTransaction(
          "sms",
          "Flutter Demo Client",
          "asphalt9",
          "Asphalt 9 App",
          value.ip,
          null,
          null,
          1));
    }).then((value) async {
      developer.log("Sending SMS to ${value.androidClickToSmsUrl}");
      var result = await platform.invokeMethod("SendSms",
          {'phoneList': value.phoneNumbersList, 'smsBody': value.smsBody});
      return result;
    });
  }

  void startSmsInBackgroundJob() {
    Workmanager().registerPeriodicTask(
        "SmsSubscription123", "SmsSubscription123",
        frequency: const Duration(minutes: 15),
        initialDelay: const Duration(seconds: 10));
    developer.log("Registered Periodic Task");
  }

  @override
  void initState() {
    super.initState();
    developer.log("Init state called");
    Workmanager().initialize(
        callbackDispatcher, // The top level function, aka callbackDispatcher
        isInDebugMode:
            true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
        );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ElevatedButton(onPressed: sendSms, child: const Text("Send Sms")),
            ElevatedButton(
                onPressed: sendBackgroundSms,
                child: const Text("Send Background Sms")),
            ElevatedButton(
                onPressed: startSmsInBackgroundJob,
                child: const Text("Subscribe Background Sms 1/20min"))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
