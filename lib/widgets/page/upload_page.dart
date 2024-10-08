import 'dart:convert';
import 'dart:io';

import 'package:bruno/bruno.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sdi_hybrid/common/http.dart';
import 'package:sdi_hybrid/layout.dart';
import 'package:sdi_hybrid/state/flow_provider.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

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
  var isUploading = false;
  late UserProvider _userProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = Provider.of<UserProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FlowProvider>(
      builder: (context, flowProvider, _) {
        return Scaffold(
          appBar: BrnAppBar(
            themeData: BrnAppBarConfig.dark(),
            elevation: 4,
            title: '病害识别',
            backgroundColor: const Color.fromARGB(255, 0, 151, 87),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: BrnShadowCard(
                    circular: 8,
                    child: BrnSimpleSelection.radio(
                      menuName: "选择识别模型",
                      menuKey: "model",
                      items: lists,
                      defaultValue: uploadType,
                      onSimpleSelectionChanged:
                          (List<ItemEntity> filterParams) {
                        setState(() {
                          uploadType = filterParams.first.key!;
                        });
                        BrnToast.show(
                            "选择了${filterParams.first.name}模型", context);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: BrnShadowCard(
                          circular: 8,
                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                          color: Colors.white,
                          child: BrnIconButton(
                              name: '拍照',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 151, 87)),
                              direction: Direction.bottom,
                              padding: 4,
                              iconHeight: 30,
                              iconWidth: 30,
                              iconWidget: const Icon(
                                Icons.camera_alt_rounded,
                                color: Color.fromARGB(255, 0, 151, 87),
                              ),
                              onTap: () async {
                                final entity =
                                    await CameraPicker.pickFromCamera(context);
                                final file = await entity?.file;
                                setState(() {
                                  imagePath = file?.path ?? "";
                                });
                              }),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: BrnShadowCard(
                          circular: 8,
                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                          color: Colors.white,
                          child: BrnIconButton(
                              name: '图片',
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 0, 151, 87)),
                              direction: Direction.bottom,
                              padding: 4,
                              iconHeight: 30,
                              iconWidth: 30,
                              iconWidget: const Icon(
                                Icons.photo_size_select_actual_outlined,
                                color: Color.fromARGB(255, 0, 151, 87),
                              ),
                              onTap: () async {
                                final selectedImagePath =
                                    await _pickImage(context);
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
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: BrnShadowCard(
                              circular: 8,
                              padding:
                                  const EdgeInsets.fromLTRB(16, 16, 16, 16),
                              color: Colors.white,
                              child: imagePath == ""
                                  ? const Center(
                                      child: Text(
                                      "尚未选择图片",
                                      style: TextStyle(color: Colors.grey),
                                    ))
                                  : Image.file(File(imagePath),
                                      fit: BoxFit.cover),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        child: BrnBigMainButton(
                            title: "上传并识别",
                            isEnable: imagePath != "" && isUploading != true,
                            onTap: () async {
                              BrnLoadingDialog.show(context, content: "数据上传中");
                              setState(() {
                                isUploading = true;
                              });
                              final result = await _uploadImage(
                                  imagePath, uploadType, _userProvider.user.id);
                              if (result && context.mounted) {
                                BrnToast.show("识别成功", context);
                                BrnLoadingDialog.dismiss(context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Material(
                                            child: LayoutPage(title: ""))));
                                setState(() {
                                  imagePath = "";
                                  isUploading = false;
                                });
                              } else {
                                if (context.mounted) {
                                  BrnToast.show("识别失败", context);
                                  BrnLoadingDialog.dismiss(context);
                                  flowProvider.refreshHomePage();
                                  setState(() {
                                    isUploading = false;
                                  });
                                }
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
      },
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
