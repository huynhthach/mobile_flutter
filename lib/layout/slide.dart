import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> slide = [
  "https://tuvanmuaxe.vn/upload/upload_img/images/Maserati-GranTurismo-2018-tuvanmuaxe_vn-1.jpg",
  "https://autoexpress.vn/upload/autoexpress_news/2017/06/tin-tuc/xe-maserati-alfieri-concept.jpg",
  "https://tuvanmuaxe.vn/upload/upload_img/images/Audi-A8-2018-the-he-moi-tuvanmuaxe_vn-7.jpg",
  "https://static.danhgiaxe.com/data/201344/thanhnhan_auto_audi-a4-2014-35_8744.jpg"
];
int image =0;
class PageSlide extends StatefulWidget {
  const PageSlide({Key? key}) : super(key: key);

  @override
  State<PageSlide> createState() => _PageSlideState();
}

class _PageSlideState extends State<PageSlide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("gioi thieu san pham"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider.builder(
                  options:CarouselOptions(
                    autoPlay: true,
                    initialPage: image,
                    viewportFraction:1,
                    enlargeCenterPage: true,
                    enlargeFactor: 2,
                    aspectRatio: 2.0,
                    onPageChanged: (index, reason) {
                      setState(() {
                        image=index;
                      });
                    },
                  ),
                  itemCount: slide.length,
                  itemBuilder: (
                      BuildContext context,
                      int index,
                      int realIndex) =>Container(
                    child: Image.network(slide[index],fit: BoxFit.cover,),
                  )
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: Colors.white,
                    child: Text("${image+1}/${slide.length}"),
                  ),
                ],
              ),
              Text("[CHINH HANG]Sieu xe duoc nhieu dai gia ua chuong cua nam 2023",style: TextStyle(fontSize: 20),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text("800.000",style: TextStyle(fontSize: 15,color: Colors.red),),
                  SizedBox(width: 10),
                  Text("1.000.000",style: TextStyle(decoration: TextDecoration.lineThrough),)
                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Text("4.8",),
                  Icon(Icons.star,color: Colors.amber,size: 30),
                  Icon(Icons.star,color: Colors.amber,size: 30),
                  Icon(Icons.star,color: Colors.amber,size: 30),
                  Icon(Icons.star,color: Colors.amber,size: 30),
                  Icon(Icons.star_half,color: Colors.amber,size: 30),
                  SizedBox(width: 5,),
                  Text("100 danh gia",style: TextStyle(color: Colors.lightBlue,fontSize: 15),)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
