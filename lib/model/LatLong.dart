class LatLong{
  List<ParseLatlng> list;
  LatLong({this.list});

  factory LatLong.fromJson(Map<String,dynamic> latLong){
    return LatLong(list: latlngList(latLong));
  }

  static List<ParseLatlng> latlngList(parseLatLng){
    var list = parseLatLng['offices'] as List;
    List<ParseLatlng> latlongList = list.map((e) => ParseLatlng.fromJson(e)).toList();
    return latlongList;
  }
}

class ParseLatlng{
  final double lat;
  final double lng;
  final String id;
  ParseLatlng({this.lat,this.lng,this.id});

  factory ParseLatlng.fromJson(Map<String,dynamic> json){
    return ParseLatlng(lat: json['lat'],lng: json['lng'],id: json['id']);
  }

}