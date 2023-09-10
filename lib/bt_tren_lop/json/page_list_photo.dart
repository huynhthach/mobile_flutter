import 'package:baitap_android/bt_tren_lop/json/json_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageListPhoto extends StatelessWidget {
  const PageListPhoto({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("json test"),
      ),
      body: FutureBuilder<List<Photo>?>(
        future: getHttpContent(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(
              child: Text("error: do not upload the album"),
            );
          }else if(snapshot.hasData == false){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
             List<Photo> list = snapshot.data!;
             return GridView.extent(
               maxCrossAxisExtent: 150,
               mainAxisSpacing: 5,
               crossAxisSpacing: 5,
               childAspectRatio: 0.8,
               children: List.generate(
                   list.length,
                       (index) => Container(
                     child: Column(
                       children: [
                         Image.network(list[index].thumbnailUrl as String),
                       ],
                     )
                   )
               ),
             );
          }
        },
      ),
    );
  }
}
