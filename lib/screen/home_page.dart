import 'package:flutter/material.dart';
import 'package:kampus_kita/models/kategori_kampus.dart';
import 'package:http/http.dart' as http;
import 'package:kampus_kita/utils/constans_util.dart';
import 'dart:convert';
import 'dart:async';
import 'package:kampus_kita/models/model_slider.dart';
import 'package:kampus_kita/models/model_all_kampus.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'detail_kategori.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detail_kampus.dart';

class HomePage extends StatefulWidget {
  final VoidCallback signOut;
  HomePage(this.signOut);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  String username = "", nama = "";

  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      username = sharedPreferences.get("username");
      nama = sharedPreferences.get("nama");
    });
  }

  var loading = false;
  List<KategoriKampus> _list = [];

  Future<Null> _fetchDataKategori() async {
    setState(() {
      loading = true;
    });

    final response = await http
        .get(ConstantsUtil().PUBLIC_API_URL + "get_kategori_kampus.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(KategoriKampus.fromJson(i));
        }
        loading = false;
      });
    }
  }

  List<ModelAllDataKampus> _list_kampus = [];

  Future<Null> _fetchDataAllkampus() async {
    setState(() {
      loading = true;
    });

    final response =
        await http.get(ConstantsUtil().PUBLIC_API_URL + "get_data_kampus.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list_kampus.add(ModelAllDataKampus.fromJson(i));
        }
        loading = false;
      });
    }
  }

  List<ModelSliderKampus> _listSlider = [];

  Future<Null> _fetchDataSlider() async {
    setState(() {
      loading = true;
    });

    final response = await http
        .get(ConstantsUtil().PUBLIC_API_URL + "get_slider_populer.php");
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _listSlider.add(ModelSliderKampus.fromJson(i));
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
    _fetchDataAllkampus();
    _fetchDataSlider();
    getPref();
  }

  Widget image_slider() {
    return Container(
      height: 250.0,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Carousel(
              images: [
                NetworkImage("${ConstantsUtil().PUBLIC_IMAGE_URL}" +
                    _listSlider[2].foto_kampus),
                NetworkImage("${ConstantsUtil().PUBLIC_IMAGE_URL}" +
                    _listSlider[1].foto_kampus),
                NetworkImage("${ConstantsUtil().PUBLIC_IMAGE_URL}" +
                    _listSlider[0].foto_kampus),
              ],
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: new Duration(microseconds: 2000),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.pinkAccent,
        appBar: AppBar(
          title: Text(
            'Hi ' + username,
            style: TextStyle(color: Colors.pinkAccent),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.pinkAccent,
              ),
              onPressed: () {
                signOut();
              },
            ),
            InkWell(
              child: Container(
                margin: EdgeInsets.all(8),
                child: CircleAvatar(
                  backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
                  backgroundColor: Colors.grey[300],
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Kampus Kita \nData Kampus Indonesia",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            image_slider(),

            new Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Text('Kategori Kampus',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white)),
            ),

            Container(
              padding: EdgeInsets.only(top: 10, left: 20),
              height: 250,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                primary: false,
                itemCount: _list.length,
                itemBuilder: (BuildContext context, int index) {
                  final xData = _list[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: InkWell(
                      child: Container(
                        height: 250,
                        width: 140,
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                ConstantsUtil().PUBLIC_IMAGE_URL + xData.foto,
                                height: 178,
                                width: 140,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 7),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                xData.namaKategori,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(height: 3),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return DetailKategoriKampus(
                                idKategori: xData.idKategori,
                                namaKategori: xData.namaKategori,
                                nDeskripsi: xData.deskripsi,
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

            //padding
            new Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Text('Data Kampus',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: Colors.white)),
            ),

            Padding(
              padding: EdgeInsets.all(20),
              child: ListView.builder(
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _list_kampus.length,
                itemBuilder: (BuildContext context, int index) {
                  final listData = _list_kampus[index];
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
                                    listData.fotoKampus,
                                height: 70,
                                width: 70,
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
                                        color: Colors.white,
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
      ),
    );
  }
}
