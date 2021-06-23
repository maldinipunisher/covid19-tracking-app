part of 'pages.dart';

class Wrapper extends StatelessWidget {
  final User user;

  const Wrapper({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(prevPageEvent);
    AuthServices.getUser().then((users) {
      if (users == null && user == null) {
        if (prevPageEvent is! GoToSplashPage) {
          prevPageEvent = GoToSplashPage();
          BlocProvider.of<PageBloc>(context).add(prevPageEvent);
        }
      } else {
        prevPageEvent = GoToMainPage(users);
        BlocProvider.of<PageBloc>(context).add(prevPageEvent);
      }
    });

    return BlocBuilder<PageBloc, PageState>(builder: (context, pageState) {
      return (pageState is OnMainPage)
          ? MainPage(pageState.userCredential)
          : SplashPage();
    });
  }
}
