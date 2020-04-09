abstract class Url {
  static String _prefix = "http://";

  static RegExp _regExp = new RegExp(
    r"^(http|https)://",
    caseSensitive: false,
    multiLine: false,
  );

  static  verification(String url){
    if (_regExp.hasMatch(url)) {
      return url;
    } else {
      url = _prefix + url;
      return url;
    }
  }
}
