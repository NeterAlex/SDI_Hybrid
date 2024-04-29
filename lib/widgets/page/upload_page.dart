import 'dart:convert';
import 'dart:io';

import 'package:bruno/bruno.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdi_hybrid/common/http.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../state/user_provider.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final List<ItemEntity> lists = [
    ItemEntity(key: 'downy', name: "大豆霜霉病", value: 'downy'),
    ItemEntity(key: 'powdery', name: "大豆白粉病", value: 'powdery')
  ];
  var uploadType = "downy";
  var imagePath = "";
  late UserProvider _userProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = Provider.of<UserProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BrnAppBar(
        themeData: BrnAppBarConfig.dark(),
        elevation: 4,
        title: '病害识别',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BrnNoticeBarWithButton(
              leftTagText: '提示',
              leftTagBackgroundColor: const Color(0xFFE0EDFF),
              leftTagTextColor: const Color(0xFF0984F9),
              content: '进行识别前，请保证图片背景整洁且无明显遮挡。',
              backgroundColor: Colors.white,
              rightButtonBorderColor: const Color(0xFFEBFFF7),
              rightButtonTextColor: const Color(0xFF0984F9),
              onRightButtonTap: () {},
            ),
            BrnSimpleSelection.radio(
              menuName: "选择识别模型",
              menuKey: "model",
              items: lists,
              defaultValue: uploadType,
              onSimpleSelectionChanged: (List<ItemEntity> filterParams) {
                setState(() {
                  uploadType = filterParams.first.key!;
                });
                BrnToast.show("选择了${filterParams.first.name}模型", context);
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Row(
                children: [
                  Expanded(
                    child: BrnShadowCard(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                      color: Colors.white,
                      child: BrnIconButton(
                          name: '选择图片',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 8, 135, 235)),
                          direction: Direction.bottom,
                          padding: 4,
                          iconHeight: 30,
                          iconWidth: 30,
                          iconWidget: const Icon(
                            Icons.photo_size_select_actual_outlined,
                            color: Color.fromARGB(255, 8, 135, 235),
                          ),
                          onTap: () async {
                            final selectedImagePath = await _pickImage(context);
                            setState(() {
                              imagePath = selectedImagePath;
                            });
                          }),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: BrnShadowCard(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                          color: Colors.white,
                          child: imagePath == ""
                              ? const Center(child: Text("尚未选择图片"))
                              : Image.file(File(imagePath), fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 30),
                    child: BrnBigMainButton(
                        title: "上传并识别",
                        isEnable: imagePath != "",
                        onTap: () async {
                          final result = await _uploadImage(
                              imagePath, uploadType, _userProvider.user.id);
                          if (result) {
                            BrnToast.show("识别成功", context);
                            Navigator.pop(context);
                            setState(() {
                              imagePath = "";
                            });
                          } else {
                            BrnToast.show("识别失败", context);
                          }
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String> _pickImage(BuildContext context) async {
  final List<AssetEntity>? asset = await AssetPicker.pickAssets(context,
      pickerConfig: const AssetPickerConfig(maxAssets: 1));
  if (asset == null) return "";
  final imageFile = await asset.first.file;
  if (imageFile == null) return "";
  return imageFile.path;
}

Future<bool> _uploadImage(String imagePath, String type, int userId) async {
  final formData = FormData.fromMap(
      {'file': await MultipartFile.fromFile(imagePath), 'user_id': userId});
  final resp = await dio.post("/calc/$type", data: formData);
  Map<String, dynamic> data = jsonDecode(resp.toString());
  return data["success"];
}
