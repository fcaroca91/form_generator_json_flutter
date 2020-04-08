import 'package:challenge_wolf/core/models/custom_requirement_model.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:challenge_wolf/core/viewmodels/custom_requirements_repository.dart';

import 'package:challenge_wolf/ui/screens/home_components.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeComponents {
  @override
  Widget build(BuildContext context) {
    initHomeComponents(context);

    final customRequirementsRepository =
        Provider.of<CustomRequirementsRepository>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuarios'),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Align(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: customRequirementsRepository.fetchCustomRequirements(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text("ERROR");
            List<CustomRequirement> data = snapshot.data;

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Text(data[index].question),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

/* return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuarios'),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Container(
            width: styles.sizeW(180),
            height: styles.sizeH(400),
            color: Colors.blueGrey,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buttonTitleChoice("forget"),
                ButtonComponent(),
              ],
            ),
            ),
      ),
    ); */
