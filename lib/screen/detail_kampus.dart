import 'package:flutter/material.dart';
import 'package:kampus_kita/models/model_detail_kampus.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:kampus_kita/utils/constans_util.dart';

class DetailKampus extends StatefulWidget {
  final String idKampus;
  final String namaKampus;
  DetailKampus({this.idKampus, this.namaKampus});

  @override
  _DetailKampusState createState() => _DetailKampusState();
}

class _DetailKampusState extends State<DetailKampus> {
  var loading = false;
  List<ModelDetailKampus> _list = [];

  Future<Null> _fetchDataKategori() async {
    setState(() {
      loading = true;
    });

    final response = await http.post(
        ConstantsUtil().PUBLIC_API_URL + "detail_kampus_by_id.php",
        body: {
          'id': widget.idKampus,
        });
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(ModelDetailKampus.fromJson(i));
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
        title: Text(widget.namaKampus),
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
                          nListKategori.fotoKampus,
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
              widget.namaKampus,
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
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
                      height: 200,
//                    color: Colors.red,
                      child: Column(
                        children: <Widget>[
                          new Text(
                            "Lokasi : " + listData.lokasi,
                            style: TextStyle(fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left,
                          ),
                          new Text("Nama Rektor : " + listData.namaRektor,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left),
                          new Text("Julukan : " + listData.julukan,
                              style: TextStyle(fontWeight: FontWeight.normal),
                              textAlign: TextAlign.left),
                          new Text("Situs Web : " + listData.situsWeb,
                              style: TextStyle(fontWeight: FontWeight.normal),
                              textAlign: TextAlign.left),
                        ],
                      ),
                    ),
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
