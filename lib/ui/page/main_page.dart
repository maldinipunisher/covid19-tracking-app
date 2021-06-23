part of 'pages.dart';

class MainPage extends StatefulWidget {
  final Users user;

  const MainPage(this.user, {Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  Weather _weather;
  PageController _pageController;
  int _pageIndex = 0;
  AffectedCovid _patients;
  // ignore: prefer_final_fields
  double _btnNavigatorSize = 30;
  @override
  void initState() {
    super.initState();
    ApiServices.getGeoLocation().then((geoPos) {
      setState(() {
        latitude = geoPos.latitude.toString();
        longtitude = geoPos.longitude.toString();
      });
      ApiServices.getWeatherData().then((weather) {
        setState(() {
          _weather = weather;
        });
      });
    });

    ApiServices.getCovidData(country: widget.user.country).then((affected) {
      setState(() {
        _patients = affected;
      });
    });

    _pageController = PageController(
      initialPage: _pageIndex,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom,
                      width: MediaQuery.of(context).size.width,
                      child: PageView(
                        controller: _pageController,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (index) {
                          setState(() {
                            _pageIndex = index;
                          });
                        },
                        children: [
                          ProfilePage(
                            user: widget.user,
                            weatherData: _weather,
                          ),
                          StatPage(widget.user, _patients),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 200,
              height: 70,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: (_pageIndex == 0) ? salmon : blue,
              ),
              child: Row(
                children: [
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      elevation: 0,
                      onPressed: () {
                        //go to settings
                        setState(() {
                          _pageIndex = 0;
                          _pageController.animateToPage(_pageIndex,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        });
                      },
                      color: Colors.transparent,
                      child: Center(
                        child: Icon(
                          Icons.person_rounded,
                          color: (_pageIndex == 0) ? white : gray,
                          size: (_pageIndex == 0)
                              ? _btnNavigatorSize + 10
                              : _btnNavigatorSize,
                        ),
                      )),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      elevation: 0,
                      onPressed: () {
                        //go to statistic
                        setState(() {
                          _pageIndex = 1;
                          _pageController.animateToPage(_pageIndex,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        });
                      },
                      color: Colors.transparent,
                      child: Center(
                        child: Icon(
                          Icons.bar_chart_rounded,
                          color: (_pageIndex == 1) ? white : gray,
                          size: (_pageIndex == 1)
                              ? _btnNavigatorSize + 10
                              : _btnNavigatorSize,
                        ),
                      )),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
