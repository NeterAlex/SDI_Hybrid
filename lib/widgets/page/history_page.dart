import 'dart:convert';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/config.dart';
import '../../common/global.dart';
import '../../common/http.dart';
import '../../layout.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool enabled = false;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: requestList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const BrnPageLoading();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var data = snapshot.data;
          return BrnGallerySummaryPage(
            allConfig: data!,
            detailRightAction: (groupId, indexId) =>
                deleteButton(context, data, groupId, indexId),
          );
        }
      },
    );
  }
}

Widget deleteButton(BuildContext context, List<BrnPhotoGroupConfig>? data,
    int? groupId, int? indexId) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: ElevatedButton(
      onPressed: () async {
        BrnDialogManager.showSingleButtonDialog(
          themeData: BrnDialogConfig(
              backgroundColor: Colors.white,
              mainActionBackgroundColor: Colors.redAccent,
              mainActionTextStyle: BrnTextStyle(color: Colors.white)),
          context,
          title: "确定删除",
          label: '确定',
          message: "是否确认要删除该条识别结果？\n该结果将被永久删除。",
          onTap: () async {
            var image =
                data?[groupId!].configList?[indexId!] as BrnPhotoItemConfig;
            var imageId = image.name!.split(" - ")[2];
            var isSuccess = await deleteData(imageId);
            if (isSuccess && context.mounted) {
              BrnToast.showInCenter(text: "删除成功", context: context);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const Material(child: LayoutPage(title: ""))));
            } else {
              if (context.mounted) {
                BrnToast.showInCenter(text: "删除失败", context: context);
              }
            }
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
      child: const Text("删除", style: TextStyle(color: Colors.white)),
    ),
  );
}

Future<List<BrnPhotoGroupConfig>> requestList() async {
  // Build request
  final userId = Global.user.id;
  final response = await dio.get("/data/list?user_id=$userId");
  var config = await ConfigHelper.getConfig();
  Map<String, dynamic> resp = json.decode(response.toString());

  // Build ImageList
  List<BrnPhotoItemConfig> downyImageList = [];
  List<BrnPhotoItemConfig> powderyImageList = [];
  for (dynamic item in resp["data"]) {
    if (item["type"] == "downy") {
      var description = "";
      item["count"].forEach((k, v) => description += "$k：$v处\n");
      if (description == "") description = "未检出";
      downyImageList.add(BrnPhotoItemConfig(
          url: "${config.serverUrl}/${item["image"]}",
          showBottom: true,
          bottomCardModel: PhotoBottomCardState.cantFold,
          name:
              "霜霉病 - ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(item["time"]))} - ${item['id']} ",
          des: description));
    } else if (item["type"] == "powdery") {
      var description = "";
      item["count"].forEach((k, v) => description += "$k：$v处\n");
      if (description == "") description = "未检出";

      powderyImageList.add(BrnPhotoItemConfig(
          url: "${config.serverUrl}/${item["image"]}",
          showBottom: true,
          bottomCardModel: PhotoBottomCardState.cantFold,
          name:
              "白粉病 - ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(item["time"]))} - ${item['id']} ",
          des: description));
    }
  }

  var downyGroup = BrnPhotoGroupConfig(
      title: "霜霉病",
      configList: downyImageList,
      themeData: BrnGalleryDetailConfig.light());
  var powderyGroup = BrnPhotoGroupConfig(
      title: "白粉病",
      configList: powderyImageList,
      themeData: BrnGalleryDetailConfig.light());
  List<BrnPhotoGroupConfig> results = [downyGroup, powderyGroup];
  return results;
}

Future<bool> deleteData(String dataId) async {
  final userId = Global.user.id;
  final response = await dio.delete("/data?user_id=$userId&data_id=$dataId");
  Map<String, dynamic> resp = json.decode(response.toString());
  return resp["success"];
}
