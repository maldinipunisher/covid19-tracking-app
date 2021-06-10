part of 'model.dart';

class Users {
  final String name;
  final String language;
  final String country;
  final String profilePicture;
  Users(this.name, this.language, this.country, {this.profilePicture = ""});
}
