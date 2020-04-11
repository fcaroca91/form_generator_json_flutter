import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:challenge_wolf/ui/utils/utils.dart';
import 'package:flutter/services.dart';
import 'package:challenge_wolf/core/models/custom_requirement_model.dart';
import 'package:challenge_wolf/ui/widgets/widgets.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:provider/provider.dart';

import 'package:challenge_wolf/core/viewmodels/custom_requirements_repository.dart';

import 'package:challenge_wolf/ui/screens/home_components.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeComponents {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  final List<CustomRequirement> a = [];

  bool autoValidation = false;

  final Connectivity _connectivity = Connectivity();

  StreamSubscription<ConnectivityResult> _connectionSubscription;

  bool isOnline = true;

  var dataPrefs;

  bool setAttributeValue = false;

  @override
  void initState() {
    initConnectivity();
    _connectionSubscription = _connectivity.onConnectivityChanged
        .listen((ConnectivityResult result) async {
      await _updateConnectionStatus().then((bool isConnected) => setState(() {
            isOnline = isConnected;
          }));
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    final customRequirementsRepository =
        Provider.of<CustomRequirementsRepository>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Challenge Wolf'),
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Builder(builder: (context) {
        /* if (isOnline) {
          setAttributeValue = true; */
        return FutureProvider(
          initialData: a,
          create: (_) async {
            //////////////////////////////////////////////
            /* dataPrefs = json.decode(await DataStoreOffline.extractData());

            dataPrefs.forEach((k, v) {
              _fbKey.currentState.setAttributeValue(k, v);
            }); */

            return await customRequirementsRepository.fetchCustomRequirements();
          },
          child: Consumer(
            builder: (context, List<CustomRequirement> data, _) {
              initHomeComponents(context);
              setAttributeValue = !isOnline;
              print(dataPrefs);
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: FormBuilder(
                  key: _fbKey,
                  autovalidate: autoValidation,
                  readOnly: false,
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(
                        top: styles.sizeH(20),
                      ),
                      width: styles.sizeW(360),
                      constraints: BoxConstraints(
                        minHeight: styles.sizeH(663),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: homeComponents(data),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
        /* }  else {
          _fbKey.currentState.save();
          DataStoreOffline.saveData(_fbKey.currentState.value); */
        /* showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Alert Dialog"),
                  content: Text("Dialog Content"),
                );
              }); */

        /* return CustomDialog(
            title: "SIN CONEXIÓN",
            description:
                "Te haz quedado sin internet, una vez que se restablezca el acceso a internet, apareceran tus datos cargados",
            buttonText: "null",
            styles: styles,
          );
        }
      */
      }),
      floatingActionButton: SaveButton(
        onPressed: () {
          /* showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            barrierColor: Colors.black45,
            transitionDuration: const Duration(milliseconds: 500),
            pageBuilder: (BuildContext buildContext, Animation animation,
                Animation secondaryAnimation) {
              return CustomDialog(
                title: "SIN CONEXIÓN",
                description:
                    "Te haz quedado sin internet, una vez que se restablezca el acceso a internet, apareceran tus datos cargados",
                buttonText: "null",
                styles: styles,
              );
            },
          ); */
          if (_fbKey.currentState.saveAndValidate()) {
            print(_fbKey.currentState.value);
          } else {
            setState(() {
              autoValidation = true;
            });
            print(_fbKey.currentState.value);
            print("validation failed");
          }
        },
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

    await _updateConnectionStatus().then(
      (bool isConnected) => setState(
        () {
          isOnline = isConnected;
        },
      ),
    );
  }

  Future<bool> _updateConnectionStatus() async {
    bool isConnected;
    try {
      final List<InternetAddress> result =
          await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        isConnected = true;

        print("la perra");

        ///
        dataPrefs = json.decode(await DataStoreOffline.extractData());

        dataPrefs.forEach((k, v) {
          _fbKey.currentState.setAttributeValue(k, v);
        });

        //Navigator.of(context, rootNavigator: true).pop('dialog'); Navigator.pop(context);
      }
      if (setAttributeValue) {
        Navigator.of(context, rootNavigator: true).pop();
        dataPrefs = json.decode(await DataStoreOffline.extractData());

        dataPrefs.forEach((k, v) {
          _fbKey.currentState.setAttributeValue(k, v);
        });
      }
    } on SocketException catch (_) {
      isConnected = false;

      _fbKey.currentState.save();
      await DataStoreOffline.saveData(_fbKey.currentState.value);

      showDialog();
      return false;
    }
    return isConnected;
  }

  void showDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black45,
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return CustomDialog(
          title: "No Internet Connection",
          description:
              "you are left without internet, once internet access is restored, your loaded data will appear",
          buttonText: "FEipe",
          styles: styles,
        );
      },
    );
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    super.dispose();
  }
}
