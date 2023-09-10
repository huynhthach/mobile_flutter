import 'package:cloud_firestore/cloud_firestore.dart';
class SinhVien{
  String? id,lop,nam_sinh,ten,anh;
  SinhVien({
    required this.id,
    required this.ten,
    this.lop,
    this.anh,
    this.nam_sinh
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'lop': this.lop,
      'nam_sinh': this.nam_sinh,
      'ten': this.ten,
      'anh': this.anh,
    };
  }

  factory SinhVien.fromJson(Map<String, dynamic> json) {
    return SinhVien(
      id: json['id'],
      lop: json['lop'],
      nam_sinh: json['nam_sinh'],
      ten: json['ten'],
      anh: json['anh'],
    );
  }
}
class SinhVienSnapshot{
  SinhVien sinhVien;
  DocumentReference? documentReference; //tham chieu den du lieu trong firebase
  SinhVienSnapshot({
  required this.sinhVien,
  required this.documentReference,
  });

  factory SinhVienSnapshot.fromSnapShot(DocumentSnapshot docSnapSV){
    return SinhVienSnapshot(
        sinhVien: SinhVien.fromJson(docSnapSV.data() as Map<String,dynamic>),
        documentReference: docSnapSV.reference
    );
  }
  Future<void> capnhat(SinhVien v) async{
    return documentReference!.update(v.toJson());
  }
  Future<void> xoa() async{
    return documentReference!.delete();
  }
  static Future<DocumentReference> themMoi(SinhVien v) async{
    return FirebaseFirestore.instance.collection("SinhVien").add(v.toJson());
  }
  static Stream<List<SinhVienSnapshot>> dssvTuFirebase(){
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance
        .collection("SinhVien").snapshots();
    //chuyen stream<sq> => stream<List<qs>>
    Stream<List<DocumentSnapshot>> StreamSnapShot = streamQS.map((querysn) => querysn.docs);
    return  StreamSnapShot.map(
            (listDocSnap) =>
              listDocSnap.map((docSnap) => SinhVienSnapshot.fromSnapShot(docSnap)).toList()
    );
  }
  static Stream<List<SinhVienSnapshot>> getAll(){
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance
        .collection("SinhVien").snapshots();
    return streamQS.map((qs) =>
        qs.docs.map((doc) => SinhVienSnapshot.fromSnapShot(doc)).toList());
  }
  static Future<List<SinhVienSnapshot>> dssvtufileOnetime() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("SinhVien").get();
    return qs.docs.map((doc) => SinhVienSnapshot.fromSnapShot(doc)).toList();
  }
}