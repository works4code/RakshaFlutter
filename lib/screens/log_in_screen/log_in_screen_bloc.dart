import 'dart:async';
import 'package:rxdart/rxdart.dart';

class LogInBloc {
  StreamController<bool> logInLoadingController = BehaviorSubject<bool>();

  Stream<bool> get logInLoadingStream => logInLoadingController.stream;

  Sink<bool> get logInLoadingSink => logInLoadingController.sink;

  getLogInLoading(bool data) {
    logInLoadingSink.add(data);
  }

  void dispose() {
    logInLoadingController.close();
  }
}

final LogInBloc logInBloc = LogInBloc();
