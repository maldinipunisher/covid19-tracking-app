import 'package:covid_tracking/services/services.dart';
import 'package:covid_tracking/ui/page/pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/page_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: AuthServices.userStatus,
        builder: (context, snapshot) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => PageBloc()),
            ],
            child: const MaterialApp(
              home: Wrapper(),
              debugShowCheckedModeBanner: false,
            ),
          );
        });
  }
}
