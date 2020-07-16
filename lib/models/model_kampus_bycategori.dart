import 'dart:convert';

List<ModelKampusByIdCat> modelKampusByIdCatFromJson(String str) =>
    new List<ModelKampusByIdCat>.from(
        json.decode(str).map((x) => ModelKampusByIdCat.fromJson(x)));

String modelKampusByIdCatToJson(List<ModelKampusByIdCat> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class ModelKampusByIdCat {
  String id;
  String namaKampus;
  String namaRektor;
  String jmlMahasiswa;
  String lokasi;
  String julukan;
  String situsWeb;
  String namaKategori;
  String foto;
  String deskripsi;
  String foto_kampus;

  ModelKampusByIdCat({
    this.id,
    this.namaKampus,
    this.namaRektor,
    this.jmlMahasiswa,
    this.lokasi,
    this.julukan,
    this.situsWeb,
    this.namaKategori,
    this.foto,
    this.deskripsi,
    this.foto_kampus,
  });

  factory ModelKampusByIdCat.fromJson(Map<String, dynamic> json) =>
      new ModelKampusByIdCat(
        id: json["id"],
        namaKampus: json["nama_kampus"],
        namaRektor: json["nama_rektor"],
        jmlMahasiswa: json["jml_mahasiswa"],
        lokasi: json["lokasi"],
        julukan: json["julukan"],
        situsWeb: json["situs_web"],
        namaKategori: json["nama_kategori"],
        foto: json["foto"],
        deskripsi: json["deskripsi"],
        foto_kampus: json["foto_kampus"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_kampus": namaKampus,
        "nama_rektor": namaRektor,
        "jml_mahasiswa": jmlMahasiswa,
        "lokasi": lokasi,
        "julukan": julukan,
        "situs_web": situsWeb,
        "nama_kategori": namaKategori,
        "foto": foto,
        "deskripsi": deskripsi,
        "foto_kampus": foto_kampus,
      };
}
