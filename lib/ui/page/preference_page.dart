part of 'pages.dart';

class PreferencePage extends StatefulWidget {
  final Users _users;

  // ignore: use_key_in_widget_constructors
  const PreferencePage(this._users);
  @override
  // ignore: no_logic_in_create_state
  _PreferencePageState createState() => _PreferencePageState(_users);
}

class _PreferencePageState extends State<PreferencePage> {
  int currentIndex = 0;
  String language;
  String country = "Indonesia";
  bool _btnEnable = true;
  final Users _users;

  _PreferencePageState(this._users);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/wave-bg.jpg"),
                    fit: BoxFit.cover)),
          ),
          SafeArea(
            child: Container(
              color: white.withOpacity(0.9),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Select your language",
                        style: titleTextStyle,
                      ),
                      // ignore: sized_box_for_whitespace
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250,
                          child: GridView.count(
                              physics: const BouncingScrollPhysics(),
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 20,
                              padding: const EdgeInsets.all(30),
                              crossAxisCount: 2,
                              childAspectRatio: (5 / 1),
                              children: List.generate(availableLanguage.length,
                                  (index) {
                                return SelectableBox(
                                    activeColor: salmon,
                                    disabledColor: Colors.white,
                                    text: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        availableLanguage[index],
                                        textAlign: TextAlign.center,
                                        style: paragraphTextStyle.copyWith(
                                            color: (currentIndex == index)
                                                ? Colors.white
                                                : gray),
                                      ),
                                    ),
                                    height: 40,
                                    width: 70,
                                    isSelected: (currentIndex == index),
                                    borderRadius: 8,
                                    onTap: () {
                                      setState(() {
                                        currentIndex = index;
                                        language = availableLanguage[index];
                                      });
                                    });
                              }))),
                      if (_btnEnable)
                        Center(
                          child: Container(
                              margin:
                                  const EdgeInsets.only(top: 50, bottom: 20),
                              width: 70,
                              height: 70,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                  elevation: 0,
                                  onPressed: () async {
                                    setState(() {
                                      _btnEnable = false;
                                    });
                                    Timer(const Duration(seconds: 4), () {
                                      setState(() {
                                        _btnEnable = true;
                                      });
                                    });
                                    AuthServices.insertUserData(
                                        language: language, country: country);
                                    BlocProvider.of<PageBloc>(context)
                                        .add(GoToMainPage(_users));
                                  },
                                  color: salmon,
                                  shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          color: Colors.white, width: 2),
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    size: 40,
                                    color: Colors.white,
                                  ))),
                        ),
                      if (!_btnEnable)
                        SpinKitFadingCircle(
                          color: salmon,
                          size: 40,
                        ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
