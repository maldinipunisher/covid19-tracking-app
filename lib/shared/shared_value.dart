part of 'shared.dart';

String globalAPI = "https://covid19.mathdro.id/api/";
//api hanya boleh dipanggil 1 menit sekali
//api.openweathermap.org/data/2.5/weather?q={city name},{state code},{country code}&appid={API key}
//api.openweathermap.org/data/2.5/weather?zip={zip code},{country code}&appid={API key}
String weatherApiKey = "&appid=ApiKey";
String latitude = "";
String longtitude = "";
String weatherAPI =
    "http://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longtitude";

Color salmon = const Color(0xffd53e43);
Color black = const Color(0xff2f2c3e);
Color blue = const Color(0xff2d3391);
Color gray = const Color(0xff99b0b4);
Color lightBlue1 = const Color(0xff6dbcc1);
Color lightBlue2 = const Color(0xff71b5b6);
Color lightBlue3 = const Color(0xff91d2cb);
Color white = const Color(0xFFF5F5F5);

TextStyle titleTextStyle = TextStyle(
    decoration: TextDecoration.none,
    fontFamily: GoogleFonts.ptSansCaption().fontFamily,
    fontStyle: GoogleFonts.ptSansCaption().fontStyle,
    fontSize: 30);

TextStyle paragraphTextStyle = TextStyle(
    decoration: TextDecoration.none,
    fontFamily: GoogleFonts.ptSansCaption().fontFamily,
    fontStyle: GoogleFonts.ptSansCaption().fontStyle,
    fontSize: 18,
    wordSpacing: 1.5);
PageEvent prevPageEvent;
List<String> availableLanguage = [
  "English",
  "Indonesia",
  "Chinese",
  "Korea",
  "Japanese"
];
