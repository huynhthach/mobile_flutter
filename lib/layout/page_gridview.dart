import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> nhanvat = [
  "https://tuvanmuaxe.vn/upload/upload_img/images/Maserati-GranTurismo-2018-tuvanmuaxe_vn-1.jpg",
  "https://autoexpress.vn/upload/autoexpress_news/2017/06/tin-tuc/xe-maserati-alfieri-concept.jpg",
  "https://tuvanmuaxe.vn/upload/upload_img/images/Audi-A8-2018-the-he-moi-tuvanmuaxe_vn-7.jpg",
  "https://static.danhgiaxe.com/data/201344/thanhnhan_auto_audi-a4-2014-35_8744.jpg",
  "http://genk.mediacdn.vn/2016/ff15-audi-r8-1-1478922546451.jpg",
  "https://danviet.mediacdn.vn/upload/4-2015/images/2015-12-14/1450104874-1.jpg"
];
class PageGridViewXe extends StatelessWidget {
  const PageGridViewXe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sieu xe 2023"),
      ),
      body: GridView.extent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        children: List.generate(
            nhanvat.length,
                (index) => Container(
                  child: Image.network(nhanvat[index],fit: BoxFit.cover),
                )
        ).toList(),
      ),
    );
  }
}

