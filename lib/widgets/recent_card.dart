import 'dart:convert';

import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:sdi_hybrid/common/global.dart';

import '../common/config.dart';
import '../common/http.dart';

class RecentCard extends StatefulWidget {
  const RecentCard({super.key});

  @override
  State<RecentCard> createState() => _RecentCardState();
}

class _RecentCardState extends State<RecentCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Column(
        children: [
          const Text(
            "最新记录",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          FutureBuilder(
              future: buildDataList(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<RecentCardData>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const BrnPageLoading();
                } else if (snapshot.hasError) {
                  return const BrnPageLoading();
                } else {
                  var data = snapshot.data;
                  return MasonryGridView.count(
                    crossAxisCount: 2,
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index) =>
                        card(data[index]),
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                  );
                }
              }),
          const Center(
              child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("仅显示最新四条记录，更多请至识别记录查看",
                style: TextStyle(color: Colors.black38, fontSize: 12)),
          ))
        ],
      ),
    );
  }
}

Widget card(RecentCardData data) {
  return BrnShadowCard(
      circular: 8,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  data.type,
                  style: const TextStyle(
                      fontSize: 12, color: Color.fromARGB(255, 0, 151, 87)),
                ),
                const Expanded(child: SizedBox(width: 1)),
                Text(
                  data.time,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: SizedBox(
              child: Image.network(
                data.image,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
            child: SizedBox(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var line in data.info.trim().split("\n"))
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                    child: BrnTagCustom(
                      textColor: const Color.fromARGB(255, 0, 151, 87),
                      backgroundColor: const Color.fromARGB(56, 162, 255, 165),
                      tagText: line,
                      tagBorderRadius:
                          const BorderRadius.all(Radius.circular(4)),
                    ),
                  )
              ],
            )),
          )
        ],
      ));
}

class RecentCardData {
  String type;
  String time;
  String info;
  String image;

  RecentCardData(this.type, this.time, this.info, this.image);
}

Future<List<RecentCardData>> buildDataList() async {
  // Get data
  final userId = Global.user.id;
  final response = await dio.get("/data/recent?user_id=$userId&count=4");
  var config = await ConfigHelper.getConfig();
  Map<String, dynamic> resp = json.decode(response.toString());
  // Build data list
  List<RecentCardData> list = [];
  for (final data in resp["data"]) {
    final type = data["type"] == "powdery" ? "白粉病" : "霜霉病";
    final time = DateTime.parse(data["time"]);
    final finalTime = DateFormat('yyyy-MM-dd HH:mm').format(time);
    final image = "${config.serverUrl}/${data["image"]}";
    var description = "";
    data["count"].forEach((k, v) => description += "$k：$v处\n");
    final result = RecentCardData(type, finalTime, description, image);
    list.add(result);
  }
  return list;
}
