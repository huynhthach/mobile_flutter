import 'package:baitap_android/firebase/giaicuunongsan/firebase_data.dart';
import 'package:baitap_android/widget_connect_firebase/widget_connect_firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageNongSan extends StatelessWidget {
  const PageNongSan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
      errorMessage: "error,do not connect",
      connectingMessage: "kết nối xong!",
      builder: (context) => PageHomeNongSan(),
    );
  }
}
class PageHomeNongSan extends StatelessWidget {
  const PageHomeNongSan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giải cứu nông sản"),
      ),
      body:StreamBuilder<List<NongSanSnapshot>>(
        stream: NongSanSnapshot.getAll(),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text("display error",style: TextStyle(color: Colors.red),),
            );
          }
          else if(!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          else{
            var list = snapshot.data;
            return GridView.extent(
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 5, right:5),
              maxCrossAxisExtent: 250,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,
              children: List.generate(
                  list!.length,
                      (index) => Container(
                        child: Column(
                          children: [
                            Image.network(list[index].nongSan.Anh as String,fit: BoxFit.cover,height: 150,width: 200,),
                            Text("${list[index].nongSan.TenMH}"),
                            Text("${list[index].nongSan.Gia}")
                          ],
                        ),
                      )

              ),
            );
          }
        },
      )
    );
  }
}

