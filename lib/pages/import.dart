import 'package:ai_final/pages/gpt.dart';
import 'package:ai_final/pages/show.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'home.dart';

class Import extends StatefulWidget {
  const Import({super.key});

  @override
  State<Import> createState() => _ImportState();
}

class _ImportState extends State<Import> {
  String? selectedFilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _openFilePicker(context);
          },
          child: Text('파일 선택'),
        ),
      ),
    );
  }

  Future<void> _openFilePicker(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );
    if (result != null) {
      // 파일 선택 로직 수행
      PlatformFile file = result.files.first;
      print('선택한 파일 경로: ${file.path}');
      //여기서부터 추가 
      setState(() {
        selectedFilePath = file.path;
      });
      _readFileContents(file);
    } else {
      // 파일 선택이 취소되었을 때 처리할 로직 수행
      print('파일 선택이 취소되었습니다.');
      //여기는 file을 취소했을 시 입력하는 page로 돌아가도록 수정 !!!!!!!!!!!!!!!!
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    }
  }
  Future<void> _readFileContents(PlatformFile file) async {
    try {
      File selectedFile = File(file.path!);
      String fileContents = await selectedFile.readAsString();
      // _openFileInAnotherScreen(fileContents);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GptPage(txt: fileContents),
          // settings: RouteSettings(
          //   arguments: fileContents, // 전달할 문자열 변수
          // ),
        ),
      );
    } catch (e) {
      print('파일을 읽는 도중 오류가 발생했습니다: $e');
    }
  }

  // void _openFileInAnotherScreen(String fileContents) {
  //   // 파일 내용을 다른 화면으로 전달하여 열리도록 하는 로직
  //   // 예시로 콘솔에 파일 내용을 출력하는 것으로 대체했습니다.
  //   print('파일 내용: $fileContents');
  // }
}
