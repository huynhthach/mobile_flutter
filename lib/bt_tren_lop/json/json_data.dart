import 'dart:convert';
import 'package:http/http.dart' as http;
/*
"albumId": 1,
    "id": 1,
    "title": "accusamus beatae ad facilis cum similique qui sunt",
    "url": "https://via.placeholder.com/600/92c952",
    "thumbnailUrl": "https://via.placeholder.com/150/92c952"
 */
class Photo{
  String? title,url,thumbnailUrl;
  int? albumId,id;

  Photo({
    required this.title,
    this.url,
    this.thumbnailUrl,
    this.albumId,
    this.id,
  });
  Map<String,dynamic> toJson(){
    return{
      "albumId": this.albumId,
      "id": this.id,
      "title": this.title,
      "url": this.url,
      "thumbnailUrl": this.thumbnailUrl
    };
  }
  factory Photo.fromJson(Map<String,dynamic> json){
    return Photo(
      albumId: json['albumId'] as int,
      id: json["id"] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}
Future<List<Photo>?> getHttpContent() async{
  List<Photo>? listPhoto;
  String url="https://jsonplaceholder.typicode.com/photos";
  Uri uri = Uri.parse(url);
  http.Response response = await http.get(uri);
  if(response.statusCode==200){
    List<dynamic> list = jsonDecode(response.body) as List;
    listPhoto = list.map((e) => Photo.fromJson(e)).toList();
    return listPhoto;
  }else {
    print("khong the truy cap");
    return Future.error("loi");
  }

}