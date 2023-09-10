void main(){
  List<String> s = ["long","ca sau","chuoi","hoa duy"];
  List<int> lens = s.map((e) => e.length).toList();
  print(s);
  print(lens);

  lens.forEach((element) {
    print(element*element);
  });
}