import 'package:covid_tracking/services/services.dart';
import 'package:covid_tracking/ui/page/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bloc/page_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1080, 1920),
      builder: () => StreamBuilder<Object>(
          stream: AuthServices.userStatus,
          builder: (context, snapshot) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => PageBloc()),
              ],
              child: MaterialApp(
                home: Wrapper(),
                debugShowCheckedModeBanner: false,
              ),
            );
          }),
    );
  }
}
