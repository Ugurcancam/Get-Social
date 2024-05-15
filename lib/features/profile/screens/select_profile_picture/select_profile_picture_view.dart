import 'package:codegen/codegen.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:etkinlikapp/core/manager/file_manager.dart';
import 'package:etkinlikapp/features/profile/screens/display_selecteed_image/display_selected_image_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

part 'select_profile_picture_mixin.dart';

class SelectProfilePictureView extends StatefulWidget {
  const SelectProfilePictureView({super.key});

  @override
  State<SelectProfilePictureView> createState() => _SelectProfilePictureViewState();
}

class _SelectProfilePictureViewState extends State<SelectProfilePictureView> with SelectProfilePictureViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 18.0,
          top: 10,
          right: 18.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profil Fotoğrafı Seç', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
            const SizedBox(height: 20),
            Text('Çok sevdiğin bir selfien var mı? Hemen yükle.', style: TextStyle(fontSize: 15, color: Colors.grey)),
            const SizedBox(height: 80),
            InkWell(
              onTap: () => openAnimatedDialog(context),
              child: Center(
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  color: ColorName.primary,
                  strokeWidth: 2,
                  dashPattern: [16, 10],
                  radius: Radius.circular(10),
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.camera, size: 90, color: ColorName.primary),
                        const SizedBox(height: 15),
                        Text('Yükle', style: TextStyle(fontSize: 20, color: ColorName.primary, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
