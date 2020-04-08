import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:connectivity/connectivity.dart';

import 'package:provider/provider.dart';

import 'package:challenge_wolf/locator.dart';

import 'package:challenge_wolf/ui/screens/screens.dart';

import 'package:challenge_wolf/core/viewmodels/custom_requirements_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  setupLocator();
  //Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _connectionSubscription;

  bool isOnline = true;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectionSubscription = _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      await _updateConnectionStatus().then((bool isConnected) => setState(() {
            isOnline = isConnected;
          }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CustomRequirementsRepository>(
          create: (context) => locator<CustomRequirementsRepository>(),
        )
      ],
      child: MaterialApp(
        home: Builder(builder: (context) {
          if (isOnline) {
            return HomePage();
          } else {
            return Container(
              child: Text("ESTAS SIN CONEXION"),
            );
          }
        }),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  Future<Null> initConnectivity() async {
    try {
      await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    if (!mounted) {
      return;
    }

    await _updateConnectionStatus().then((bool isConnected) => setState(() {
          isOnline = isConnected;
        }));
  }

  Future<bool> _updateConnectionStatus() async {
    bool isConnected;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;
      }
    } on SocketException catch (_) {
      isConnected = false;
      return false;
    }
    return isConnected;
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}
