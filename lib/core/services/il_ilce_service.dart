import 'dart:convert';

import 'package:etkinlikapp/core/models/il_ilce_model.dart';
import 'package:flutter/services.dart';

class IlIlceService {
  Future<List<IlIlceModel>> getIlIlces() async {
    final data = await rootBundle.loadString('assets/json/il_ilce.json');

    List<dynamic> jsonData = json.decode(data) as List<dynamic>;

    List<IlIlceModel> ilIlceList = jsonData.map((e) => IlIlceModel.fromJson(e as Map<String, dynamic>)).toList();

    return ilIlceList;
  }

  Future<List<String>> getIller() async {
    final data = await rootBundle.loadString('assets/json/il_ilce.json');
    final jsonData = json.decode(data) as List<dynamic>;
    return jsonData.map<String>((e) => e['il_adi'] as String).toList();
  }

  Future<List<String>> getIlceler(String ilAdi) async {
    final data = await rootBundle.loadString('assets/json/il_ilce.json');
    final jsonData = json.decode(data) as List<dynamic>;
    final ilData = jsonData.firstWhere((il) => il['il_adi'] == ilAdi, orElse: () => {});
    return (ilData['ilceler'] as List<dynamic>).map<String>((ilce) => ilce['ilce_adi'] as String).toList();
  }
}
