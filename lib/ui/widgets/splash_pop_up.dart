part of 'widgets.dart';

// ignore: use_key_in_widget_constructors
class SplashPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 30),
      title: const Center(child: Text("Sign In")),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SignInButton(Buttons.Google,
              elevation: 2, text: "Sign In With Google", onPressed: () async {
            AuthServices.googleSignIn().then((userCredential) async {
              final Users user = userCredential.user.convertToUsers();
              AuthServices.insertUserData();
              BlocProvider.of<PageBloc>(context).add(GoToPreferencePage(user));
              prevPageEvent = GoToPreferencePage(user);
              Navigator.pop(context);
            });
          }),
          // SignInButton(Buttons.FacebookNew,
          //     elevation: 2, text: "Sign In With Facebook", onPressed: () async {
          //   await AuthServices.facebookSignIn().then((userCredential) {
          //     final Users user = userCredential.user.convertToUsers();
          //     var state = BlocProvider.of<PageBloc>(context);
          //     state.add(GoToMainPage(user));
          //     Navigator.pop(context);
          //     AuthServices.insertUserData();
          //     print(userCredential);
          //   });
          // }),
        ],
      ),
    );
  }
}
