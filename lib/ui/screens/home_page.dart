import 'package:challenge_wolf/core/models/custom_requirement_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:provider/provider.dart';

import 'package:challenge_wolf/core/viewmodels/custom_requirements_repository.dart';

import 'package:challenge_wolf/ui/screens/home_components.dart';

class HomePage extends StatelessWidget with HomeComponents {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final List<CustomRequirement> a = [];

  Widget build(BuildContext context) {
    final customRequirementsRepository =
        Provider.of<CustomRequirementsRepository>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Lista de Usuarios'),
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
                autovalidate: false,
                readOnly: false,
                child: SingleChildScrollView(
                  child: Container(
                    width: styles.sizeW(360),
                    height: styles.sizeH(663),
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
    );
  }
}
