part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSignInPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToMainPage extends PageEvent {
  final Users userCredential;
  const GoToMainPage(this.userCredential);

  @override
  List<Object> get props => [];
}

class GoToPreferencePage extends PageEvent {
  final Users userCredential;
  const GoToPreferencePage(this.userCredential);

  @override
  List<Object> get props => [];
}
