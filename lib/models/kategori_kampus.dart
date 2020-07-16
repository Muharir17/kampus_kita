import 'dart:convert';

List<KategoriKampus> kategoriKampusFromJson(String str) =>
    new List<KategoriKampus>.from(
        json.decode(str).map((x) => KategoriKampus.fromJson(x)));

String kategoriKampusToJson(List<KategoriKampus> data) =>
    json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class KategoriKampus {
  String idKategori;
  String namaKategori;
  String foto;
  String deskripsi;

  KategoriKampus({
    this.idKategori,
    this.namaKategori,
    this.foto,
    this.deskripsi,
  });

  factory KategoriKampus.fromJson(Map<String, dynamic> json) => KategoriKampus(
        idKategori: json["id_kategori"],
        namaKategori: json["nama"],
        foto: json["foto"],
        deskripsi: json["deskripsi"],
      );

  Map<String, dynamic> toJson() => {
        "id_kategori": idKategori,
        "nama": namaKategori,
        "foto": foto,
        "deskripsi": deskripsi,
      };
}
