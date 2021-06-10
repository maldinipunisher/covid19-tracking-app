part of 'extensions.dart';

extension UserExtension on User {
  Users convertToUsers({String language, String country}) {
    return Users(displayName, language, country, profilePicture: photoURL);
  }
}
