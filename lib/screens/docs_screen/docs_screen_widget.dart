import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:raksha/common/widgets/icon_and_images.dart';
import 'package:raksha/common/widgets/padding_margin.dart';
import 'package:raksha/common/widgets/prograss_indicator.dart';
import 'package:raksha/common/widgets/text_and_styles.dart';
import 'package:raksha/models/breast_cancer_info_model.dart';
import 'package:raksha/screens/docs_screen/docs_screen_bloc.dart';
import 'package:raksha/utils/colors.dart';
import 'package:raksha/utils/images.dart';
import 'package:raksha/utils/screen_utils.dart';
import 'package:video_player/video_player.dart';

Widget title() => Padding(
      padding: paddingSymmetric(horizontal: 13.0),
      child: labels(
        text:
            'Information on Breast Cancer Screening And Breast Self Examination.',
        fontWeight: FontWeight.w700,
        textAlign: TextAlign.center,
        maxLine: 2,
        size: 14.0,
      ),
    );

Widget dataList(context, List<BreastCancerInfoModel> data) {
  return GridView.count(
    padding: paddingAll(16.0),
    crossAxisCount: 2,
    mainAxisSpacing: 16.0,
    crossAxisSpacing: 16.0,
    children: data
        .map(
          (e) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: fromTextColor,
            ),
            child: (e.isVideo)
                ? GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            VideoPlayerWidget(url: e.imageUrl),
                      );
                    },
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Images.instance.networkImage(
                          url: e.thumbNail,
                          fit: BoxFit.fill,
                        ),
                        Center(
                          child: icons(
                            icon: Icons.play_circle_outline,
                            color: white,
                            size: 55.0,
                          ),
                        ),
                      ],
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => imageView(e.imageUrl),
                      );
                    },
                    child: e.imageUrl != null
                        ? Images.instance.networkImage(
                            url: e.imageUrl,
                            fit: BoxFit.fill,
                          )
                        : Images.instance.assetImage(
                            name: no_image,
                            fit: BoxFit.fill,
                          ),
                  ),
          ),
        )
        .toList(),
  );
}

class VideoPlayerWidget extends StatefulWidget {
  final String url;

  const VideoPlayerWidget({this.url});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  VideoPlayerController _controller;

  setUrl() async {
    _controller = VideoPlayerController.network(widget.url);
    _controller.initialize().then((_) {
      docsBloc.getDocsLoading(true);
      docsBloc.getPlayButton(false);
    });
  }

  @override
  void initState() {
    setUrl();
    super.initState();
  }

  @override
  void dispose() {
    _controller.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      insetPadding: paddingAll(10.0),
      contentPadding: paddingAll(10.0),
      children: [
        StreamBuilder(
            initialData: docsBloc.getDocsLoading(false),
            stream: docsBloc.docsLoadingStream,
            builder: (context, snapshot) {
              return (snapshot.hasData && snapshot.data)
                  ? Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        ),
                        StreamBuilder(
                          initialData: docsBloc.getPlayButton(false),
                          stream: docsBloc.playButtonStream,
                          builder: (context, snapshot) {
                            return (snapshot.hasData)
                                ? FloatingActionButton(
                                    mini: true,
                                    backgroundColor: primaryColor,
                                    onPressed: () {
                                      snapshot.data
                                          ? _controller.pause()
                                          : _controller.play();
                                      docsBloc.getPlayButton(!snapshot.data);
                                    },
                                    child: Icon(
                                      snapshot.data
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                    ),
                                  )
                                : Container();
                          },
                        ),
                      ],
                    )
                  : circularIndicator;
            }),
      ],
    );
  }
}

Widget imageView(String image) {
  return SimpleDialog(
    insetPadding: paddingAll(0.0),
    contentPadding: paddingAll(0.0),
    children: [
      Container(
        height: Screen.screenHeight * 0.7,
        width: Screen.screenWidth * 0.9,
        child: PhotoView(
          imageProvider: NetworkImage(image),
        ),
      ),
    ],
  );
}
