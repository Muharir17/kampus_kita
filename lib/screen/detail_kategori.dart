import 'package:flutter/material.dart';
import 'package:kampus_kita/models/model_kampus_bycategori.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:kampus_kita/utils/constans_util.dart';
import 'detail_kampus.dart';

class DetailKategoriKampus extends StatefulWidget {
  final String idKategori;
  final String namaKategori;
  final String nDeskripsi;
  DetailKategoriKampus({this.idKategori, this.namaKategori, this.nDeskripsi});

  @override
  _DetailKategoriKampusState createState() => _DetailKategoriKampusState();
}

class _DetailKategoriKampusState extends State<DetailKategoriKampus> {
  var loading = false;
  List<ModelKampusByIdCat> _list = [];

  Future<Null> _fetchDataKategori() async {
    setState(() {
      loading = true;
    });

    final response = await http.post(
        ConstantsUtil().PUBLIC_API_URL + "kampus_by_id_kategori.php",
        body: {
          'id': widget.idKategori,
        });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(ModelKampusByIdCat.fromJson(i));
        }
        loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchDataKategori();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text(widget.namaKategori),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.only(left: 10),
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              primary: false,
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {
                final nListKategori = _list[index];

                return Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      ConstantsUtil().PUBLIC_IMAGE_URL +
                          nListKategori.foto_kampus,
                      height: 250,
                      width: MediaQuery.of(context).size.width - 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              widget.nDeskripsi,
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ),

          SizedBox(height: 5),
          //padding
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Text(
                'List Kampus Berdasarkan Kategori ' + widget.namaKategori,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.pinkAccent)),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {
                final listData = _list[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: InkWell(
                    child: Container(
                      height: 70,
//                    color: Colors.red,
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              ConstantsUtil().PUBLIC_IMAGE_URL +
                                  listData.foto_kampus,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width - 130,
                            child: ListView(
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    listData.namaKampus,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(height: 3),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    listData.lokasi,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 10,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return DetailKampus(
                              namaKampus: listData.namaKampus,
                              idKampus: listData.id,
                            );
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
