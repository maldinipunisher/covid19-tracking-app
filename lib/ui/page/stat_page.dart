part of 'pages.dart';

class StatPage extends StatefulWidget {
  StatPage({Key key}) : super(key: key);
  @override
  _StatPageState createState() => _StatPageState();
}

class _StatPageState extends State<StatPage> {
  CountryCode countryCode;

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
                        Text('Spread ',
                            style: titleTextStyle.copyWith(
                                color: black, fontWeight: FontWeight.w400)),
                        Text('Statistics',
                            style: titleTextStyle.copyWith(
                                color: black, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Container(
                      width: 100,
                      height: 50,
                      child: CountryListPick(
                        appBar: AppBar(
                          backgroundColor: lightBlue1,
                        ),
                        pickerBuilder: (context, countryCode) {
                          return DropdownButton(items: [
                            DropdownMenuItem(
                                child: Row(
                              children: [
                                Image.asset(
                                  countryCode.flagUri,
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
                        onChanged: (CountryCode code) {
                          countryCode = code;
                        },
                        useUiOverlay: true,
                        useSafeArea: true,
                        initialSelection: '+62',
                      ),
                    ),
                  ],
                ),
              ),
              ClipPath(
                clipper: CustomStats(),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  color: white,
                ),
              ),
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
              child: RaisedButton(
                elevation: 0,
                onPressed: () async {},
                color: white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                child: const Icon(
                  Ionicons.refresh_outline,
                  size: 25,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
