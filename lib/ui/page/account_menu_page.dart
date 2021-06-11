part of 'pages.dart';

class AccountMenuPage extends StatelessWidget {
  const AccountMenuPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(""),
          foregroundColor: lightBlue1,
          backgroundColor: lightBlue1),
      body: ListView(children: [
        ListTile(
          leading: Icon(Ionicons.log_out_outline, size: 30),
          title: GestureDetector(
              onTap: () {
                AuthServices.signOut();
                BlocProvider.of<PageBloc>(context).add(GoToSplashPage());
                Navigator.of(context).pop();
              },
              child: Text("Sign Out")),
        ),
      ]),
    );
  }
}
