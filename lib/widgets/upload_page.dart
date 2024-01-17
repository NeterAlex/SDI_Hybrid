import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

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
              content: '进行识别前，请保证图片背景整洁且无显著遮挡。',
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
                      color: const Color.fromARGB(255, 241, 245, 255),
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
                          onTap: () {}),
                    ),
                  ),
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
  var imgFile = await asset.first.file;
  if (imgFile == null) return "";
  var imagePath = imgFile.path;
  return imagePath;
}

void handleImageUpload() {}
