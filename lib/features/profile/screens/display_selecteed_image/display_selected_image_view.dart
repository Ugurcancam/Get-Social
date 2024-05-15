import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codegen/gen/assets.gen.dart';
import 'package:codegen/gen/colors.gen.dart';
import 'package:etkinlikapp/features/bottom_navbar/bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:lottie/lottie.dart';

part 'display_selected_image_mixin.dart';

class DisplaySelectedImageView extends StatefulWidget {
  final String filePath;

  const DisplaySelectedImageView({required this.filePath, super.key});

  @override
  State<DisplaySelectedImageView> createState() => _DisplaySelectedImageViewState();
}

class _DisplaySelectedImageViewState extends State<DisplaySelectedImageView> with DisplaySelectedImageMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _isLoading
          ? _LottieLoadingWidget(isLoading: _isLoading)
          : Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _SelectedImage(croppedFile: _croppedFile, widget: widget),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _CancelButton(),
                    _SaveImageButton(isLoading: _isLoading, uploadFile: _uploadFile()),
                  ],
                ),
              ],
            ),
    );
  }
}

class _SaveImageButton extends StatefulWidget {
  bool? isLoading;
  final Future<void> uploadFile;
  _SaveImageButton({
    super.key,
    required this.isLoading,
    required this.uploadFile,
  });

  @override
  State<_SaveImageButton> createState() => _SaveImageButtonState();
}

class _SaveImageButtonState extends State<_SaveImageButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () async {
          setState(() {
            widget.isLoading = true;
          });
          await widget.uploadFile;
          setState(() {
            widget.isLoading = false;
          });
          await Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNavbar()),
          );
        },
        child: const Text('Kaydet', style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorName.primary,
          minimumSize: const Size(150, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/homepage');
        },
        child: const Text('Vazgeç', style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorName.primary,
          minimumSize: const Size(150, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class _SelectedImage extends StatelessWidget {
  const _SelectedImage({
    super.key,
    required File? croppedFile,
    required this.widget,
  }) : _croppedFile = croppedFile;

  final File? _croppedFile;
  final DisplaySelectedImageView widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        radius: 150,
        backgroundImage: _croppedFile != null
            ? Image.file(
                _croppedFile!,
              ).image
            : Image.file(
                File(widget.filePath),
              ).image,
      ),
    );
  }
}

class _LottieLoadingWidget extends StatelessWidget {
  const _LottieLoadingWidget({
    super.key,
    required bool isLoading,
  }) : _isLoading = isLoading;

  final bool _isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LottieBuilder.asset(
        Assets.json.animation.animationLoading.path,
        repeat: _isLoading,
        width: 200,
        height: 200,
      ),
    );
  }
}
