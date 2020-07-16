import 'dart:convert';

List<ModelAllDataKampus> modelAllDataKampusFromJson(String str) =>
    new List<ModelAllDataKampus>.from(
        json.decode(str).map((x) => ModelAllDataKampus.fromJson(x)));

String modelAllDataKampusToJson(List<ModelAllDataKampus> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class ModelAllDataKampus {
  String id;
  String namaKampus;
  String namaRektor;
  String jmlMahasiswa;
  String lokasi;
  String fotoKampus;

  ModelAllDataKampus({
    this.id,
    this.namaKampus,
    this.namaRektor,
    this.jmlMahasiswa,
    this.lokasi,
    this.fotoKampus,
  });

  factory ModelAllDataKampus.fromJson(Map<String, dynamic> json) =>
      new ModelAllDataKampus(
        id: json["id"],
        namaKampus: json["nama_kampus"],
        namaRektor: json["nama_rektor"],
        jmlMahasiswa: json["jml_mahasiswa"],
        lokasi: json["lokasi"],
        fotoKampus: json["foto_kampus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_kampus": namaKampus,
        "nama_rektor": namaRektor,
        "jml_mahasiswa": jmlMahasiswa,
        "lokasi": lokasi,
        "foto_kampus": fotoKampus,
      };
}
