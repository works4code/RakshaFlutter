import 'dart:async';

import 'package:rxdart/rxdart.dart';

class DashboardScreenBloc {
  StreamController<int> pageNoController = BehaviorSubject<int>();

  Stream<int> get pageNoStream => pageNoController.stream;

  Sink<int> get pageNoSink => pageNoController.sink;

  getPageNoError(int data) {
    pageNoSink.add(data);
  }

  void dispose() {
    pageNoController.close();
  }
}

final DashboardScreenBloc dashboardScreenBloc = DashboardScreenBloc();
