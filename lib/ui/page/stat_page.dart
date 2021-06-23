part of 'pages.dart';

class StatPage extends StatefulWidget {
  final Users user;
  AffectedCovid patients;
  StatPage(this.user, this.patients, {Key key}) : super(key: key);
  @override
  _StatPageState createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  String countryCode;

  bool _isRefresed;

  @override
  void initState() {
    _isRefresed = false;
    countryCode = widget.user.country;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/images/menu_earth.png"),
                fit: BoxFit.fitHeight,
                colorFilter: ColorFilter.mode(lightBlue1, BlendMode.overlay),
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Statistik",
                            style: titleTextStyle.copyWith(
                                color: black, fontWeight: FontWeight.w400)),
                        Text("Penyebaran",
                            style: titleTextStyle.copyWith(
                                color: black, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(
                      width: 110,
                      height: 50,
                      child: CountryListPick(
                        appBar: AppBar(
                          backgroundColor: lightBlue1,
                        ),
                        pickerBuilder: (context, code) {
                          return DropdownButton(items: [
                            DropdownMenuItem(
                                child: Row(
                              children: [
                                Image.asset(
                                  code.flagUri,
                                  package: 'country_list_pick',
                                ),
                              ],
                            ))
                          ]);
                        },
                        theme: CountryTheme(
                          isShowFlag: true,
                          isShowTitle: true,
                          isShowCode: true,
                          isDownIcon: true,
                          showEnglishName: true,
                        ),
                        onChanged: (CountryCode code) async {
                          setState(() {
                            countryCode = code.code;
                          });
                          AuthServices.insertUserData(country: countryCode);
                          ApiServices.getCovidData(country: countryCode)
                              .then((affected) {
                            setState(() {
                              widget.patients = affected;
                            });
                          });
                        },
                        useUiOverlay: true,
                        useSafeArea: true,
                        initialSelection: countryCode,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(children: [
                ClipPath(
                  clipper: CustomStats(),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 30 / 100,
                    color: white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.patients != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //confirmed
                                Column(
                                  children: [
                                    Text(
                                        removeDigitsNumber(
                                                widget.patients.confirmed) ??
                                            "TIDAK ADA DATA",
                                        style: titleTextStyle.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: salmon,
                                            fontSize: 40)),
                                    Text("TERKONFIRMASI",
                                        style: paragraphTextStyle.copyWith(
                                            color: gray,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300)),
                                  ],
                                ),
                                //recovered
                                Column(
                                  children: [
                                    Text(
                                        removeDigitsNumber(
                                                widget.patients.recovered) ??
                                            "TIDAK ADA DATA",
                                        style: titleTextStyle.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.green,
                                            fontSize: 40)),
                                    Text("SEMBUH",
                                        style: paragraphTextStyle.copyWith(
                                            color: gray,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300)),
                                  ],
                                ),

                                //deaths
                                Column(
                                  children: [
                                    Text(
                                        removeDigitsNumber(
                                                widget.patients.deaths) ??
                                            "TIDAK ADA DATA",
                                        style: titleTextStyle.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: black,
                                            fontSize: 40)),
                                    Text("MENINGGAL",
                                        style: paragraphTextStyle.copyWith(
                                            color: gray,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300)),
                                  ],
                                ),
                              ],
                            ),
                          if (widget.patients == null)
                            SpinKitFadingCircle(color: salmon),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(
                right: 20,
                bottom: MediaQuery.of(context).size.height * 35 / 100),
            child: SizedBox(
                height: 60,
                width: 60,
                child: (_isRefresed == false)
                    ? RaisedButton(
                        elevation: 0,
                        onPressed: () async {
                          ApiServices.getCovidData(country: countryCode)
                              .then((affected) {
                            setState(() {
                              _isRefresed = true;

                              widget.patients = affected;
                            });

                            Future.delayed(Duration(seconds: 3), () {
                              setState(() {
                                _isRefresed = false;
                              });
                            });
                          });
                        },
                        color: white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)),
                        child: const Icon(
                          Ionicons.refresh_outline,
                          size: 25,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: white),
                        child: SpinKitFadingCircle(color: lightBlue1),
                      )),
          ),
        ),
      ]),
    );
  }
}
