part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  final Users user;

  const ProfilePage({Key key, this.user}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _ProfilePageState createState() => _ProfilePageState(user);
}

class _ProfilePageState extends State<ProfilePage> {
  final Users user;
  var dateNow = DateTime.now().hour;
  var day = DateTime.now().weekday;
  String greeting = "";
  _ProfilePageState(this.user);
  double topPadding = 20;

  @override
  void initState() {
    super.initState();
    print(dateNow);
    if (dateNow < 12) {
      greeting = "morning";
    } else if (dateNow < 17) {
      greeting = "afternoon";
    } else {
      greeting = "evening";
    }
    Timer.periodic(const Duration(minutes: 15), (timer) {
      setState(() {
        dateNow = DateTime.now().hour;
        if (dateNow < 12) {
          greeting = "morning";
        } else if (dateNow < 17) {
          greeting = "afternoon";
        } else {
          greeting = "evening";
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    //get user info
                    print("tapped");
                  },
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: (user.profilePicture == "")
                              ? const AssetImage(
                                  "assets/images/profile_pic.png")
                              : NetworkImage(user.profilePicture)),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                Container(
                  height: 60,
                  width: 60,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      elevation: 0,
                      onPressed: () {
                        //go to settings
                      },
                      color: Colors.transparent,
                      child: Center(
                        child: Icon(
                          Icons.settings_outlined,
                          color: black,
                          size: 30,
                        ),
                      )),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello, good $greeting",
                  style: titleTextStyle.copyWith(fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 8),
                Text(
                  user.name.toString(),
                  style: titleTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Container(
                width: MediaQuery.of(context).size.width * 90 / 100,
                height: 200,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: LayoutBuilder(builder: (context, constrain) {
                        return Column(
                          children: [
                            Container(
                              width: constrain.maxWidth,
                              height: constrain.maxHeight - 30,
                              decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/recover_btn.jpg"),
                                      fit: BoxFit.fitWidth),
                                  borderRadius: BorderRadius.circular(25)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "How to recover from ",
                                  style: paragraphTextStyle,
                                ),
                                Text(
                                  "Covid 19",
                                  style: paragraphTextStyle.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          width: 60,
                          height: 60,
                          child: RaisedButton(
                              elevation: 0,
                              onPressed: () async {},
                              color: white,
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: black, width: 1),
                                  borderRadius: BorderRadius.circular(25.0)),
                              child: Icon(
                                Icons.arrow_forward,
                                size: 25,
                                color: black,
                              ))),
                    )
                  ],
                )),
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 52 / 100,
              width: MediaQuery.of(context).size.width * 95 / 100,
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisSpacing: 10,
                childAspectRatio: 9 / 12,
                padding: EdgeInsets.fromLTRB(20, 20, 20, 30),
                crossAxisCount: 2,
                children: List.generate(4, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: (index % 2 == 0) ? 2 : 30,
                        bottom: (index % 2 == 0) ? 30 : 2),
                    child: CustomTileList(
                      chartValue: [30, 20, 40, 50, 10, 10],
                      height: 100,
                      width: 60,
                      icon: Icon(Icons.android),
                      leading: Text(
                        "data",
                        style: titleTextStyle,
                      ),
                      title: "test",
                      subtitle: Text("data"),
                    ),
                  );
                }),
              ),
            ),
          ),
          // RaisedButton(
          //   onPressed: () {
          //     AuthServices.signOut();
          //     BlocProvider.of<PageBloc>(context).add(GoToSplashPage());
          //   },
          //   child: Text("Sign out"),
          // ),
        ],
      )),
    );
  }
}
