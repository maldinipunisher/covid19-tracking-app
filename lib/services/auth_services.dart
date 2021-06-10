part of 'services.dart';

class AuthServices {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static String loginType;
  static String message;
  static final _fb = FacebookLogin();

  static Future<UserCredential> googleSignIn() async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      loginType = "google";
      if (_auth.currentUser == null) {
        return await _auth.signInWithCredential(credential);
      } else {
        return await _auth.currentUser.linkWithCredential(credential);
      }
    } catch (e) {
      message = e.toString();
    }
  }

  static Future<UserCredential> facebookSignIn() async {
    try {
      final result = await _fb.logIn(permissions: [
        FacebookPermission.email,
        FacebookPermission.publicProfile
      ]);
      loginType = "facebook";
      switch (result.status) {
        case FacebookLoginStatus.success:
          print("success");
          final FacebookAccessToken fbToken = result.accessToken;
          final AuthCredential credential =
              FacebookAuthProvider.credential(fbToken.token);
          if (_auth.currentUser == null) {
            final res = await _auth.signInWithCredential(credential);
            print("${res.user.email}");
          } else {
            final res = await _auth.currentUser.linkWithCredential(credential);
            print("${res.user.email}");
          }
          break;
        case FacebookLoginStatus.cancel:
          print("cancelled");
          break;
        case FacebookLoginStatus.error:
          print("error");
          break;
        default:
      }
      // return await _auth
      //     .signInWithCredential(facebookAuthCredential)
      //     .whenComplete(() => print("login complete"));
    } catch (e) {
      message = e.toString();
    }
  }

  static void insertUserData(
      {String language = "English", String country = ""}) async {
    final CollectionReference userCol =
        FirebaseFirestore.instance.collection('users');
    final user = _auth.currentUser;
    user.convertToUsers(language: language, country: country);
    userCol
        .doc(user.uid)
        .set({
          'uid': user.uid,
          'email': user.email,
          'name': user.displayName,
          'language': language,
          'country': country,
          'profilePicture': user.photoURL
        })
        .whenComplete(() => message = "Document insert successfully")
        .catchError((error) => message = error.toString());
  }

  static Future<Users> getUser() async {
    try {
      final user = _auth.currentUser;
      print("current user ${user.uid}");
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final userData = snapshot.data() as Map;
      return user.convertToUsers(
          language: userData['language'], country: userData['country']);
    } catch (err) {
      message = err.toString();
    }
  }

  static Stream<User> get userStatus => _auth.authStateChanges();

  static void signOut() async {
    if (loginType == "google") {
      await _auth.signOut();
      await GoogleSignIn().signOut();
    } else if (loginType == "facebook") {
      await _auth.signOut();
      await _fb.logOut();
    } else {
      await _auth.signOut();
    }
  }
}
