import 'dart:convert';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../common/config.dart';
import '../../common/global.dart';
import '../../common/http.dart';

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
            detailRightAction: (groupId, indexId) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () async {
                    var image = data[groupId!].configList?[indexId!]
                        as BrnPhotoItemConfig;
                    var imageId = image.name!.split(" - ")[2];
                    if (await deleteData(imageId)) {
                      BrnToast.showInCenter(text: "删除成功", context: context);
                    } else {
                      BrnToast.showInCenter(text: "删除失败", context: context);
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("删除"),
                ),
              );
            },
          );
        }
      },
    );
  }
}

Future<List<BrnPhotoGroupConfig>> requestList() async {
  // Build request
  final userId = Global.user.id;
  final response = await dio.get("/data/list?user_id=$userId");
  var config = await ConfigHelper.getConfig();
  Map<String, dynamic> resp = json.decode(
    response.toString(),
  );

  // Build ImageList
  List<BrnPhotoItemConfig> downyImageList = [];
  List<BrnPhotoItemConfig> powderyImageList = [];
  for (dynamic item in resp["data"]) {
    if (item["type"] == "downy") {
      var description = "";
      item["count"].forEach((k, v) => description += "$k：$v处\n");

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

      powderyImageList.add(BrnPhotoItemConfig(
          url: "${config.serverUrl}/${item["image"]}",
          showBottom: true,
          bottomCardModel: PhotoBottomCardState.cantFold,
          name:
              "白粉病 - ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(item["time"]))} - ${item['id']} ",
          des: description));
    }
  }

  var downyGroup =
      BrnPhotoGroupConfig(title: "霜霉病", configList: downyImageList);
  var powderyGroup =
      BrnPhotoGroupConfig(title: "白粉病", configList: powderyImageList);
  List<BrnPhotoGroupConfig> results = [downyGroup, powderyGroup];
  return results;
}

Future<bool> deleteData(String dataId) async {
  final userId = Global.user.id;
  final response = await dio.delete("/data?user_id=$userId&data_id=$dataId");
  Map<String, dynamic> resp = json.decode(response.toString());
  return bool.parse(resp["success"], caseSensitive: false);
}
