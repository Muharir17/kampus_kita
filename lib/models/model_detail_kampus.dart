import 'dart:convert';

List<ModelDetailKampus> modelDetailKampusFromJson(String str) =>
    new List<ModelDetailKampus>.from(
        json.decode(str).map((x) => ModelDetailKampus.fromJson(x)));

String modelDetailKampusToJson(List<ModelDetailKampus> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class ModelDetailKampus {
  String id;
  String namaKampus;
  String namaRektor;
  String jmlMahasiswa;
  String lokasi;
  String julukan;
  String situsWeb;
  String nama;
  String fotoKampus;
  String foto;
  String deskripsi;

  ModelDetailKampus({
    this.id,
    this.namaKampus,
    this.namaRektor,
    this.jmlMahasiswa,
    this.lokasi,
    this.julukan,
    this.situsWeb,
    this.nama,
    this.fotoKampus,
    this.foto,
    this.deskripsi,
  });

  factory ModelDetailKampus.fromJson(Map<String, dynamic> json) =>
      new ModelDetailKampus(
        id: json["id"],
        namaKampus: json["nama_kampus"],
        namaRektor: json["nama_rektor"],
        jmlMahasiswa: json["jml_mahasiswa"],
        lokasi: json["lokasi"],
        julukan: json["julukan"],
        situsWeb: json["situs_web"],
        nama: json["nama"],
        fotoKampus: json["foto_kampus"],
        foto: json["foto"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_kampus": namaKampus,
        "nama_rektor": namaRektor,
        "jml_mahasiswa": jmlMahasiswa,
        "lokasi": lokasi,
        "julukan": julukan,
        "situs_web": situsWeb,
        "nama": nama,
        "foto_kampus": fotoKampus,
        "foto": foto,
        "deskripsi": deskripsi,
      };
}
