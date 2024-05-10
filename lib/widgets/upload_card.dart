import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import 'package:sdi_hybrid/widgets/page/upload_page.dart';

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
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: BrnShadowCard(
                  circular: 8,
                  blurRadius: 4,
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                  color: const Color.fromARGB(56, 162, 255, 165),
                  child: BrnIconButton(
                      name: '病害识别',
                      style: const TextStyle(
                          fontSize: 18, color: Color.fromARGB(255, 0, 151, 87)),
                      direction: Direction.bottom,
                      padding: 4,
                      iconHeight: 30,
                      iconWidth: 30,
                      iconWidget: const Icon(
                        Icons.camera_alt_outlined,
                        color: Color.fromARGB(255, 0, 151, 87),
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
