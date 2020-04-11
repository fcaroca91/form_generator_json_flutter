abstract class UtilsRegex {
  static String _prefix = "http://";

  static RegExp _urlRegExp = new RegExp(
    r"^(http|https)://",
    caseSensitive: false,
    multiLine: false,
  );

  static RegExp _pathRegExp = new RegExp(
    r"(\w||-||_|| ){1,}.\w{1,}$",
    caseSensitive: false,
    multiLine: false,
  );

  static urlVerification(String url) {
    if (_urlRegExp.hasMatch(url)) {
      return url;
    } else {
      url = _prefix + url;
      return url;
    }
  }

  static pathVerification(String path) {
    return _pathRegExp.stringMatch(path);
  }
}
