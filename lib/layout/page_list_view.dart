import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

List<String> fruit =["cam","chuoi","dua hau",
  "xoai","sau rieng","buoi","vu sua","dua leo","dua"];
class PageListViewN5 extends StatelessWidget {
  const PageListViewN5({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("chon trai cay de chem"),
      ),
        body: ListView.separated(
          itemBuilder: (context, index) => ListTile(
            leading: Text("${index+1}"),
            title: Text(fruit[index]),
            trailing: Text("${Random().nextInt(100)} kg"),
            subtitle: Text("price :${Random().nextInt(100)*1000}"),
          ), 
          separatorBuilder: (context, index) => Divider(thickness: 2), 
          itemCount: fruit.length,
        ),
    );
  }
}
