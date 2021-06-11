// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:covid_tracking/model/model.dart';
import 'package:covid_tracking/services/services.dart';
import 'package:covid_tracking/shared/shared.dart';
import 'package:http/http.dart';

void main() async {
  final weather = await ApiServices.getWeatherData();
  print(weather);
}
