import 'package:baitap_android/firebase/giaicuunongsan/firebase_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageNongSanDetail extends StatefulWidget {
  NongSanSnapshot? nongSanSnapshot;
  PageNongSanDetail({Key? key,required this.nongSanSnapshot}) : super(key: key);

  @override
  State<PageNongSanDetail> createState() => _PageNongSanDetailState();
}

class _PageNongSanDetailState extends State<PageNongSanDetail> {
  NongSanSnapshot? nss;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nông sản"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image.network(nss!.nongSan.Anh!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
