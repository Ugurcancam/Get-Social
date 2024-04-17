class IlIlceModel {
  String? ilAdi;
  List<Ilceler>? ilceler;

  IlIlceModel({this.ilAdi, this.ilceler});

  IlIlceModel.fromJson(Map<String, dynamic> json) {
    ilAdi = json['il_adi'] as String;
    if (json['ilceler'] != null) {
      ilceler = <Ilceler>[];
      json['ilceler'].forEach((v) {
        ilceler!.add(Ilceler.fromJson(v as Map<String, dynamic>));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['il_adi'] = this.ilAdi;
    if (this.ilceler != null) {
      data['ilceler'] = this.ilceler!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ilceler {
  String? ilceAdi;

  Ilceler({this.ilceAdi});

  Ilceler.fromJson(Map<String, dynamic> json) {
    ilceAdi = json['ilce_adi'] as String;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ilce_adi'] = this.ilceAdi;
    return data;
  }
}
