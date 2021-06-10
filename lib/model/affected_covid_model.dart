part of 'model.dart';

class AffectedCovid {
  final confirmed;
  final recovered;
  final deaths;
  final lastUpdateDate;
  final lastUpdateTime;

  AffectedCovid(
      {@required this.confirmed,
      @required this.recovered,
      @required this.deaths,
      @required this.lastUpdateDate,
      @required this.lastUpdateTime});

  factory AffectedCovid.fromJson(Map<String, dynamic> data) {
    DateTime dateTime = DateTime.parse(data['lastUpdate']);
    return AffectedCovid(
      confirmed: data['confirmed']['value'],
      recovered: data['recovered']['value'],
      deaths: data['deaths']['value'],
      lastUpdateDate: "${dateTime.day}/${dateTime.month}/${dateTime.year}",
      lastUpdateTime: "${dateTime.toLocal().hour}:${dateTime.toLocal().minute}",
    );
  }
}
