class SinhVien{
  String id,ten;
  String? ngaysinh,quequan;

  SinhVien({
    required this.id,
    required this.ten,
    this.ngaysinh,
    this.quequan,
  });

  @override
  String toString() {
    return "id:$id\nhoten:$ten\nngaysinh:$ngaysinh\nquequan:$quequan";
  }
}
class QL_SinhVien{

  List<SinhVien> _ds = [];
  List<SinhVien> get ds => _ds;

  void add(SinhVien sv){
    for(SinhVien s in ds){
      if(s.id == sv.id)
        return;
    }
    ds.add(sv);
  }
  void inds(){
    ds.forEach((element) {
      print(element.toString());
    });
  }
}
void main(){
  QL_SinhVien ql_sinhVien = QL_SinhVien();
  ql_sinhVien.add(SinhVien(id: "01", ten: "long",ngaysinh: "8/3/2002",quequan: "nha trang"));
  ql_sinhVien.add(SinhVien(id: "02", ten: "linh",ngaysinh: "8/3/2002",quequan: "nha trang"));
  ql_sinhVien.add(SinhVien(id: "03", ten: "loan",ngaysinh: "8/3/2002",quequan: "nha trang"));
  ql_sinhVien.add(SinhVien(id: "04", ten: "loc",ngaysinh: "8/3/2002",quequan: "nha trang"));
  ql_sinhVien.add(SinhVien(id: "05", ten: "lam",ngaysinh: "8/3/2002",quequan: "nha trang"));
  ql_sinhVien.inds();
}