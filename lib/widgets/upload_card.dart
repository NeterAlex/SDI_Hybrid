import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:sdi_hybrid/widgets/upload_page.dart';

class UploadCard extends StatefulWidget {
  const UploadCard({super.key});

  @override
  State<UploadCard> createState() => _UploadCardState();
}

class _UploadCardState extends State<UploadCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BrnNoticeBarWithButton(
          leftTagText: '提示',
          leftTagBackgroundColor: const Color(0xFFE0EDFF),
          leftTagTextColor: const Color(0xFF0984F9),
          content: '进行识别前，请保证图片背景整洁',
          backgroundColor: Colors.white,
          rightButtonText: '已知晓',
          rightButtonBorderColor: const Color(0xFFEBFFF7),
          rightButtonTextColor: const Color(0xFF0984F9),
          onRightButtonTap: () {},
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
                      name: '病害识别',
                      style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 8, 135, 235)),
                      direction: Direction.bottom,
                      padding: 4,
                      iconHeight: 30,
                      iconWidth: 30,
                      iconWidget: const Icon(
                        Icons.camera_alt_outlined,
                        color: Color.fromARGB(255, 8, 135, 235),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const Material(child: UploadPage())));
                      }),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
