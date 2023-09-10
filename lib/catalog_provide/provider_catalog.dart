import 'package:flutter/foundation.dart';

class Mathang{
  String tenMH;
  int gia;
  Mathang({
    required this.tenMH,
    required this.gia,
  });
}
class Catalog extends ChangeNotifier{
  List<Mathang> _mathang = [
  Mathang(tenMH: "xoai", gia: 100000),
  Mathang(tenMH: "coc", gia: 200000),
  Mathang(tenMH: "chuoi", gia: 300000),
  Mathang(tenMH: "sau rieng", gia: 400000),
  Mathang(tenMH: "tao", gia: 50000),
  Mathang(tenMH: "mit", gia: 10000),
  Mathang(tenMH: "chom chom", gia: 1000),
];
  List<int> _giohang=[];
  List<Mathang> _ctgiohang=[];

  List<Mathang> get mathang => _mathang;
  List<int> get giohang => _giohang;
  List<Mathang> get ctgiohang => _ctgiohang;
  int get slMHTrongGH =>_giohang.length;
  int get tienmuahang => _giohang.fold(0,
          (previousValue, element) => previousValue + _mathang[element].gia);
  void themmathang(int index){
    _giohang.add(index);
    notifyListeners();
  }
  void themmathang2(Mathang mh){
    ctgiohang.add(mh);
    notifyListeners();
  }
  void xoamathang(int index){
    _giohang.removeAt(index);
    notifyListeners();
  }
  bool kiemtramathang(int index){
    for(int i in _giohang)
      if(i==index)
        return true;
    return false;
  }
}