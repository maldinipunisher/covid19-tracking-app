part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  final Users user;
  final Weather weatherData;
  const ProfilePage({Key key, @required this.user, @required this.weatherData})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var dateNow = DateTime.now().hour;
  var day = DateTime.now().weekday;
  String greeting = "";
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
      body: Stack(
        children: [
          SafeArea(
            child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/pattern.jpg"),
                        fit: BoxFit.fitHeight,
                        repeat: ImageRepeat.noRepeat)),
                child: Container(
                  color: Colors.white.withOpacity(0.97),
                )),
          ),
          SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                              image: (widget.user.profilePicture == "")
                                  ? const AssetImage(
                                      "assets/images/profile_pic.png")
                                  : NetworkImage(widget.user.profilePicture)),
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AccountMenuPage()));
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, good $greeting",
                      style:
                          titleTextStyle.copyWith(fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 8),
                    Text(
                      widget.user.name.toString(),
                      style:
                          titleTextStyle.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 50),
                              width: 60,
                              height: 60,
                              child: RaisedButton(
                                  elevation: 0,
                                  onPressed: () async {},
                                  color: white,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(color: black, width: 1),
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
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
                      crossAxisSpacing: 20,
                      childAspectRatio: 9 / 10,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                      crossAxisCount: 2,
                      children: [
                        //1
                        if (widget.weatherData != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 2, bottom: 30),
                            child: CustomTileList(
                              height: 200,
                              padding: 10,
                              width: 100,
                              title: Text("Temperature",
                                  style: titleTextStyle.copyWith(
                                      color: black, fontSize: 17)),
                              heading: Text(
                                  ((widget.weatherData.temp - 32) * 5 / 9)
                                          .ceil()
                                          .toString()
                                          .trim() +
                                      " \u2103",
                                  style: titleTextStyle.copyWith(
                                      color: (((widget.weatherData.temp - 32) *
                                                      5 /
                                                      9)
                                                  .ceil() >=
                                              32)
                                          ? Colors.orange[400]
                                          : (((widget.weatherData.temp - 32) *
                                                          5 /
                                                          9)
                                                      .ceil() >=
                                                  36)
                                              ? salmon
                                              : gray,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40)),
                              icon: Icon(Ionicons.thermometer_outline,
                                  color: salmon, size: 30),
                              leading: Center(
                                  child: Image.network(
                                      "$weatherIconUrl${widget.weatherData.icon}@2x.png")),
                            ),
                          ),
                        if (widget.weatherData == null)
                          SpinKitFadingCircle(color: salmon),

                        //2
                        if (widget.weatherData != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 2),
                            child: CustomTileList(
                              height: 200,
                              padding: 10,
                              width: 100,
                              title: Text("Weather",
                                  style: titleTextStyle.copyWith(
                                      color: black, fontSize: 17)),
                              action: Text(
                                  widget.weatherData.weatherStatus.toString(),
                                  style: titleTextStyle.copyWith(
                                      color:
                                          (widget.weatherData.weatherStatus ==
                                                  "Clear")
                                              ? Colors.deepOrange[400]
                                              : lightBlue2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              leading: Text(widget.weatherData.city,
                                  style: titleTextStyle.copyWith(
                                      color: gray,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              icon: const Icon(Ionicons.sunny_outline,
                                  color: Colors.yellow, size: 30),
                              heading: Center(
                                  child: Image.network(
                                      "$weatherIconUrl${widget.weatherData.icon}@4x.png")),
                            ),
                          ),
                        if (widget.weatherData == null)
                          SpinKitFadingCircle(color: blue),

                        //3
                        if (widget.weatherData != null)
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 2, bottom: 30),
                              child: CustomTileList(
                                height: 200,
                                padding: 10,
                                width: 100,
                                title: Text("Air Pressure",
                                    style: titleTextStyle.copyWith(
                                        color: black, fontSize: 17)),
                                heading: Text(
                                    widget.weatherData.pressure.toString() +
                                        " mb",
                                    style: titleTextStyle.copyWith(
                                        color: (widget.weatherData.pressure
                                                    .ceil() >=
                                                1000)
                                            ? Colors.orange[400]
                                            : gray,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                                icon: Icon(Ionicons.speedometer_outline,
                                    color: salmon, size: 30),
                                action: Text(widget.weatherData.city.toString(),
                                    style: titleTextStyle.copyWith(
                                        color: gray, fontSize: 17)),
                                leading: Icon(Ionicons.earth_outline,
                                    color: lightBlue1, size: 30),
                              )),
                        if (widget.weatherData == null)
                          SpinKitFadingCircle(color: salmon),

                        //4
                        if (widget.weatherData != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 30, bottom: 2),
                            child: CustomTileList(
                              height: 200,
                              padding: 10,
                              width: 100,
                              title: Text("Humidity",
                                  style: titleTextStyle.copyWith(
                                      color: black, fontSize: 17)),
                              heading: Center(
                                child: Text(
                                    "${widget.weatherData.humid.toString()} %",
                                    style: titleTextStyle.copyWith(
                                        color:
                                            (widget.weatherData.humid.ceil() >=
                                                    75)
                                                ? lightBlue3
                                                : (widget.weatherData.humid
                                                            .ceil() >=
                                                        85)
                                                    ? lightBlue1
                                                    : gray,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 40)),
                              ),
                              action: Text(widget.weatherData.city,
                                  style: titleTextStyle.copyWith(
                                      color: gray,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16)),
                              icon: Icon(Ionicons.water_outline,
                                  color: lightBlue2, size: 30),
                              leading: Text(""),
                            ),
                          ),
                        if (widget.weatherData == null)
                          SpinKitFadingCircle(color: blue),
                      ]),
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
        ],
      ),
    );
  }
}
