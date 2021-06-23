part of 'extensions.dart';

extension UserExtension on User {
  Users convertToUsers({String country}) {
    return Users(displayName, country, profilePicture: photoURL);
  }
}
