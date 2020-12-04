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
  final String imgUrl;
  final String address;
  final String name;
  final String region;
  ParseLatlng({this.lat,this.lng,this.id,this.imgUrl,this.name,this.address,this.region});

  factory ParseLatlng.fromJson(Map<String,dynamic> json){
    return ParseLatlng(lat: json['lat'],lng: json['lng'],id: json['id'],imgUrl: json['image'],address: json['address'],name: json['name'],region: json['region']);
  }

}