import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ApiCalling extends StatefulWidget {
  @override
  _ApiCallingState createState() => _ApiCallingState();
}

class _ApiCallingState extends State<ApiCalling> {
  TextEditingController _controller = TextEditingController();
  String path = '/Users/mac/Library/Developer/CoreSimulator/Devices/D72BF767-D638-4CB3-BC9F-02CB2D61663D/data/Containers/Data/Application/672DEDFF-BB7D-4423-98C0-E8C0C3C78FD4/tmp/image_picker_98A4CBD8-8D48-4EC0-98C9-FB0AF46310BB-16493-0000078D90944D61.jpg';

  File file;
  void _choose() async {
    // file = await ImagePicker.pickImage(source: ImageSource.camera);
    file = await ImagePicker.pickImage(source: ImageSource.gallery,imageQuality: 5);
      setState(() {
    });
    print(file);
  }

  void uploadImage1(File _image) async {
    var stream = new http.ByteStream(DelegatingStream.typed(_image.openRead()));
    print(_image.path);
    var length = await _image.length();
    var uri = Uri.parse("https://sam-app.vitecdevelopment.com/api/changeUserInfo");
    var request = new http.MultipartRequest("POST", uri);
    request.fields["fullName"] = "qgFqMn98ES0pWR2F++polqGmasDyODc9gV5hF24amzs=";
    request.headers['Authorization'] = "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5MWU5MGVjZS1mYjE4LTQ4NzItOGI2ZS1iMGM5OTc5MDAzNzEiLCJqdGkiOiIwNTM2N2UxOTc4MjU2MmQzOGZkNTM5ZjNkN2VmYmI4NWQ2Y2RhMDk5NTNhNjg3OTA1MjZiNWQ3MGU2MmM4NjcxNzdkNTM3MGU3MDYzOWQyOCIsImlhdCI6MTYwOTMwOTMwNywibmJmIjoxNjA5MzA5MzA3LCJleHAiOjE2NDA4NDUzMDcsInN1YiI6IjIwNCIsInNjb3BlcyI6W119.fP0_Nm8d58W3TVUHlpqPphgb1u96a8FUVTKepcmbvuG8L8gPwpzSJyOECCrTFDrk1-HZaBYcu3GwHGQt-EXrqpqASmSi8wNV0NvNyfBY0wetACHPltjTkKzh9pUzX-wCAQvX3hf1fGYOsj5bCgHcA4BPtGItHHmPK7G1z5CUg0vSy8uLRx3hkIJx3zsT5GMg-KE-80t2ps69pJmgdQBz0B0Jd3GqeEC45AHYJ5zkF65Koa2fSBy5sAs5NwWvsYKGl_GyvfabuR3FiCbqbqeLfdJ8QEI8oSfuzNZBXiZXq-mAySse05yuuCDolM7fggXxj_Lit31DQOe4lw7RnRKyqkLls-LhkI29hnL51wYrbzAK1L-owDEisHdkBfgzKKyOJBAo3_OgKd5spweq_VX2WCWouERYVXqbDzIv_tJGlvchahqbPoQw5sULpnI3Fx2zZ5duC-CAasVu5sCOXXK6eWYsbg2DPABmfqGwZ6wKLzBAweR0H0nm8jLfONsniXae1rU7wsAAqryM-hF6gnmVf37Jb3bsIyXIuzOStlAxEznVELp7pXYFi0aSaMc8ndPnJwkKzl66pIUy7DpScOHZjFSEYrq687naipJSGPki2OJ1BECuboA3coWQNHcTk7YeCdtNQc4JCajWqGHIM7iR63l5_F0fPPRPwUp9rUMpz6g";
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
      file = File(path);
    });
  }

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
                  _choose();
                });
              },
              child: Container(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: FileImage(file??File(path)),
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
                  uploadImage1(file);
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
}