import 'package:flutter/material.dart';
import 'package:challenge_wolf/ui/screens/home_styles.dart';

mixin HomeComponents{
  HomeStyles styles;

  void initHomeComponents(context){
    styles = HomeStyles(context);
  }

  Widget buttonTitleChoice(type) {
    switch (type) {
      case "save":
        return Text(
          'Guardar',
          style: styles.saveButtonTitle,
        );
        break;
      default:
        return Text(
          'Olvidar',
          style: styles.forgetButtonTitle,
        );
    }
  }
}

class ButtonComponent extends StatelessWidget {
  const ButtonComponent({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeStyles styles = HomeStyles(context);
  
    return Container(
      child: RaisedButton(
        child: Text("apretame", style: styles.saveButtonTitle,),
        onPressed: () => print("RAISED BUTTON PRESSED"),
      ),
    );
  }
}