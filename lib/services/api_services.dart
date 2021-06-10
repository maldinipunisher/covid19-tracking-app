part of 'services.dart';

class ApiServices {
  static Future<AffectedCovid> getCovidData({String country = ""}) async {
    final response = await http.get(Uri.parse(
        (country == "") ? globalAPI : "$globalAPI/countries/$country"));
    if (response.statusCode == 200) {
      return AffectedCovid.fromJson(
        jsonDecode(response.body),
      );
    } else {
      throw Exception();
    }
  }

  static Future<Weather> getWeatherData() async {
    final response = await http.get(Uri.parse("$weatherAPI$weatherApiKey"),
        headers: {"Accept": "application/json"});

    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  static Future<PermissionStatus> get getGeoPermission async =>
      await Permission.location.request();

  static Future<List<InternetAddress>> checkConnection(String address) async {
    final state = await InternetAddress.lookup(address);
    return state;
  }

  static Future<Position> getGeoLocation() async {
    bool _isGeoEnabled = false;
    LocationPermission permission;
    _isGeoEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_isGeoEnabled) {
      return Future.error("error : geo service is not enable");
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return Future.error("error : access denied for geolocation");
    }

    return await Geolocator.getCurrentPosition();
  }
}
