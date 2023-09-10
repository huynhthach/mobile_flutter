import 'package:cloud_firestore/cloud_firestore.dart';

class MyFirebaseCollection {

  //tạo folder lưu flashcard
  static Future<void> createFolder(String folderName) async {
    try {
      CollectionReference foldersRef =
      FirebaseFirestore.instance.collection('Tieng Anh');
      DocumentReference docRef = foldersRef.doc(folderName);
      await docRef.set({
        'flashcards': [],
      });
      print('Thư mục đã được tạo thành công');
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  //thêm flashcard vào folder
  static Future<void> addFlashcardToFolder(
      String folderId, String front, String back) async {
    try {
      CollectionReference foldersRef =
      FirebaseFirestore.instance.collection('Tieng Anh');
      DocumentReference folderDocRef = foldersRef.doc(folderId);

      await folderDocRef.update({
        'flashcards': FieldValue.arrayUnion([
          {
            'front': front,
            'back': back,
          }
        ])
      });

      print('Flashcard đã được gắn vào thư mục thành công');
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  //lấy toàn bộ dữ liệu từ folder
  static Stream<List<String>> getCollectionNames() {
    // Lấy reference của collection trong Firestore
    final collectionRef = FirebaseFirestore.instance.collection("Tieng Anh");
    // Trả về stream của collection snapshot
    return collectionRef.snapshots().map((snapshot) {
      // Trích xuất danh sách tên các collection
      final childCollections = snapshot.docs.map((doc) => doc.id).toList();
      return childCollections;
    });
  }
  static Stream<List<Map<String, dynamic>>> getFlashCardsStream(String folderId) {
    return FirebaseFirestore.instance
        .collection('Tieng Anh')
        .doc(folderId)
        .snapshots()
        .map((snapshot) {
      final flashcards = snapshot.data()!['flashcards'];
      return List<Map<String, dynamic>>.from(flashcards);
    });
  }

  //lấy toàn bộ dữ liệu từ folder yêu thích
  static Stream<List<Map<String, dynamic>>> getFavoriteFlashcardsStream() {
    return FirebaseFirestore.instance
        .collection('favorite')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((document) {
        final flashcards =
        List<Map<String, dynamic>>.from(document.data()['flashcard']);
        return {'flashcards': flashcards};
      }).toList();
    });
  }

  //chỉnh sửa flashcard
  static Future<void> updateFlashcard(String folderId, int index, String newFront, String newBack) async {
    try {
      // Lấy tham chiếu đến document cần cập nhật
      final documentRef = FirebaseFirestore.instance.collection('Tieng Anh').doc(folderId);

      // Lấy dữ liệu hiện tại của document
      final documentSnapshot = await documentRef.get();
      final data = documentSnapshot.data();

      // Lấy danh sách flashcard
      final flashcards = List<Map<String, dynamic>>.from(data!['flashcards']);

      // Kiểm tra xem chỉ số index có hợp lệ không
      if (index >= 0 && index < flashcards.length) {
        // Cập nhật trường "front" và "back" trong flashcard tại chỉ số index
        flashcards[index]['front'] = newFront;
        flashcards[index]['back'] = newBack;
        // Cập nhật dữ liệu trong Firestore
        await documentRef.update({'flashcards': flashcards});
      }
    } catch (e) {
      print('Lỗi khi cập nhật flashcard: $e');
    }
  }

  //xoá flashcard
  static Future<void> deleteFlashcard(String folderId, int index) async {
    try {
      // Lấy tham chiếu đến document cần cập nhật
      final documentRef = FirebaseFirestore.instance.collection('Tieng Anh').doc(folderId);

      // Lấy dữ liệu hiện tại của document
      final documentSnapshot = await documentRef.get();
      final data = documentSnapshot.data();

      // Lấy danh sách flashcard
      final flashcards = List<Map<String, dynamic>>.from(data!['flashcards']);

      // Kiểm tra xem chỉ số index có hợp lệ không
      if (index >= 0 && index < flashcards.length) {
        // Xoá phần tử tại chỉ số index trong trường "flashcards"
        flashcards.removeAt(index);

        // Cập nhật dữ liệu trong Firestore
        await documentRef.update({'flashcards': flashcards});
      }
    } catch (e) {
      print('Lỗi khi xoá flashcard: $e');
    }
  }

  //thêm flashcard vào mục yêu thích
  static Future<void> addToFavorites(String documentName,int index) async {
    // Lấy dữ liệu từ collection "alo"
    final documentRef = FirebaseFirestore.instance.collection('Tieng Anh').doc(documentName);

    // Lấy dữ liệu hiện tại của document
    final documentSnapshot = await documentRef.get();
    final data = documentSnapshot.data();

      // Lấy trường "flashcard" từ document
      final flashcards = List<Map<String, dynamic>>.from(data!['flashcards']);

      // Lấy các trường "front" và "back" từ mỗi flashcard
      final List<Map<String, dynamic>> favoriteFlashcards = [];
      if (index >= 0 && index < flashcards.length) {
        final String front =  flashcards[index]['front'] ;
        final String back = flashcards[index]['back'] ;

        final Map<String, dynamic> favoriteFlashcard = {
          'front': front,
          'back': back,
        };
        favoriteFlashcards.add(favoriteFlashcard);
      }
      // Tạo một document mới trong collection "favorite" với tên là documentName
      final DocumentReference favoriteRef = FirebaseFirestore.instance
          .collection('favorite').doc("$documentName + $index");
      // Thêm dữ liệu vào document mới
      await favoriteRef.set({'flashcard': favoriteFlashcards});
  }

  //kiểm tra xem favorite được thêm có bị trùng hay không
  static Future<bool> isDocumentNameDuplicated(String documentName,int index) async {
    final CollectionReference aloCollection =
    FirebaseFirestore.instance.collection('Tieng Anh');

    final QuerySnapshot snapshot =
    await aloCollection.where(FieldPath.documentId, isEqualTo: "$documentName + $index").get();

    return snapshot.docs.isNotEmpty;
  }

  //xoá document theo index ở page favorite
  static Future<void> deleteDocumentByIndex(int index) async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('favorite');

    QuerySnapshot snapshot = await collectionRef.get();
    if (index >= 0 && index < snapshot.size) {
      DocumentSnapshot docToDelete = snapshot.docs[index];
      await docToDelete.reference.delete();
      print('Document deleted successfully.');
    } else {
      print("Invalid index");
    }
  }

  //xoá document theo index ở page main
  static Future<void> deleteDocumentByIndexMain(int index) async {
    CollectionReference collectionRef = FirebaseFirestore.instance.collection('Tieng Anh');

    QuerySnapshot snapshot = await collectionRef.get();
    if (index >= 0 && index < snapshot.size) {
      DocumentSnapshot docToDelete = snapshot.docs[index];
      await docToDelete.reference.delete();
      print('Document deleted successfully.');
    } else {
      print("Invalid index");
    }
  }

  //tìm kiếm
  static Stream<List<dynamic>> search(String searchQuery) {
    final CollectionReference _flashcardCollection = FirebaseFirestore.instance.collection('Tieng Anh');
    return _flashcardCollection.snapshots().map((QuerySnapshot snapshot) {
      List<dynamic> allFlashcards = [];
      for (var doc in snapshot.docs) {
        List<dynamic> flashcards = doc['flashcards'];
        allFlashcards.addAll(flashcards);
      }
      return allFlashcards.where((flashcard) =>
      flashcard['front'].toLowerCase().contains(searchQuery.toLowerCase().trim()) ||
          flashcard['back'].toLowerCase().contains(searchQuery.toLowerCase().trim())).toList();
    });
  }

}