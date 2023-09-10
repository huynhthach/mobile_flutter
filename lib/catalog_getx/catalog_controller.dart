import 'package:get/get.dart';

import '../catalog_provide/provider_catalog.dart';

class CatalogController extends GetxController{
  final _mathang = <Mathang>[Mathang(tenMH: "xoai", gia: 100000),
    Mathang(tenMH: "coc", gia: 200000),
    Mathang(tenMH: "chuoi", gia: 300000),
    Mathang(tenMH: "sau rieng", gia: 400000),
    Mathang(tenMH: "tao", gia: 50000),
    Mathang(tenMH: "mit", gia: 10000),
    Mathang(tenMH: "chom chom", gia: 1000)].obs;
  final _giohang = <int>[].obs;

  List<Mathang> get mathangs => _mathang.value;
  List<int> get giohangs => _giohang.value;
  int get slmTrongGh => _giohang.value.length;
  int get tongtien => _giohang.value.fold(
      0, (previousValue, element) => previousValue + _mathang[element].gia
  );
  void themmathang(int index){
    _giohang.add(index);
    _giohang.refresh();
    _mathang.refresh();
  }
  void xoamathang(int index){
    _giohang.removeAt(index);
    _giohang.refresh();
    _mathang.refresh();
  }
  bool kiemtramathang(int index){
    for(int i in _giohang)
      if(i==index)
        return true;
      return false;
  }
}