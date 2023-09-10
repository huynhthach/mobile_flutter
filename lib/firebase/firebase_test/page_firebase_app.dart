import 'package:baitap_android/firebase/firebase_test/firebase_data.dart';
import 'package:baitap_android/firebase/firebase_test/page_firebase_detail.dart';
import 'package:baitap_android/widget_connect_firebase/widget_connect_firebase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FirebaseApp extends StatelessWidget {
  const FirebaseApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        errorMessage: "error,do not connect",
        connectingMessage: "kết nối xong!",
        builder: (context) => PageSVs(),
    );
  }
}
class PageSVs extends StatelessWidget {
  const PageSVs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "danh sach Sinh Vien"
        ),
        actions: [
          IconButton(
              onPressed: () =>  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageSVDetail(xem: false,))
              ),
              icon: Icon(Icons.add_circle_outline,color: Colors.white,)
          )
        ],
      ),
      body: StreamBuilder<List<SinhVienSnapshot>>(
        stream: SinhVienSnapshot.getAll(),
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
          else {
            var list = snapshot.data!;
            return ListView.separated(
                separatorBuilder: (context, index) => Divider(thickness: 1.5,),
                itemCount: list.length,
                itemBuilder: (context, index) => Slidable(
                  child: ListTile(
                    leading: Text("${list[index].sinhVien.id}"),
                    title: Text("${list[index].sinhVien.ten}"),
                    subtitle: Text("${list[index].sinhVien.lop}"),
                  ),
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [],
                  ),
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(
                          onPressed: (context) => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PageSVDetail(sinhVienSnapshot: list[index],xem: true,))
                          ),
                        icon: Icons.details,
                        foregroundColor: Colors.blue,
                      ),
                      SlidableAction(
                        onPressed: (context) => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PageSVDetail(sinhVienSnapshot: list[index],xem: false,))
                        ),
                        icon: Icons.edit,
                        foregroundColor: Colors.black,
                      ),
                      SlidableAction(
                        onPressed: (context) => _xoa(list[index]),
                        icon: Icons.delete_forever,
                        foregroundColor: Colors.red,
                      ),
                    ],
                  ),
                ),
            );
          }
        },
      ),
    );
  }
  _xoa(SinhVienSnapshot svs) async{
    FirebaseStorage _storage = FirebaseStorage.instance;
    Reference reference = _storage.ref().child("images").child("anh_${svs!.sinhVien.id}.jpg");
    reference.delete();
    svs!.xoa();
  }
}

