part of 'shared.dart';

String removeDigitsNumber(num number) {
  String char = number.toString();
  int charLength = char.length;
  String cleanedText = "";
  if (charLength > 6) {
    cleanedText =
        "${char.substring(0, charLength - 6)},${char.substring(charLength - 6, charLength - 5)}m";
  } else if (charLength > 3) {
    cleanedText =
        "${char.substring(0, charLength - 3)},${char.substring(charLength - 3, charLength - 2)}k";
  } else {
    cleanedText = char;
  }
  return cleanedText;
}

void openURL(String url) async =>
    await canLaunch(url) ? launch(url) : throw 'Could Not Open URL $url';
