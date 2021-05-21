import 'dart:async';
import 'package:raksha/models/breast_cancer_info_model.dart';
import 'package:rxdart/rxdart.dart';

class DocsBloc {
  StreamController<bool> docsLoadingController = BehaviorSubject<bool>();
  StreamController<bool> playButtonController = BehaviorSubject<bool>();
  StreamController<List<BreastCancerInfoModel>> imageLoadingController =
      BehaviorSubject<List<BreastCancerInfoModel>>();

  Stream<bool> get docsLoadingStream => docsLoadingController.stream;

  Stream<bool> get playButtonStream => playButtonController.stream;

  Stream<List<BreastCancerInfoModel>> get imageLoadingStream =>
      imageLoadingController.stream;

  Sink<bool> get docsLoadingSink => docsLoadingController.sink;

  Sink<bool> get playButtonSink => playButtonController.sink;

  Sink<List<BreastCancerInfoModel>> get imageLoadingSink =>
      imageLoadingController.sink;

  getDocsLoading(bool data) {
    docsLoadingSink.add(data);
  }

  getPlayButton(bool data) {
    playButtonSink.add(data);
  }
  setImageData(List<BreastCancerInfoModel> data) {
    imageLoadingSink.add(data);
  }

  void dispose() {
    docsLoadingController.close();
    playButtonController.close();
    imageLoadingController.close();
  }
}

final DocsBloc docsBloc = DocsBloc();
