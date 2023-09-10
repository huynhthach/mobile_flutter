import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageIntroduce extends StatelessWidget {
  const PageIntroduce({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nhóm 5"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Chủ đề:App note từ vựng tiếng anh"),
              Text("Thành Viên Nhóm :"),
              SizedBox(height: 10,),
              Text("Huỳnh Thạch Long"),
              Text("Lớp:62.CNTT-2 - MSSV:62131028"),
              SizedBox(height: 5),
              Text("Nguyễn Hữu Thành"),
              Text("Lớp:62.CNTT-2 - MSSV:62133253 "),
              SizedBox(height: 5),
              Text("Nguyễn Tấn Lộc"),
              Text("Lớp:62.CNTT-2 - MSSV:62131014"),
              SizedBox(height: 5),
              Text("Lê Hoàng Việt"),
              Text("Lớp:62.CNTT-2 - MSSV:62133393"),
            ],
          ),
        ),
      ),
    );
  }
}
