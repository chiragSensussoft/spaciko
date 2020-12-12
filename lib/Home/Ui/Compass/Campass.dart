import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:spaciko/model/CheckItem.dart';
import 'package:spaciko/model/LatLong.dart';
import 'package:spaciko/widgets/Pelette.dart';
import 'package:spaciko/widgets/Toast.dart';
import 'dart:ui' as ui;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CompassScreen(),
    );
  }
}

class CompassScreen extends StatefulWidget {
  @override
  _CompassScreenState createState() => _CompassScreenState();
}

var toast = Toast();
class _CompassScreenState extends State<CompassScreen> {
  bool visible = false;
  bool courseul = false;
  int _index = 0;
  int _selectedIndex = 0;
  List<String> blankBtnFilterList = [];
  List<String> buttonFilter = ['Hourly','Daily','Monthly','Property Type'];
  checkItem items;

  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor greenMarker;
  BitmapDescriptor markerIcon;
  Completer<GoogleMapController> _controller = Completer();
  Position _currentPosition;
  List<String> buttonFilter1 = ['Hourly','Daily','Monthly','Property Type'];
  LatLng _lng;
  Map<String,Marker> markers ={};
  List markerIds =List();

  List<ParseLatlng> loadPerson(){
    String jsonString = '{"offices": [{"address": "Aabogade 158200 AarhusDenmark", "id": "aarhus", "image": "https://lh3.googleusercontent.com/tpBMFN5os8K-qXIHiAX5SZEmN5fCzIGrj9FdJtbZPUkC91ookSoY520NYn7fK5yqmh1L1m3F2SJA58v6Qps3JusdrxoFSwk6Ajv2K88", "lat": 56.172249, "lng": 10.187372, "name": "Aarhus", "phone": "", "region": "europe"}, {"address": "Claude Debussylaan 341082 MD, AmsterdamNetherlands", "id": "amsterdam", "image": "https://lh3.googleusercontent.com/gG1zKXcSmRyYWHwUn2Z0MITpdqwb52RAEp3uthG2J5Xl-4_Wz7_WmoM6T_TBg6Ut3L1eF-8XENO10sxVIFdQHilj8iRG29wROpSoug", "lat": 52.337801, "lng": 4.872066, "name": "Amsterdam", "phone": "", "region": "europe"}, {"address": "2300 Traverwood Dr.Ann Arbor, MI 48105United States", "id": "ann-arbor", "image": "https://lh3.googleusercontent.com/Iim0OVcAgg9vmXc5ADn9KvOQFplrMZ8hBTg2biiTtuWPy_r56cy4Byx1ROk6coGt7knQdmx_jO45VX1kiCJZ0QzEtS97AP_BYG4F2w", "lat": 42.3063848, "lng": -83.7140833, "name": "Ann Arbor", "phone": "+1 734-332-6500", "region": "north-america"}, {"address": "Fragkokklisias 7Athens 151 25Greece", "id": "athens", "image": "https://lh3.googleusercontent.com/XroZnqewSrO6KuvXM5hDHtjUJzUcRQLZYfCKs4jP44dKezRvNx58uxaqUKS4fQ2eXzG2TpJNJ1X2xtfBe7Prl5hSG_xjPEF1xLtFodM", "lat": 38.03902, "lng": 23.804595, "name": "Athens", "phone": "", "region": "europe"}, {"address": "10 10th Street NEAtlanta, GA 30309United States", "id": "atlanta", "image": "https://lh3.googleusercontent.com/py7Qvqqoec1MB0dMKnGWn7ju9wET_dIneTb24U-ri8XAsECJnOaBoNmvfa51PIaC0rlsyQvQXvAK8RdLqpkhpkRSzmhNKqb-tY2_", "lat": 33.781827, "lng": -84.387301, "name": "Atlanta", "phone": "+1 404-487-9000", "region": "north-america"}, {"address": "500 W 2nd StSuite 2900Austin, TX 78701United States", "id": "austin", "image": "https://lh3.googleusercontent.com/WFaJgWPdd7xPL7CQHizlqEzLDjT_GUAiWHIWUM0PiVSsv8q3Rjt9QgbyQazuQwYfN5qLORajv8eKSHlKwZo-M89T2Y12zFSxSIme08c", "lat": 30.266035, "lng": -97.749237, "name": "Austin", "phone": "+1 512-343-5283", "region": "north-america"}, {"address": "No. 3, RMZ Infinity \u2013 Tower EOld Madras Road4th and 5th FloorsBangalore, 560 016, India", "id": "bangalore", "image": "https://lh3.googleusercontent.com/YDyQevoY-D0eZQ9sYHp8dQjpFF5JpLfLK-0OM-uJK1oNK3_LRnGJAM0uXi9qb9UigKnVIIXlIgidxhRlnaB_FPtUOqPzrsCSiFZyoQ", "lat": 12.99332, "lng": 77.660176, "name": "Bangalore", "phone": "+91-80-67218000", "region": "asia-pacific"}, {"address": "57 Park Ventures Ecoplex14th Floor, Wireless RoadBangkok, 10330, Thailand", "id": "bangkok", "image": "https://lh3.googleusercontent.com/nh9uOUPj6iWjKZSHIrnkfGhIWGBb8thguRM5_ehCOkyF-qfwzYciDJFVRSvQ6QxlSA6eZUMkzgdW9zR0Gab2ZZPg8NlB7V_V3wB5", "lat": 13.742866, "lng": 100.547983, "name": "Bangkok", "phone": "", "region": "asia-pacific"}, {"address": "6th Floor, Tower B, Raycom InfoTech ParkNo. 2 Kexueyuan South RoadZhongguancun Beijing 100190", "id": "beijing", "image": "https://lh3.googleusercontent.com/v_tD3VvC8-dnhqSF9xhj5Hx7F_bb3-wieM19i-Ho2C3by6mt7-JpPc7KsYVHUZFqQl5ON3adVEV1N4OlzSvHLrr3sr4GtXErDbGC", "lat": 39.9848878, "lng": 116.3265708, "name": "Beijing", "phone": "+86-10-62503000", "region": "asia-pacific"}, {"address": "Boulevard Corporate TowerAv. dos Andradas, 3000 - Andares 14-17Santa Efig\u00eaniaBelo Horizonte30260-070, Brazil", "id": "belo-horizonte", "image": "https://lh3.googleusercontent.com/f7F8gTi9GSgAZR3lv24I1yb-D0wRlDy0lQTcxCB4yJGtSgxrWdKoB3dX3J8SMrjYLwOSXquO3LuGFUE82QUjzVK9buHGNIRUPGpqM3E", "lat": -19.920225, "lng": -43.920845, "name": "Belo Horizonte", "phone": "+55-31-2128-6800", "region": "latin-america"}, {"address": "Tucholskystra\u00dfe 210117 BerlinGermany", "id": "berlin", "image": "https://lh3.googleusercontent.com/XcPyEMiSlLdZJq7nh3orGy3UqjtUHdhxXiwn52ZY47wfEChfZNDO78zDy9H0tBeegogZBZpIE0Q9mdVBGN4aQ0M5vfgz8ZWMEe43Mg", "lat": 52.5231079, "lng": 13.39203120000002, "name": "Berlin", "phone": "+49 30 303986300", "region": "europe"}, {"address": "Carrera 11A 94 - 45Centro Empresarial Oxo CentreBogota, Colombia", "id": "bogota", "image": "https://lh3.googleusercontent.com/_APoV1zAR0g5_pXVDlT2ovgNQfr3zvjOuj4HFHViiy2ahyjapJMXlYRE48qYMyFTWXJybbK4psz-fQ82QhMhO0keYJ27I8tNTHe_ww", "lat": 4.678267, "lng": -74.046901, "name": "Bogota", "phone": "+57 (1) 5939400", "region": "latin-america"}, {"address": "2600 Pearl StreetBoulder, CO 80302United States", "id": "boulder", "image": "https://lh3.googleusercontent.com/lF9KBhOolmb958FFmMdLwFcedQAn1wEsVleBRrJQmyfhvD3u4lwCneR09ADJ9sG4tMBP5LDSLkn9bkbavzyqqql_0X7hj39dzl-n1w", "lat": 40.021693, "lng": -105.260139, "name": "Boulder", "phone": "+1 303-245-0086", "region": "north-america"}, {"address": "2930 Pearl StBoulder, CO 80301United States", "id": "boulder-pearl", "image": "https://lh3.googleusercontent.com/_JvBccdhLZSIxenZEubM2Qu8Eky6udmnwekH7BhjI1EUo8mCDXDHa0Z7mfNzvZtlmiXI6b6w8U-PY47oUQhPtvYazGS4mG8S61Rr", "lat": 40.021948, "lng": -105.253978, "name": "Boulder \u2013 Pearl Place", "phone": "+1 303-245-0086", "region": "north-america"}, {"address": "3333 Walnut StBoulder CO, 80301United States", "id": "boulder-walnut", "image": "https://lh3.googleusercontent.com/nGvIFmh9d2J68l-U7gYdQAqLZkLNNS_pqhNMtGopMujEpZEneMSH75NFr1WmXJC0GafDLyTVSpnqbuj5Tfjjjk889Zk23dIggqNN", "lat": 40.01993, "lng": -105.24936, "name": "Boulder \u2013 Walnut", "phone": "+1 303-245-0086", "region": "north-america"}, {"address": "Chaussee dEtterbeek 1801040 BrusselsBelgium", "id": "brussels", "image": "https://lh3.googleusercontent.com/Vdcj2ozYBIOyJLAhRyQic7xjw-OfQ_F5b8M9Kaom_56M2zp8UW65Lm1bYJLLEc4_U4tXfAp-CA81U2O2tdHcXPdsCEUO0hyK_SFKF-Y", "lat": 50.839315, "lng": 4.380984, "name": "Brussels", "phone": "", "region": "europe"}, {"address": "Alicia M. De Justo 350, 2nd FloorBuenos Aires, C1107AAHArgentina", "id": "buenos-aires", "image": "https://lh3.googleusercontent.com/08n-ZBH23cWYWAbRo7_uZ6VObzDOLdfvxiAy4vZvX2I_FBn4vlUl_qiwALWBMUp7gQ4LEkj7aW6gB_jdJWNmnsmYEKbWzNsh0EaYpw", "lat": -34.602734, "lng": -58.366992, "name": "Buenos Aires", "phone": "+54-11-5530-3000", "region": "latin-america"}, {"address": "355 Main StreetCambridge, MA 02142United States", "id": "cambridge", "image": "https://lh3.googleusercontent.com/OLL4nJ-esDQ3JFh2XpWSpX8WnO69yzFpYPWIy9yL_2WFapf74z_ZYvfqb4XkF0_hT2rCi3pzN2Y-yglQ-jWMw3u89YKwn4GfdT7FfQ", "lat": 42.362757, "lng": -71.087109, "name": "Cambridge", "phone": "+1 617-575-1300", "region": "north-america"}, {"address": "200 West Franklin StreetChapel Hill, NC 27516United States", "id": "chapel-hill", "image": "https://lh3.googleusercontent.com/AHShjZrvscMoWixuAd0zIXqER2wKMXtoqX4edIzur3FRLJ3DBDIAQqD6PZqB4it_ApAVyitFkjsRPER38oX6XHYOl9mxKbLCXrAQKA", "lat": 35.912445, "lng": -79.058488, "name": "Chapel Hill", "phone": "", "region": "north-america"}, {"address": "210 Carpenter AveChicago, IL 60607United States", "id": "chicago-carpenter", "image": "https://lh3.googleusercontent.com/pgZ_JGnbpqS4P8H29c6hOCQcLXiG1EZEw5W92FKddWuUTW8618AwIho27aAFPmniDUpH_jS3mCpAx3nY6WkT46oetsFMC__SrPCUmw", "lat": 41.88609, "lng": -87.65333, "name": "Chicago \u2013 Carpenter", "phone": "", "region": "north-america"}, {"address": "320 N. Morgan, Suite 600Chicago, IL 60607United States", "id": "chicago-fulton", "image": "https://lh3.googleusercontent.com/ulGqMc02YGomqRC2EN0JP7jOL-6qaIvhCq225DwyeP7b8l-H7ZTWkYDwVKHc0Z4nXEq_TBRCqqPfcc3N8WHm54XpOh16Yx73F4ng", "lat": 41.8873457, "lng": -87.6526874, "name": "Chicago \u2013 Fulton Market", "phone": "+1 312-840-4100", "region": "north-america"}, {"address": "Skt. Petri Passage 51165 CopenhagenDenmark", "id": "copenhagen", "image": "https://lh3.googleusercontent.com/SNSbrYGI_ZBuCl_S8aRh63IIta895tqIUUX3ZT0FWmK7ykhJRy_HNtzoud7XrohnjnSAkuXg9YykkFZqbvkRiZQC7osXrZzGerWdmG8", "lat": 55.680452, "lng": 12.570071, "name": "Copenhagen", "phone": "+45 3370 2600", "region": "europe"}, {"address": "52 Henry St.3rd FloorDetroit, MI 48201United States", "id": "detroit", "image": "https://lh3.googleusercontent.com/WEP2INGXZc9vRv1ii6KDZGoRFPyumV466B3RzUwyzf8W81a7du2KGXlDEqS5g0nbOHsYTAvagFGVJskSonpt6wJWN2mVq8ti7JYPtvs", "lat": 42.340458, "lng": -83.054494, "name": "Detroit", "phone": "+1 248-593-4003", "region": "north-america"}, {"address": "TECOM Zone, Dubai Internet CityDubai, United Arab Emirates", "id": "dubai", "image": "https://lh3.googleusercontent.com/xw0iylnw3b3-qxwoNzLSLJlAAPtkF1KONnIoBTDHtURr04fzH9DeO08GYvEsKYQtE9GCdOMTk_s08H6-btSquKo3moeILfc3Kpu4MA", "lat": 25.0929, "lng": 55.1591, "name": "Dubai", "phone": "+971 4 4509500", "region": "africa-middle-east"}, {"address": "Gordon HouseBarrow StDublin 4Ireland", "id": "dublin", "image": "https://lh3.googleusercontent.com/1z3Fhr6nKlCDeTwc1KoFAMSrnywR0lb8nNdwTI1YgoKSXKIDjQeVB_I3Q8oDZuqqHtlXiUbPmfoUYyAXMObjvMxDcMeTqSY21YvP_A", "lat": 53.3399526, "lng": -6.2360967, "name": "Dublin", "phone": "", "region": "europe"}, {"address": "Taikoo Hui Tower 1, No.383 Tianhe RoadGuangzhou, 510620China", "id": "guangzhou", "image": "https://lh3.googleusercontent.com/BjYQfVMor1QT5hAkc7DcN6_MJdwaySHY6VJ6IY7mQGJRdXjFZhiP-t4MV_QUbp0tBeuYvuMw3nUetTiI-vFl6-BcialJhhurhFrDVeY", "lat": 23.1339728, "lng": 113.3332488, "name": "Guangzhou", "phone": "", "region": "asia-pacific"}, {"address": "Sector 15, Part II Village SilokheraGurgaon 122001India", "id": "gurgaon", "image": "https://lh3.googleusercontent.com/8plKBiWKmwllCXePad0JJ22u1GG7Qe1hveXlx_xJ87XoiQpclQubwxyGxcDU6tkatpb3oi9MYXjm2XszFi5kGn1flfTtjv6MycBWrQ", "lat": 28.460581, "lng": 77.048194, "name": "Gurgaon", "phone": "+91-12-44512900", "region": "asia-pacific"}, {"address": "Building 30MATAM, Advanced Technology CentreHaifa, 3190500Israel ", "id": "haifa", "image": "https://lh3.googleusercontent.com/syKfT9cVMzLi0d4_DSiJztWGwcmWct6IEbpAApEFk_G8ym0xyLLxMBT484zROIOZHMSe9N1o-QQrCAqVWfKRSY6EOeJY9Qa1ftwb", "lat": 32.78897, "lng": 34.958432, "name": "Haifa", "phone": "+972-74-746-6245", "region": "africa-middle-east"}, {"address": "ABC-Strasse 1920354 HamburgGermany", "id": "hamburg", "image": "https://lh3.googleusercontent.com/66R0svr2--6zNOnrqf6JbeZ-bF39bRfHpExjcTlE_AIlPEPk8jO1LjF39FUbDnJB1gh_FiRFX6aCRg4ACjYRbDqb5lf9PdV6qY4S", "lat": 53.553752, "lng": 9.986229, "name": "Hamburg", "phone": "49 40-80-81-79-000", "region": "europe"}, {"address": "1 Matheson StreetCauseway Bay, Hong Kong", "id": "hong-kong", "image": "https://lh3.googleusercontent.com/-Ult8_R6TfQAk16CfjSfl6PLypQBYohUjNjE6xeeektZsrP8XwTv7PnVVE-5Ueh3I-2hPnAdRGg6XrMn9IwI7W1h5LJKtlMVe93Wfw", "lat": 22.278203, "lng": 114.18176, "name": "Hong Kong", "phone": "+852-3923-5400", "region": "asia-pacific"}, {"address": "Survey No. 13, DivyaSree OmegaKondapur VillageHyderabad, Telangana 500084India", "id": "hyderabad", "image": "https://lh3.googleusercontent.com/LAEnc0tzA-JSb5XM5oct5paX98QK9zh_aqa_qKcjAoXo2MChgOjdj_EZpgIZsVAvEY-I0bmMmhCBb5gkoVN4ebqCG9ZfjCbo_stJaw", "lat": 17.458461, "lng": 78.372452, "name": "Hyderabad", "phone": "+91-40-6619-3000", "region": "asia-pacific"}, {"address": "19510 Jamboree RoadIrvine, CA 92612United States", "id": "irvine", "image": "https://lh3.googleusercontent.com/LWGkhXkRRzWnMlNy_Ps74-VTxB2ISXK0Kkick1SujTLYvNAUqo9_HR7SILSZZsiaiGWsXtx7dR5Hz9Q5psu1MWP9BHtDuGYc_hz_eg", "lat": 33.658792, "lng": -117.859322, "name": "Irvine", "phone": "+1 949-794-1600", "region": "north-america"}, {"address": "Eski Buyukdere Caddesi No: 20934394Istanbul, Turkey", "id": "istanbul", "image": "https://lh3.googleusercontent.com/_mdN7z1Q-9fKgpHTb1rQJosllxqn7glRJ_G2enX4WPmImuJjLHKw-JBZ8z5B9vMSo12SexGBOD1i2NHXqEy4OaOJekn0g3Fp3bDk_Q", "lat": 41.081697, "lng": 29.00859, "name": "Istanbul", "phone": "", "region": "africa-middle-east"}, {"address": "Pacific Century Place Tower Level 45 SCBD Lot 10,Jl. Jend. Sudirman No.53,RT.5/RW.3, Senayan, Kby. Baru,Kota Jakarta Selatan,Daerah Khusus Ibukota Jakarta 12190, Indonesia", "id": "jakarta", "image": "https://lh3.googleusercontent.com/JEaMUfOUq6bxN7jeIN1z2me5-JvlLRkrFJgf_A0GvqtOquU6Tfjg0ecKeR_Ck27L0S1zC2t_4I6nVP6pBdBtSKst7tkJEoC7LyYq", "lat": -6.227664, "lng": 106.808471, "name": "Jakarta", "phone": "", "region": "asia-pacific"}, {"address": "35 Ballyclare Drive, Building EJohannesburg2191, South Africa", "id": "johannesburg", "image": "https://lh3.googleusercontent.com/EDxefwSgeKyh8zN9VUUGhu3hiBqH7Z3UEOXfZeij7YnUhZLqLElu8dhi4FziOepRun-fjfwIWdf5W8CTG5ZSYMu4k8z9QZjTgjQRuQ", "lat": -26.0734457, "lng": 28.032035, "name": "Johannesburg", "phone": "", "region": "africa-middle-east"}, {"address": "777 6th Street SouthKirkland, WAUnited States", "id": "kirkland", "image": "https://lh3.googleusercontent.com/Vgmu21GQbS0pga_tJaG0_35AYOzM64Uxp-zNYyMVnd3oXFHmHeMJpx8UjcsMYdnxbdlFZ4KGFowOtpHxsNlUw8qS21sYBy9jPbqkuA", "lat": 47.669568, "lng": -122.196912, "name": "Kirkland", "phone": "+1 425-739-5600", "region": "north-america"}, {"address": "51 Breithaupt StreetKitchener, ON N2H 5G5Canada", "id": "kitchener", "image": "https://lh3.googleusercontent.com/jUCZzQYnJXCUZ3ZxAEB14qukCV6aGxfh84hExpcpye314DhOWB4jtpUoNDrCtA2laV7qDHBAYGtIuZan9Ir5Hp6_U0B2zTGgPqsb", "lat": 43.4541137, "lng": -80.4992423, "name": "Kitchener", "phone": "+1-519-880-2300", "region": "north-america"}, {"address": "Axiata TowerNo. 9, Jalan Stesen Sentral 550470 Kuala LumpurMalaysia", "id": "kuala-lumpur", "image": "https://lh3.googleusercontent.com/c5kAdRoyejY1Z5i9A3hYKfIG55GrKdAc0iJjH-gYo-tWd3JUksvsfZx7LU5yzay4HJmxCQEir2cejbZ2LurYfKL_emC9e9PCDVxd", "lat": 3.133445, "lng": 101.684609, "name": "Kuala Lumpur", "phone": "", "region": "asia-pacific"}, {"address": "Avenida da Liberdade, 110Lisbon, 1269-046, Portugal", "id": "lisbon", "image": "https://lh3.googleusercontent.com/py3HZVLLpxjMhRL6fgUKmHqGODp6ZH-5abQBHGqyKrCyuoW0t-q0ypNVN_jOfD3ZEO08Y9Q0m-E4ZyuNrMgl-mlaECkCAEyc7Af1", "lat": 38.718887, "lng": -9.143781, "name": "Lisbon", "phone": "+351 21 122 1803", "region": "europe"}, {"address": "6 Pancras SquareLondon N1C 4AGUnited Kingdom", "id": "london-6ps", "image": "https://lh3.googleusercontent.com/WTxWzt3AOcEMwoT2OonLTlc63pa4V-GsYbZg5Hu7rfe9ZioMaRurkxaQ5tOcuC9nZkCyh2IjQb-xMy4Tq8ISrHjfDHmzZXnExTjP", "lat": 51.533311, "lng": -0.126026, "name": "London \u2013 6PS", "phone": "+44-20-7031-3000", "region": "europe"}, {"address": "Belgrave House76 Buckingham Palace RoadLondon SW1W 9TQUnited Kingdom", "id": "london-bel", "image": "https://lh3.googleusercontent.com/bLxZNCaDE2Fdj7woV_9JUJEUfUvTrhI57jHNEeW-OenTspzM21miwz1gGydzZ2Ke_vfRdkqdo4dyN2mJCntC2p4qvRUyipPWppAC9g", "lat": 51.494961, "lng": -0.146652, "name": "London \u2013 BEL", "phone": "+44-20-7031-3001", "region": "europe"}, {"address": "1\u201313 St Giles High StLondon WC2H 8AGUnited Kingdom", "id": "london-csg", "image": "https://lh3.googleusercontent.com/32nlExbSrV5rJR9Qsqfkbckn6_yd-4QRaoSDmp9JLyaZxojfl9aH1LZSrSvcsT128AUzHqkEfMhTE2miDuOu7gj-7x3Ginqr4rgowg", "lat": 51.516027, "lng": -0.12755, "name": "London \u2013 CSG", "phone": "+44 (0)20-7031-3000", "region": "europe"}, {"address": "340 Main StreetLos Angeles, CA 90291United States", "id": "los-angeles", "image": "https://lh3.googleusercontent.com/MWGnaY3t_1-j7YylPpq35rvBU9gIBJIsnrtW95THrBw9N0PWrAVtbHKUBH8OdxyWI9gYdymndmSgwS8tl23GylytyefNC74i4-pniQ", "lat": 33.995939, "lng": -118.4766773, "name": "Los Angeles, US", "phone": "+1 310-310-6000", "region": "north-america"}, {"address": "811 E Washington AveSuite 700Madison, WI 53703United States", "id": "madison", "image": "https://lh3.googleusercontent.com/sQDFJpbQl4EVGfdpHsw_24mxsnUNAnDs6f-00QCj0g_Z38CEqjG4PuLPoS_T6eTOPV3QXX907Kap_TkaE3cEG4fhJWIoWsZELIGyvw", "lat": 43.081091, "lng": -89.374619, "name": "Madison", "phone": "+1 608-669-9841", "region": "north-america"}, {"address": "Plaza Pablo Ruiz Picasso, IMadrid 28020Spain", "id": "madrid", "image": "https://lh3.googleusercontent.com/x36CdPxkwxxctp0wvDYfTjgTzNgMiZV0xoKeLMwHzdccpJGYUA6a61fSeX1_Rt-lfofMjfUwAhFxd7DbjsE8_393plkTly-T5YkpCA", "lat": 40.4505331, "lng": -3.6931161, "name": "Madrid", "phone": "+34 91-748-6400", "region": "europe"}, {"address": "161 Collins Street,Melbourne VIC 3000,Australia", "id": "melbourne", "image": "https://lh3.googleusercontent.com/U_5KiB8x7T-Rrdp90ygnO1kbZxiWJz4G6CbD6_51CjH5zaMP23upWELryFOe99k_AqlPZschCY7Nx--wYufcIV54HnjGcP3lf28X1A", "lat": -37.815328, "lng": 144.968737, "name": "Melbourne", "phone": "", "region": "asia-pacific"}, {"address": "Google Mexico, S. de R.L. de C.V.Montes Urales 445Lomas de ChapultepecMexico City 11000, Mexico", "id": "mexico-city", "image": "https://lh3.googleusercontent.com/P_U5ECZJ--t8khoKFxoeeJwa7PZy-3TriZbit5sRJDUdupf3NZRJegsnB4ucLqdLEV3De41fmByckDDC6uHMI82cXIFp4C1WwI1a1g", "lat": 19.4283793, "lng": -99.2065518, "name": "Mexico City", "phone": "+52 55-5342-8400", "region": "latin-america"}, {"address": "1450 Brickell Ave Ste 900 Miami FL 33131United States", "id": "miami", "image": "https://lh3.googleusercontent.com/DTk99d9bCqiCN8sFj3FBr8BdGPYC97PCYbiLbdq6GZ-_Er268DSlvfRM_g8hwA5tOmw_6c3PBjpKpuRQTuXS8H8_hpIlCQKyobyYjQ", "lat": 25.758473, "lng": -80.1932144, "name": "Miami", "phone": "+1 305-985-7900", "region": "north-america"}, {"address": "Porta Nuova Isola, Building C, Via Federico Confalonieri 420124 MilanItaly", "id": "milan", "image": "https://lh3.googleusercontent.com/nZ_KE1LqNmW5qb6i-czLlm_yqRJtLmvEmyLRI0BYjqMlOiC_5VmbEI3DeHQyPOHp6PzoN2gKJ0j73BALkddFmDFXOIe9Wwctmt73cqI", "lat": 45.486147, "lng": 9.189546, "name": "Milan", "phone": "", "region": "europe"}, {"address": "1253 McGill College AvenueMontreal, QC H3B 2Y5Canada", "id": "montreal", "image": "https://lh3.googleusercontent.com/S310Um4pKym8bvHQcQmJLc4ohURWEq3AQHjJ-b5aMY-TpA9P4LCKcxGEg4fik-zSL6MrtiEi8Qt3JbAZl8x-GiI31wfm_myGfb3manQ", "lat": 45.50191, "lng": -73.570365, "name": "Montreal", "phone": "514-670-8700", "region": "north-america"}, {"address": "7 Balchug StMoscow 115035Russia", "id": "moscow", "image": "https://lh3.googleusercontent.com/i6cwRxcix3LUdviTVKoLG2Ep6q9pjfPIX_nrge-YkgjIvTgCH5QQpSI6wCpKvg0HiH56lHu6K8eAkCrPZUCzspS6Y9K19U47xr4hww", "lat": 55.746747, "lng": 37.626435, "name": "Moscow", "phone": "+7-495-644-1400", "region": "europe"}, {"address": "1600 Amphitheatre ParkwayMountain View, CA 94043United States", "id": "mountain-view", "image": "https://lh3.googleusercontent.com/Mh8P8gvVwO7NOXfg8anxwPXRy5oKZJ6Cz_LbFfOVdeIsdDfogmMcMsiW7HD7HD2NOINzAPH_v8dALWSuDiiTjCjRnenI7B3l6Pg4yw", "lat": 37.421512, "lng": -122.084101, "name": "Mountain View", "phone": "", "region": "north-america"}, {"address": "3 North AvenueMaker Maxity, Bandra Kurla ComplexBandra EastMumbai, Maharashtra 400051India", "id": "mumbai", "image": "https://lh3.googleusercontent.com/twldrlVORn84fYsOLwNLabfRPQYX-dJAzJtpam-Ea4D7QIY1pvMa9FCMbpjUFA8uniBg6XAh8pMijf9qnjmEm4d17UFkwRGToiv5Ug", "lat": 19.054364, "lng": 72.850591, "name": "Mumbai", "phone": "+91-22-6611-7150", "region": "asia-pacific"}, {"address": "Erika-Mann-Str. 3380636 MunichGermany", "id": "munich", "image": "https://lh3.googleusercontent.com/sVZqxencTTD84raIgMWd5SbmXZTvQmwUzxj6IakbIGuAua5JDu-Q64uJE-cm3TYeSjKVQo7VSwIODVpwswjtrpwBUvXTa5MDFXoNAw", "lat": 48.14305556, "lng": 11.54083333, "name": "Munich", "phone": "", "region": "europe"}, {"address": "111 8th AvenueNew York, NY 10011United States", "id": "new-york", "image": "https://lh3.googleusercontent.com/BWdXxSOqBpjGFzAJVVr02QQs5XSe33dEeNDG6lXhd-nuv32ruMjD01yBJX3Rk4_xP6glB1ycMvwypEPr6YO665grfWqEEI2LPYUaMg", "lat": 40.741445, "lng": -74.003102, "name": "New York", "phone": "+1 212-565-0000", "region": "north-america"}, {"address": "Aker BryggeBryggegata 60250 OsloNorway", "id": "oslo", "image": "https://lh3.googleusercontent.com/lc9jPxaz4CzdC3sD4wFlzml1Y221PvtsisYGenint536WNbyIMY2cp2qnQOmnT0IWPoOCjarwMgK6zddvTcOu6YcAuaVLfQAdqZ2UQg", "lat": 59.90987, "lng": 10.72598, "name": "Oslo", "phone": "", "region": "europe"}, {"address": "8 Rue de Londres75009 ParisFrance", "id": "paris", "image": "https://lh3.googleusercontent.com/GHZlAB7t3toRGww1NJ6ZC2IpvR0jkgqFkQ0ZvM02dmQWt6fiHIKJZ7Eova959UD0PAapPE2r2TYMe3-dE3jGDgEoqHch0qyjAKvPENc", "lat": 48.8771, "lng": 2.33, "name": "Paris", "phone": "", "region": "europe"}, {"address": "6425 Penn AvenuePittsburgh, PA 15206United States", "id": "pittsburgh", "image": "https://lh3.googleusercontent.com/47kJwc4CR6oGOI2l_su5CJHnEWkrUZlz7LZRGXHgF71xa-0gJc8qCBhnsNoigcNEGFfBpb3y5AxVXJP_TxvHtgUgTrU8zmBm3Two7w", "lat": 40.45716, "lng": -79.916596, "name": "Pittsburgh", "phone": "+1 412-345-6700", "region": "north-america"}, {"address": "12422 W. Bluff Creek DrivePlaya Vista, CA 90094United States", "id": "playa-vista", "image": "https://lh3.googleusercontent.com/xnHVNI6bCcQxJyLV6sG3op8PlJcT9XgMAGmHrXtj5axhCZPH7Tbc9Ppjb2gTCtGbKmilT17B0dKzczOJh9JANh8Wwz0SXH0pEqCOkQ", "lat": 33.97684, "lng": -118.407244, "name": "Playa Vista", "phone": "", "region": "north-america"}, {"address": "Wells Fargo Building, 309 SW 6th AvePortland, OR 97204United States", "id": "portland", "image": "https://lh3.googleusercontent.com/FMeFmwWFZJD02kj0H73t5v8NPrVOecVxuCl9cA-vLiXgaXErYQxmMXJKvvROgwSNvgPdmRZ4-GQuub74p0dDwJgY37vBNN2vgx7Utw", "lat": 45.521622, "lng": -122.677458, "name": "Portland", "phone": "", "region": "north-america"}, {"address": "Stroupeznickeho str. 3191/17Prague, Czech Republic150 00", "id": "prague", "image": "https://lh3.googleusercontent.com/jVNKH2mzDQ4Zu1-1G80-nDvLHYE9dmeetv43WG3zo7-dQWJoX1ghtXvviZHDLRG-ScqA804I2guuExY-8pkzIdkYlU28QGOB8Jkkiw", "lat": 50.070259, "lng": 14.402642, "name": "Prague", "phone": "", "region": "europe"}, {"address": "1600 Seaport BoulevardRedwood City, CA 94063United States", "id": "redwood-city", "image": "https://lh3.googleusercontent.com/a7GCRT1go5jQzEQj--A-kq98pURYsO4cTCJPj6azEev7za4Y__Kd3E_khFyn5uxRtPC0Co_ZxzQtqrlXeOSNey8fOSV4pK0ffzSW5A", "lat": 37.512171, "lng": -122.201178, "name": "Redwood City", "phone": "", "region": "north-america"}, {"address": "1875 Explorer Street 10th FloorReston, VA 20190United States", "id": "reston", "image": "https://lh3.googleusercontent.com/4WuJCZlLflcQjsyhsGX3VSGDEVmC0Ljq291ECgVk3nN89ppnhSbdQIRI1I1-qh5YEf0Yicdc6amuqKz7oAdgLvQoNBrM9Zh3BcUwSw", "lat": 38.958309, "lng": -77.359795, "name": "Reston", "phone": "+1 202-370-5600", "region": "north-america"}, {"address": "901 Cherry AvenueSan Bruno, CA 94066United States", "id": "san-bruno", "image": "https://lh3.googleusercontent.com/zcy-Un_QDZfx7nTlImk-jCocxSUjQAQ4SS0eVdBuNRZz3Nyb5WK_2oGwYpnBEdqjIcv_b-umq_akpWBEylaEp-wXk3pj9-gu6Ko9Igs", "lat": 37.62816, "lng": -122.426491, "name": "San Bruno", "phone": "", "region": "north-america"}, {"address": "6420 Sequence Dr Suite 400San Diego, CA 92121United States", "id": "san-diego", "image": "https://lh3.googleusercontent.com/RgGUUE3ra1j-mQIH8vp6an37hlwduD8uVnaCv8ivo5mX6ekdnZYd0-hlQ1hpQzV0ZgPk7y8h60oWy5MK5VF48ozZMYRXnh1ddJjuVGo", "lat": 32.90961, "lng": -117.181899, "name": "San Diego", "phone": "+1 858-239-4000", "region": "north-america"}, {"address": "345 Spear StreetSan Francisco, CA 94105United States", "id": "san-francisco", "image": "https://lh3.googleusercontent.com/OC_0_XdXLar-ytOETAv3uwRGfnLABSRu66hqLQpLrwIhqInPD6ccdZSEu_d5S8wmjc1knb9OM7yNh2K7hoGznvKZOgFlvrxJesd7mQ", "lat": 37.789972, "lng": -122.390013, "name": "San Francisco", "phone": "+1 415-736-0000", "region": "north-america"}, {"address": "Costanera Sur Rio 2730 Las Condes, SantiagoChile", "id": "santiago", "image": "https://lh3.googleusercontent.com/KrMbZzxFsAcNmYg8BQL_qBAekN1bNNJGo1aar8nkFhYXYDYOBmwJc2x1XElkDdIqLdedU5V7QKTGxXne8-f-qAW_bOy1FUqmJ8JM", "lat": -33.413383, "lng": -70.605665, "name": "Santiago", "phone": "", "region": "latin-america"}, {"address": "Av. Brigadeiro Faria Lima, 3477 S\u00e3o Paulo04538-133, Brazil", "id": "sao-paulo", "image": "https://lh3.googleusercontent.com/MwcGyEZBKkmoycVLcpl_U3gdIJBoWDU8u2kUNq57DmZVkWDyraoaZyQC0HOiFQvNHjVugEiVTWsy-poAsNfDLoSkJ5RoTBi1Hpd4GcI", "lat": -23.586479, "lng": -46.682078, "name": "Sao Paulo", "phone": "", "region": "latin-america"}, {"address": "601 N. 34th StreetSeattle, WA 98103United States", "id": "seattle", "image": "https://lh3.googleusercontent.com/pNaRyPV3SkqsVvmdmN0sC-viBupr-41tZM3_cpSNH_3Zdy826gIhM0zHfoowA6SCkcsOkUxDvJ8wG5CodorohisOgR9q_QE7wH1ua-M", "lat": 47.649316, "lng": -122.350629, "name": "Seattle", "phone": "+1 206-876-1800", "region": "north-america"}, {"address": "Google Korea LLC.22nd Floor, Gangnam Finance Centre152 Teheran-ro, Gangnam-guSeoul 06236South Korea", "id": "seoul", "image": "https://lh3.googleusercontent.com/i8rfvJIUNpLBkmWWSoetUzFGHUd_RaulLh8F3EHme3FMTUtDs8EVWsrFLuaemh1Zd60p5ndCcKq8-ZQN8eibbua-YNzlzQ8AKtHFzrQ", "lat": 37.500295, "lng": 127.036843, "name": "Seoul", "phone": "+82-2-531-9000", "region": "asia-pacific"}, {"address": "100 Century Avenue, PudongShanghai 200120China", "id": "shanghai", "image": "https://lh3.googleusercontent.com/wFCKLAJvrAoE_GiXqRNa0w4Rsr0iY_SyMGbO2jnIhLXGanYs1c5_BPE8TxQJw-e14uaLDHjY772V-Vv-Kf3GmrIRSlHjoV9yD339wRQ", "lat": 31.23464, "lng": 121.507662, "name": "Shanghai", "phone": "+86-21-6133-7666", "region": "asia-pacific"}, {"address": "70 Pasir Panjang Road, #03-71, Mapletree Business City Singapore 117371", "id": "singapore", "image": "https://lh3.googleusercontent.com/--5H57B8aG4-DX9s79Spo3ygrsI9NMFnZo1uTZzs5s5AeeOvmiy81k__tu9r7JbRTTLzryK-oUy0UREclmD_qfV81VvaT4K9jJa8gg", "lat": 1.276466, "lng": 103.798965, "name": "Singapore", "phone": "+65 6521-8000", "region": "asia-pacific"}, {"address": "Kungsbron 2 111 22 StockholmSweden", "id": "stockholm", "image": "https://lh3.googleusercontent.com/Q2016qdodQKowCyzfN14RLYERc2IplyM2FzJvj0kzbW4eLXnIxoFF1eZMc_CwtodxbpyfhfebUrawHtIgFb2kh9-EQnhcaHXpV0Fnw", "lat": 59.333432, "lng": 18.054619, "name": "Stockholm", "phone": "", "region": "europe"}, {"address": "803 11th AvenueSunnyvale, CA 94089United States", "id": "sunnyvale", "image": "https://lh3.googleusercontent.com/xd1Z3wr4cee9gtKQSnrOd-NWjc6UTwpwngElt4pkqukzOf-l0hrgQuRRBzvSjqmF4w1ZAHR1I12grFa5Zhqd9-7dKUitPtpMg51Zrf8", "lat": 37.403694, "lng": -122.031583, "name": "Sunnyvale", "phone": "", "region": "north-america"}, {"address": "48 Pirrama RoadSydney, NSW 2009Australia ", "id": "sydney", "image": "https://lh3.googleusercontent.com/03Hp4ZwQHs_rWLEWQtrOc62hEHzffD_uoZFCbo56eoeLyZ3L89-Fy5Dd8WcmrGFGK31QC_hZqzuU7f9QhxqjckE7BSLo_arwWjCH1w", "lat": -33.866638, "lng": 151.195672, "name": "Sydney", "phone": "+61 2 9374 4000", "region": "asia-pacific"}, {"address": "No. 7 XinYi Road Section 5, TaipeiTaiwan", "id": "taipei", "image": "https://lh3.googleusercontent.com/h19TQz36F4jY_ZfQxuP5F-THZbl4nAIGz473uFfLqzD_6kpw-r3b6M_Wbna5QvvymqZ-wdnhkLCRt63Pypnc9GyawNqMlQwM1_BYbg", "lat": 25.033447, "lng": 121.564901, "name": "Taipei", "phone": "+886 2 8729 6000", "region": "asia-pacific"}, {"address": "Yigal Alon 98Tel Aviv, 6789141Israel ", "id": "tel-aviv", "image": "https://lh3.googleusercontent.com/BZxU1dJCWFmtVeBqVYFC8SmSzX4CCzO5eedosW1s7sv2b2HoKwEno15vICfeQdsc_BGIaysKb8VyF64IB9hbFzMZ_MlQDJhP7kfF", "lat": 32.070043, "lng": 34.794087, "name": "Tel Aviv", "phone": "+972-74-746-6453", "region": "africa-middle-east"}, {"address": "Roppongi Hills Mori Tower6-10-1 RoppongiMinato-ku, Tokyo 106-6126Japan", "id": "tokyo-rpg", "image": "https://lh3.googleusercontent.com/i7PqriAmbeqB7KQ4h_8K0T60DD-oAoz7bvvjlB4vx2267l9QHfKBHb7WUMSutYd88Xu4TRwWqIquL05bYcpTyU_58gWp8Ja2Xo2zOfM", "lat": 35.66047, "lng": 139.729231, "name": "Tokyo \u2013 RPG", "phone": "+81-3-6384-9000", "region": "asia-pacific"}, {"address": "Shibuya Stream3-21-3 ShibuyaShibuya-ku, Tokyo 150-0002Japan", "id": "tokyo-strm", "image": "https://lh3.googleusercontent.com/GzaUJcEqlixelFX8dg1qcLPwAb4RpEXr3JMxyxpgSTWL17Gso_aq3NeMtQPES7f_JdIrGr9YTBSt08XgNAeoLSkxr3Ue_J0cW3VMCw", "lat": 35.6572564, "lng": 139.7028246, "name": "Tokyo \u2013 STRM", "phone": "+81-3-6384-9000", "region": "asia-pacific"}, {"address": "111 Richmond Street WestToronto, ON M5H 2G4Canada", "id": "toronto", "image": "https://lh3.googleusercontent.com/vZUQcWL3r_bsHBRP-Z0XfhMxjlSAAe9sZLlw5rbBzqsM6w-WVjnTZGaw3w-PkqkhHPy0x-2Xzg_gishFkVjn5r3epKifwhmRc741", "lat": 43.650477, "lng": -79.383858, "name": "Toronto", "phone": "416-915-8200", "region": "north-america"}, {"address": "Graben 191010 WienAustria", "id": "vienna", "image": "https://lh3.googleusercontent.com/roYQN_TnYd_fP0FCdZxA6lMLbp-h7PyPlDBKwVdfVWKkOCxmLjFHqm-n7hrcakcXHS1FzjXW5XWF_MApzuGIrvy2cewCYd7Z9q5MUw", "lat": 48.209351, "lng": 16.368419, "name": "Vienna", "phone": "", "region": "europe"}, {"address": "Emilii Plater 5300-113 WarsawPoland ", "id": "warsaw", "image": "https://lh3.googleusercontent.com/jTf0m2s5A2qS25ArE3x6Tl1KXtpv3JmHIfcBuw7f-JHsTR0tMiyUVeHO1wBeJ2eEGcAWUbTe3b9B8iP8wyL-TROS5zxmMofMHsnf", "lat": 52.233448, "lng": 21.001668, "name": "Warsaw", "phone": "+48 22 207 19 00", "region": "europe"}, {"address": "25 Massachusetts AvenueWashington DC, 20001United States", "id": "washington-dc", "image": "https://lh3.googleusercontent.com/6rKu8CCH6nMVKjwpnxDlgf_Sdlc7jk83QBVhoLikzEyibYTZkvNPn-QPCJTv3AkjUYf2dHcE15UvPsrg18xNd4R8_eg3b-yn01yXgQ", "lat": 38.898337, "lng": -77.010286, "name": "Washington DC", "phone": " (202) 346-1100", "region": "north-america"}, {"address": "Gen. Jozefa Bema nr 250-265 WroclawPoland", "id": "wroclaw", "image": "https://lh3.googleusercontent.com/Or6dY4MCUCbMnDv4kG8J7u-QTsWhvbqbAbMN9Vp38aJAS7ec7A39gYddcEGbrwd_veFeZo2phypqc1ABk20PZ9jCVxZfuNGYS7j3LDc", "lat": 51.117687, "lng": 17.041737, "name": "Wroclaw", "phone": "+48 (71) 73 41 000", "region": "europe"}, {"address": "Brandschenkestrasse 1108002 Z\u00fcrichSwitzerland", "id": "zurich", "image": "https://lh3.googleusercontent.com/kmEsDEYzbMlluwDPYkeEEBpAvL9MJbXZR3hD3uettOqE8T7lbXvV508j4d4QngB7iwYZa8YYlXiVnGWfZ4ZvTJbputGXsfxrLGhD3tI", "lat": 47.365063, "lng": 8.524425, "name": "Zurich", "phone": "+41 44 668 18 00", "region": "europe"}], "regions": [{"coords": {"lat": 2.9660291, "lng": 1.3271339}, "id": "africa-middle-east", "name": "Africa & Middle East", "zoom": 3.0}, {"coords": {"lat": 0.0524811, "lng": 127.6560787}, "id": "asia-pacific", "name": "Asia Pacific", "zoom": 3.0}, {"coords": {"lat": 46.1352815, "lng": 7.4033438}, "id": "europe", "name": "Europe", "zoom": 4.0}, {"coords": {"lat": -17.5554497, "lng": -99.2316195}, "id": "latin-america", "name": "Latin America", "zoom": 3.0}, {"coords": {"lat": 45.7128252, "lng": -97.1547448}, "id": "north-america", "name": "North America", "zoom": 4.0}]}';
    final jsonResponse = json.decode(jsonString);
    LatLong latLong = LatLong.fromJson(jsonResponse);
    return latLong.list;
  }

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    setCustomMapPin();
    setGreenCustomMapPin();
    _getCurrentLocation();
    _pageController = PageController(initialPage: 0,viewportFraction: 0.8,keepPage: true);
  }

  void itemChange(bool val, int index){
    setState(() {
      checkList[index].isChecked = val;
    });
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _lng = LatLng(_currentPosition.latitude,_currentPosition.longitude);
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }

  void setCustomMapPin() async {
    pinLocationIcon = await getBitmapDescriptorFromAssetBytes('image/ic_marker1.png', 40);
  }
  void setGreenCustomMapPin() async {
    greenMarker = await getBitmapDescriptorFromAssetBytes('image/ic_pin_circle_green.png', 40);
  }

  @override
  Widget build(BuildContext context) {
    List<ParseLatlng> list = loadPerson();
    return  Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(110),
          child: Container(
              child: Column(
                  children: <Widget>[
                        Container(margin: const EdgeInsets.fromLTRB(7, 5, 7,0),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 0.1,
                                  color: Colors.black12
                              )
                          ),
                          height: 60,
                          child: Stack(
                            children: [
                              Container(
                                child: Card(
                                  elevation: 0.5,
                                  child: TextFormField(
                                    cursorColor: AppColors.colorPrimaryDark,
                                    decoration: InputDecoration(
                                      prefixIcon: Container(margin: const EdgeInsets.only(left: 10),
                                        child: Image(image: AssetImage('image/ic_search_grey_25.png'),height: 30,width: 30,),),
                                        hintText: 'Address,City,Zip,Neighbourhood',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.zero,borderSide: BorderSide.none),
                                    ),
                                  ),
                                ),
                              ),
                              Container(margin: const  EdgeInsets.only(right: 20),
                                alignment: Alignment.centerRight,
                                child: Image(image: AssetImage('image/ic_green_send.png'),height: 30,width: 30,),
                              )
                            ],
                          )
                        ),

                Container( margin: const EdgeInsets.only(top: 8,left: 4,right: 4),
                  height: 30,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: buttonFilter.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: (){
                            setState((){
                              blankBtnFilterList.contains(index.toString())?blankBtnFilterList.remove(index.toString()):blankBtnFilterList.add(index.toString());
                              if(index==3)visible=visible?false:true;
                              if(index!=3){
                                visible=false;
                                blankBtnFilterList.remove('3');
                              }
                            });
                          },
                          child: Container(margin: const EdgeInsets.only(right: 4,left: 4),
                            width: MediaQuery.of(context).size.width /4,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff18a499),
                                    width: 0.8
                                ),
                                borderRadius: BorderRadius.circular(5),
                                color: blankBtnFilterList.contains(index.toString())?Color(0xff18a499):Colors.white,
                              ),
                              child: Container(
                                child: Center(child: Text(buttonFilter[index], style: TextStyle(color: blankBtnFilterList.contains(index.toString())?Colors.white:Color(0xff18a499), fontSize: 13.0),)),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ]
            ),
          ),
      ),
      body: Container(
         child:
          Stack(
              children: <Widget>[

                //(_lng!=null)?
                GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(56.172249, 10.187372),zoom: 4),
            markers: Set.of(markers.values),
            onTap: (val){
              setState(() {
                courseul = false;
              });
            },
            onMapCreated: (GoogleMapController controller){
              _controller.complete(controller);
                  setState(() {
                 for(int i=0;i<list.length;i++){
                   markers[i.toString()] = Marker(markerId: MarkerId(list[i].id),icon: pinLocationIcon,position: LatLng(list[i].lat,list[i].lng),
                   onTap: (){
                     setState(() {
                       _selectedIndex = i;
                       _pageController = PageController(viewportFraction: 0.8,initialPage: _selectedIndex,keepPage: true);

                       Future.delayed(Duration(milliseconds: 10),(){
                         _pageController.jumpToPage(_selectedIndex);
                         _pageController.animateToPage(_selectedIndex,curve: Curves.decelerate,duration: Duration(milliseconds: 300));
                       });
                        markers[i.toString()] =  Marker(markerId: MarkerId(list[i].id),icon: greenMarker,position: LatLng(list[i].lat,list[i].lng),
                        onTap: (){
                          setState(() {
                            courseul = true;
                          });
                        });
                     });
                     courseul = true;
                   });
                 }
               });
            },
          ),//:Center(child: CircularProgressIndicator(),),
                Visibility(
                  child: Container(
                    height: 228,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(margin: const EdgeInsets.only(left: 10),
                          child: Text('Property Type(${checkList.where((element) => element.isChecked).toList().length} Selected)',style: TextStyle(color: Colors.black,fontSize: 17,fontFamily: 'poppins_medium'),),
                        ),
                        Container(
                          height:150,
                          child: GridView.count(
                            childAspectRatio: 4/1,
                            crossAxisCount: 2,
                            children: List.generate(checkList.length, (index) {
                              return  GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      checkList[index].isChecked = !checkList[index].isChecked;
                                    });
                                  },
                                  child: Container(margin: const EdgeInsets.only(left: 10),
                                    child: Row(
                                      children: [
                                        checkList[index].isChecked
                                            ? Icon(
                                          Icons.check_circle,
                                          color: AppColors.colorPrimaryDark,
                                          size: 25,
                                        )
                                            : Icon(
                                          Icons.circle,
                                          color: Colors.grey[100],
                                          size: 25,
                                        ),
                                        SizedBox(width: 5),
                                        Text(checkList[index].item),
                                      ],
                                    ),
                                  )
                              );
                            }),
                          ),
                          ),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          color: AppColors.colorPrimaryDark,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Container(margin: const EdgeInsets.only(left: 5),
                               child:  InkWell(
                                 child:
                                 Text('Reset',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w500),),
                                 onTap: (){
                                   setState(() {
                                     checkList.map((e) => e.isChecked=true).toList();
                                   });
                                 },
                               ),
                             ),
                              Container(margin: const EdgeInsets.only(right: 5),
                                child: FlatButton(
                                  color: Colors.white,
                                  child: Text('Done',style: TextStyle(color:AppColors.colorPrimaryDark,fontSize: 17),),
                                  onPressed: (){
                                    setState(() {
                                      blankBtnFilterList.remove('3');
                                      visible = false;
                                    });
                                  }
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ),
                  visible: visible,
                ),

                Visibility(
                  visible: courseul,

                  child:  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.bottomCenter,

                    child: SizedBox(
                      height: 210,
                      width: MediaQuery.of(context).size.width,

                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: AlwaysScrollableScrollPhysics(),

                        onPageChanged: (int index) =>
                            setState(() =>
                            _index = index),

                        controller: _pageController,
                        itemCount: list.length,

                        itemBuilder: (context, i) {

                          return Transform.scale(
                            scale: i == _index ? 1.03 : 0.9,

                            /*white box desing*/
                            child: GestureDetector(
                              onTap: () {
                              },

                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),

                                elevation: 3,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[

                                    Expanded(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 113,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                          image: DecorationImage(
                                              image:  NetworkImage(list[i].imgUrl),
                                              fit: BoxFit.cover
                                          )
                                        ),
                                      ),
                                    ),

                                    /*name*/
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 10, top: 2),
                                      child: Text(list[i].name, style: TextStyle(fontSize: 16, fontFamily: 'poppins_semibold',
                                          color: Colors.black),
                                      ),
                                    ),

                                    /*work*/
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 10, top: 5),
                                      child: Text(list[i].region, style: TextStyle(fontSize: 12, fontFamily: 'poppins_regular',
                                          color: Colors.black38),
                                      ),
                                    ),

                                    /*address*/
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 10,),
                                      child: Text(
                                        list[i].address,overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: 'poppins_regular',
                                            color:
                                            Colors.black),
                                      ),
                                    ),

                                    /*rupees*/
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 10,),
                                      child: Text('Lat : ${list[i].lat}   Lng : ${list[i].lng}', style: TextStyle(fontSize: 12, fontFamily: 'poppins_regular',
                                          color: Colors.black),
                                      ),
                                    ),

                                    /*green line*/
                                    Container(
                                      margin: EdgeInsets.only(top: 2, left: 3, right: 3),
                                      height: 2,
                                      width: MediaQuery.of(context).size.width,
                                      color: AppColors.colorPrimaryDark,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
          ),
       ),
    );
  }
}

List<checkItem> checkList = <checkItem>[
   checkItem('Meeting Room'),
   checkItem('Open Space'),
   checkItem('Private Desk Area'),
   checkItem('Private Room'),
   checkItem('Shared Desk Area'),
   checkItem('Shared Room'),
];