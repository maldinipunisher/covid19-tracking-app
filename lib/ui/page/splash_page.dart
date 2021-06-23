part of 'pages.dart';

// ignore: use_key_in_widget_constructors
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _animationTextController;

  Animation<double> _fadeAnimation1;
  Animation<double> _fadeAnimation2;
  Animation<double> _fadeAnimation3;

  bool _btnEnable = true;

  String firstLocale = Platform.localeName;

  @override
  void initState() {
    super.initState();
    ApiServices.getGeoPermission;

    _animationTextController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..forward();

    _fadeAnimation1 = CurvedAnimation(
      parent: _animationTextController,
      curve: const Interval(0.0, 0.2, curve: Curves.easeIn),
    );

    _fadeAnimation2 = CurvedAnimation(
      parent: _animationTextController,
      curve: const Interval(0.2, 0.4, curve: Curves.easeIn),
    );

    _fadeAnimation3 = CurvedAnimation(
      parent: _animationTextController,
      curve: const Interval(0.4, 0.6, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    _animationTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          color: white,
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowGlow();
              return;
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipPath(
                    clipper: CustomSplash(),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 50 / 100,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/splash_page.jpg"),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: FadeTransition(
                      opacity: _fadeAnimation1,
                      child: Text(
                        "Pakai masker",
                        style: titleTextStyle.copyWith(
                            color: black, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _fadeAnimation2,
                    child: Text(
                      "Selamatkan kehidupan",
                      style: titleTextStyle.copyWith(
                          color: black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  FadeTransition(
                    opacity: _fadeAnimation3,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 270.sp),
                      child: Text(
                        "Dapatkan informasi tentang penyakit dan ambil tindakan yang diperlukan untuk mengatasinya",
                        textAlign: TextAlign.center,
                        style: paragraphTextStyle.copyWith(
                            color: gray, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                  if (_btnEnable)
                    SizedBox(
                        width: ScreenUtil().setWidth(140),
                        height: ScreenUtil().setHeight(140),
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
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Center(
                                        child: SizedBox(
                                            height: 400.sp,
                                            child: SplashPopUp()));
                                  });
                            },
                            color: white,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: gray, width: 2),
                                borderRadius: BorderRadius.circular(25.0)),
                            child: const Icon(
                              Icons.arrow_forward,
                              size: 40,
                            ))),
                  if (!_btnEnable)
                    SpinKitFadingCircle(
                      color: black,
                      size: 40,
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
