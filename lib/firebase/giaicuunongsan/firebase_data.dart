import 'package:cloud_firestore/cloud_firestore.dart';

class NongSan{
  String? Anh,TenMH;
  int? Gia;

  NongSan({
    required this.Anh,
    required this.Gia,
    required this.TenMH,
});

  Map<String, dynamic> toJson() {
    return {
      'Anh': this.Anh,
      'TenMH': this.TenMH,
      'Gia': this.Gia,
    };
  }

  factory NongSan.fromJson(Map<String, dynamic> json) {
    return NongSan(
      Anh: json['Anh'] as String,
      TenMH: json['TenMH'] as String,
      Gia: json['Gia'] as int,
    );
  }
}
class NongSanSnapshot{
  NongSan nongSan;
  DocumentReference? documentReference;
  NongSanSnapshot({
    required this.nongSan,
    required this.documentReference,
  });
  factory NongSanSnapshot.fromSnapShot(DocumentSnapshot docSnapNS){
    return NongSanSnapshot(
        nongSan: NongSan.fromJson(docSnapNS.data() as Map<String,dynamic>),
        documentReference: docSnapNS.reference
    );
  }
  static Stream<List<NongSanSnapshot>> getAll(){
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance
        .collection("Fruit").snapshots();
    return streamQS.map((qs) => qs.docs.map((doc) => NongSanSnapshot.fromSnapShot(doc)).toList());
  }
}
