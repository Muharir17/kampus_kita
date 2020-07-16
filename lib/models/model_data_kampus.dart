import 'dart:convert';

ModelDataKampus modelDataKampusFromJson(String str) =>
    ModelDataKampus.fromJson(json.decode(str));

String modelDataKampusToJson(ModelDataKampus data) =>
    json.encode(data.toJson());

class ModelDataKampus {
  List<Datum> data;

  ModelDataKampus({
    this.data,
  });

  factory ModelDataKampus.fromJson(Map<String, dynamic> json) =>
      new ModelDataKampus(
          data:
              new List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "data": new List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String namaKampus;
  String namaRektor;
  String jmlStaff;
  String jmlMahasiswa;
  String lokasi;
  String situsWeb;
  String fotoKampus;

  Datum({
    this.namaKampus,
    this.namaRektor,
    this.jmlStaff,
    this.jmlMahasiswa,
    this.lokasi,
    this.situsWeb,
    this.fotoKampus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => new Datum(
        namaKampus: json["nama_kampus"],
        namaRektor: json["nama_rektor"],
        jmlStaff: json["jml_staff"],
        jmlMahasiswa: json["jml_mahasiswa"],
        lokasi: json["lokasi"],
        situsWeb: json["situs_web"],
        fotoKampus: json["foto_kampus"],
      );

  Map<String, dynamic> toJson() => {
        "nama_kampus": namaKampus,
        "nama_rektor": namaRektor,
        "jml_staff": jmlStaff,
        "jml_mahasiswa": jmlMahasiswa,
        "lokasi": lokasi,
        "situs_web": situsWeb,
        "foto_kampus": fotoKampus,
      };
}
