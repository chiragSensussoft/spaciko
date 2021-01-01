import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ApiCalling extends StatefulWidget {
  @override
  _ApiCallingState createState() => _ApiCallingState();
}

class _ApiCallingState extends State<ApiCalling> {
  TextEditingController _controller = TextEditingController();
  String path = '/Users/mac/Library/Developer/CoreSimulator/Devices/D72BF767-D638-4CB3-BC9F-02CB2D61663D/data/Containers/Data/Application/10107924-440D-4390-8F17-04CE77F80604/tmp/image_picker_EBE5E019-358B-4582-A6C7-4C8B04491014-22114-00000A86CDE2D16F.jpg';

  // File file;
  // void _choose() async {
  //   // file = await ImagePicker.pickImage(source: ImageSource.camera);
  //   _file = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 5);
  //     setState(() {
  //   });
  //   print(_file);
  // }

  void _sendData(File _image) async {
    var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));
    print(_image.path);
    var length = await _image.length();
    var uri = Uri.parse("https://sam-app.vitecdevelopment.com/api/changeUserInfo");
    var request = new http.MultipartRequest("POST", uri);
    request.fields["fullName"] = "qgFqMn98ES0pWR2F++polqGmasDyODc9gV5hF24amzs=";
    request.headers['Authorization'] = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5MWU5MGVjZS1mYjE4LTQ4NzItOGI2ZS1iMGM5OTc5MDAzNzEiLCJqdGkiOiI3NGMyNTI1NThiZmEyZmIxMDAxMzk2YmQzNzNlNTBiNmNlM2VhZjdiYzMxZjcwNTA2MGQ4YTg3MDJjZjBlNzQ1NWJiOGM3NjJiOTVhZjk3YyIsImlhdCI6MTYwOTMxNzA5MiwibmJmIjoxNjA5MzE3MDkyLCJleHAiOjE2NDA4NTMwOTIsInN1YiI6IjIwNCIsInNjb3BlcyI6W119.of8MkSDyh029-4RNe3wCeg3wDqtVnZzFgv3M7HMmDoZO4bEOo2rjd_iw1hEf_Pcb5zv7O--llsq9AXgm36sq0j7WO_rkkN7TmKYmVwouwzgdGmE00At44B0pkbDk7KoSiQkECGrsR8e6AQkyNBLveoDiAEG-xtdgTWD-Z0xJ3iJEpgVCBNw6skZjN4HuOSIjK8W-ARBnPESnSOzehsO5OeZDEihIV4pXx6bX81yRTdhoRnaRhlWisn0SXpaKOnVCK-9oRePNktz8RttfwwU65WQA2TYrIS5wzcnnX1mLN_2d3tUH64DIBd1KhDhfkmuNZA1crqb-fdmpZfWzoRjc7_y4NINvlumGCHzDg_wBVHtnF5K6Of6EdZn1ZUiop3zRTTfYwqgXHOijHqAtWLddHPyeqvoYiqsbWLH5_0OPHbZ85sOULMYxtkR-9IM4mC95X0IjuKIJJ6vwRcNIe5e1cVxMW4RQHDcz86vkHpy2IjmD9DCDuC01arCAYt4CMAFFP9FyryrX2_14z1kOYfxiRAtOHUbbRc9cJIIraUiqqXe9K4X449Edf_0pstFi7G13O3cuCaXQnh495yJLKiVvuBIfp_yC_TecJFWFrClSSIwEJTTGCdFp2X1wsp5DJaLJOv0Idqd8a2Lw0mb8OwfzVk61OfbQzjfYcSLWHH6B-5Y";
    var multipartFile = new http.MultipartFile('avatar', stream, length, filename: basename(_image.path));
    request.files.add(multipartFile);
    await request.send().then((response) async {
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _lastCropped = File(path);
    });
  }


  final cropKey = GlobalKey<CropState>();
  File _file;
  File _sample;
  File _lastCropped;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap:(){
                setState(() {
                  _openImage(context);
                });
              },
              child: Container(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: FileImage(_lastCropped??File(path)),
                  )
              ),
            ),
            Container(margin: const EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
              child: TextFormField(
                controller: _controller,
                minLines: 1,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    )
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25)
              ),
              child: FlatButton(
                color: Colors.blue,
                minWidth: MediaQuery.of(context).size.width * 0.45,
                onPressed: (){
                  // getUploading();
                  _sendData(_lastCropped);
                  // postData();
                },
                child: Text('Chang Profile'),
              ),
            )
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
    _lastCropped?.delete();
  }

  Widget _buildOpeningImage(context) {
    return Center(child: _buildOpenImage(context));
  }

  Widget _buildCroppingImage(context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(_sample, key: cropKey),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'Crop Image',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white),
                ),
                onPressed: () {
                  _cropImage();
                  Navigator.of(context, rootNavigator: true).pop();
                },
              ),
              _buildOpenImage(context),
            ],
          ),
        )
      ],
    );
  }

  Future<dynamic> _showDiaLog(context){
    return showDialog(
      context: context,
      builder: (_){
        return Container(
            height: MediaQuery.of(context).size.height /4,
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: _sample == null ? _buildOpeningImage(context) : _buildCroppingImage(context),

        );
      },
    );
  }

  Widget _buildOpenImage(context) {
    return FlatButton(
      child: Text(
        'Open Image',
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
      ),
      onPressed: () => _openImage(context),
    );
  }

  Future<void> _openImage(BuildContext context) async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size.longestSide.truncate(),
    );
    if(file!=null){
      _showDiaLog(context);
    }
    _sample?.delete();
    _file?.delete();

    setState(() {
      _sample = sample;
      _file = file;
    });
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      return;
    }
    final sample = await ImageCrop.sampleImage(
      file: _file,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    _lastCropped?.delete();
    setState(() {
      _lastCropped = file;
    });

    debugPrint('$file');
  }

}