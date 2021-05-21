import 'package:flutter/material.dart';
import 'package:raksha/common/widgets/padding_margin.dart';
import 'package:raksha/common/widgets/prograss_indicator.dart';
import 'package:raksha/common/widgets/space_and_dividers.dart';
import 'package:raksha/models/breast_cancer_info_model.dart';
import 'package:raksha/networks/db_constants.dart';
import 'package:raksha/screens/docs_screen/docs_screen_bloc.dart';
import 'package:raksha/utils/colors.dart';
import 'package:raksha/screens/docs_screen/docs_screen_widget.dart';
import 'package:raksha/utils/screen_utils.dart';

class DocsScreen extends StatefulWidget {
  const DocsScreen({Key key}) : super(key: key);

  @override
  _DocsScreenState createState() => _DocsScreenState();
}

class _DocsScreenState extends State<DocsScreen> {
  List<BreastCancerInfoModel> data = [];

  getData() {
    db.child(db_breast_cancer_info).once().then((value) {
      data.clear();
      value.value.forEach((v) {
        data.add(BreastCancerInfoModel(
          title: v[db_title].toString(),
          imageUrl: v[db_image_url].toString(),
          isVideo: v[db_is_video],
          thumbNail: v[db_thumb_nail].toString(),
        ));
      });
      docsBloc.setImageData(data);
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingAll(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpace(Screen.appbarHeight),
          title(),
          verticalSpace(21.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: primaryColor,
              ),
              child: StreamBuilder(
                initialData: docsBloc.setImageData([]),
                stream: docsBloc.imageLoadingStream,
                builder: (context, snapshot) {
                  return (snapshot.hasData)
                      ? dataList(context, data)
                      : circularIndicator;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
