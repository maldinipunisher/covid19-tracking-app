part of 'pages.dart';

class AccountMenuPage extends StatelessWidget {
  const AccountMenuPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(""),
          foregroundColor: lightBlue1,
          backgroundColor: lightBlue1),
      body: ListView(children: [
        ListTile(
          leading: const Icon(Ionicons.log_out_outline, size: 30),
          title: GestureDetector(
              onTap: () {
                AuthServices.signOut();
                BlocProvider.of<PageBloc>(context).add(GoToSplashPage());
                Navigator.of(context).pop();
              },
              child: const Text("Keluar")),
        ),
      ]),
    );
  }
}
