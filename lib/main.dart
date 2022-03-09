import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: ConnectionPage(),
    );
  }
}

class ConnectionPage extends StatefulWidget {
  ConnectionPage({Key? key}) : super(key: key);

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  String status = 'Waiting...';
  Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  // @override
  // void initState() {
  //   super.initState();
  //   connectivity();
  // }

  // void connectivity() async {
  //   var connectionResult = await _connectivity.checkConnectivity();

  //   if (connectionResult == ConnectivityResult.mobile) {
  //     status = 'MobileData';
  //   } else if (connectionResult == ConnectivityResult.wifi) {
  //     status = 'WiFiData';
  //   } else {
  //     status = 'Not Connected';
  //   }
  //   setState(() {});
  // }
  @override
  void initState() {
    super.initState();
    realtTimeConnection();
  }

  void realtTimeConnection() {
    _streamSubscription = _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.mobile) {
        status = 'MobileData';
      } else if (event == ConnectivityResult.wifi) {
        status = 'WifiData';
      } else {
        status = 'Not Connected';
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Connection Check App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              status,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // connectivity();
        },
        child: const Icon(Icons.local_airport),
      ),
    );
  }
}
