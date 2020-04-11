import 'package:challenge_wolf/core/models/custom_requirement_model.dart';
import 'package:challenge_wolf/ui/widgets/widgets.dart';
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

  Widget build(BuildContext context) {
    final customRequirementsRepository =
        Provider.of<CustomRequirementsRepository>(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Challenge Wolf'),
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: FutureProvider(
        initialData: a,
        create: (_) async =>
            await customRequirementsRepository.fetchCustomRequirements(),
        child: Consumer(
          builder: (context, List<CustomRequirement> data, _) {
            initHomeComponents(context);
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
      ),
      floatingActionButton: SaveButton(
        onPressed: () {
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
}
