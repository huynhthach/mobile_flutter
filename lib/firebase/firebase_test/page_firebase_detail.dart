import 'package:baitap_android/firebase/firebase_test/firebase_data.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class PageSVDetail extends StatefulWidget {
  SinhVienSnapshot? sinhVienSnapshot;
  bool? xem;
  PageSVDetail({Key? key,this.sinhVienSnapshot,required this.xem}) : super(key: key);

  @override
  _PageSVState createState() => _PageSVState();
}

class _PageSVState extends State<PageSVDetail> {
  SinhVienSnapshot? svs;
  bool? xem;
  bool _imageChange = false;
  XFile? _xImage;
  String buttonLabel = "add";
  String title = "add new college";
  TextEditingController txtId = TextEditingController();
  TextEditingController txtTen = TextEditingController();
  TextEditingController txtLop = TextEditingController();
  TextEditingController txtNamSinh = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: _imageChange ? Image.file(File(_xImage!.path),):
                    svs?.sinhVien.anh !=null ? Image.network(svs!.sinhVien.anh!):null,
              ),
              const SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 20,),
                  ElevatedButton(
                      onPressed: xem !=true ? () => _chonanh(context):null,
                      child: const Icon(Icons.image),
                  )
                ],
              ),
              TextField(
                controller: txtId,
                decoration: InputDecoration(
                  labelText: "Id:",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: txtTen,
                decoration: InputDecoration(
                  labelText: "Name:",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: txtLop,
                decoration: InputDecoration(
                  labelText: "Class:",
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                controller: txtNamSinh,
                decoration: InputDecoration(
                  labelText: "birth day:",
                ),
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () async{
                        if(xem==true)
                          Navigator.pop(context);
                        else{
                          _capnhat(context);
                        }
                      },
                      child: Text(buttonLabel)
                  ),
                  SizedBox(width: 10,),
                  xem==true?
                      SizedBox(width: 1,):
                  ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("close"),
                  ),
                  SizedBox(width: 10,)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    svs = widget.sinhVienSnapshot;
    xem = widget.xem;
    if(svs!=null){
      txtId.text = svs!.sinhVien.id?? "";
      txtTen.text = svs!.sinhVien.ten?? "";
      txtLop.text = svs!.sinhVien.lop?? "";
      txtNamSinh.text = svs!.sinhVien.nam_sinh?? "";
      if(xem! == true){
        title = "profile college";
        buttonLabel = "close";
      }else{
        title = "update profile college";
        buttonLabel = "update";
      }
    }
  }
  _capnhat(BuildContext context) async{
    SinhVien sv = SinhVien(
        id: txtId.text,
        ten: txtTen.text,
        lop: txtLop.text,
        nam_sinh: txtNamSinh.text,
        anh: null,
    );
    if(_imageChange){
      FirebaseStorage _storage = FirebaseStorage.instance;
      Reference reference = _storage.ref().child("images").child("anh_${svs!.sinhVien.id}.jpg");
      UploadTask uploadTask = await _uploadTask(reference, _xImage!);
      uploadTask.whenComplete(() async {
        sv.anh = await reference.getDownloadURL();
        if (svs != null)
          _capnhatsv(svs, sv);
        else
          _themmoi(sv);
        }
      ).onError((error, stackTrace) {
        return Future.error("error");
      });
    }
    else
      if(svs!=null){
        sv.anh = svs!.sinhVien.anh;
        _capnhatsv(svs, sv);
      }else
        _themmoi(sv);
  }
    _chonanh(BuildContext context) async{
    _xImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(_xImage!=null){
      setState(() {
        _imageChange=true;
      });
    }
  }
  Future<UploadTask> _uploadTask(Reference reference,XFile ximage) async{
    final metaData = SettableMetadata(
      contentType: "image/jpeg",
      customMetadata: {'picked-file-path':ximage.path}
    );
    UploadTask uploadTask;
    if(kIsWeb)
      uploadTask = reference.putData(await ximage.readAsBytes(),metaData);
    else
      uploadTask = reference.putFile(File(ximage.path),metaData);
    return Future.value(uploadTask);
  }
  _capnhatsv(SinhVienSnapshot? svs,SinhVien sv){
    svs!.capnhat(sv);
  }
  _themmoi(SinhVien sv){
    SinhVienSnapshot.themMoi(sv);
  }
}


