import 'package:challenge_wolf/ui/screens/home_styles.dart';
import 'package:challenge_wolf/ui/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLaunchHtml extends StatelessWidget {
  final String description;
  final HomeStyles styles;
  
  const UrlLaunchHtml({
    @required this.description,
    @required this.styles,
    key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: description ?? "",
      defaultTextStyle: styles.linkText,
      customTextAlign: (_) => TextAlign.center,
      onLinkTap: (url) async => await launch(Url.verification(url)),
    );
  }
}
