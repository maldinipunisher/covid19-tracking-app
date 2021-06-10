import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_tracking/model/model.dart';
import 'package:equatable/equatable.dart';
part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(OnInitialPage());
  @override
  Stream<PageState> mapEventToState(
    PageEvent event,
  ) async* {
    if (event is GoToSignInPage) {
      yield OnSignInPage();
    } else if (event is GoToMainPage) {
      yield OnMainPage(event.userCredential);
    } else if (event is GoToPreferencePage) {
      yield OnPreferencePage(event.userCredential);
    } else {
      yield OnSplashPage();
    }
  }
}
