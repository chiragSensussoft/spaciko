class Person{
  final String id;
  final String name;
  final int age;
  final List<String> place;
  final List<Images> images;

  Person({this.name,this.age,this.id,this.place,this.images});

  factory Person.fromJson(Map<String,dynamic> map){
    return Person(
        name : map['name'],
        age : map['age'],
        id : map['id'],
        place : parsePlace(map['place']),
        images: parseImages(map)
    );
  }

  static List<String> parsePlace(parseJson){
    List<String> placeList = new List<String>.from(parseJson);
    return placeList;
  }

  static List<Images> parseImages(imageJson){
    var list = imageJson['image'] as List;
    List<Images> imageList = list.map((e) => Images.fromJson(e)).toList();
    return imageList;
  }
}

class Images{
  int id;
  String name;
  Images({this.id,this.name});

  factory Images.fromJson(Map<String,dynamic> map){
    return Images(
        id: map['id'],
        name: map['name']);
  }

}