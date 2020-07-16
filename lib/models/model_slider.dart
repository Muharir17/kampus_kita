import 'dart:convert';

List<ModelSliderKampus> modelSliderKampusFromJson(String str) =>
    new List<ModelSliderKampus>.from(
        json.decode(str).map((x) => ModelSliderKampus.fromJson(x)));

String modelModelSliderKampusToJson(List<ModelSliderKampus> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class ModelSliderKampus {
  String id;
  String namaKampus;
  String namaRektor;
  String jmlMahasiswa;
  String lokasi;
  String foto_kampus;

  ModelSliderKampus({
    this.id,
    this.namaKampus,
    this.namaRektor,
    this.jmlMahasiswa,
    this.lokasi,
    this.foto_kampus,
  });

  factory ModelSliderKampus.fromJson(Map<String, dynamic> json) =>
      new ModelSliderKampus(
        id: json["id"],
        namaKampus: json["nama_kampus"],
        namaRektor: json["nama_rektor"],
        jmlMahasiswa: json["jml_mahasiswa"],
        lokasi: json["lokasi"],
        foto_kampus: json["foto_kampus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_kampus": namaKampus,
        "nama_rektor": namaRektor,
        "jml_mahasiswa": jmlMahasiswa,
        "lokasi": lokasi,
        "foto_kampus": foto_kampus,
      };
}
