import 'dart:async';

import 'package:etkinlikapp/features/auth/domain/services/auth_service.dart';
import 'package:etkinlikapp/features/auth/domain/view_models/verify_email_view_model.dart';
import 'package:etkinlikapp/features/bottom_navbar/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

part 'verify_email_mixin.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> with VerifyEmailMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () async {
            await _authService.Logout(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(
            mailSvg,
            height: 200,
            width: 200,
          ),
          Text(
            'Emailinize bir doğrulama maili gönderdik. Lütfen mailinizi kontrol edin.',
            style: TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Center(
            child: ElevatedButton(
              onPressed: _buttonDisabled ? null : resetTimer,
              child: Text(_buttonDisabled ? '$_start saniye içerisinde yeniden kod gönderebilirsiniz' : 'Tekrar Gönder'),
            ),
          ),
        ],
      ),
    );
  }
}
