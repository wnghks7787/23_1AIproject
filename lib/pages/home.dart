import 'package:ai_final/pages/gpt.dart';
import 'package:ai_final/pages/import.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? englishWord;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: Image.asset("assets/logo.png"), // 앱 로고 이미지 경로
        ),
        body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            width: 300, // Container의 너비 설정
            height: 150, // Container의 높이 설정
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), //모서리를 둥글게
            border: Border.all(color: Colors.black12, width: 3)), //테두리
            child: Column(
              children: [
                Text(
                  '오늘의 단어',
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(8),
                  color: Colors.grey[200],
                  child: Text(
                    'English Word',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // 한국어 버튼을 눌렀을 때의 동작
                  // 여기에 원하는 동작을 추가하세요.
                },
                child: Text('한국어'),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // 영어 버튼을 눌렀을 때의 동작
                  // 여기에 원하는 동작을 추가하세요.
                },
                child: Text('English'),
              ),
            ],
          ),
        ],
      ),
        // body: Center(
        //   child: Container(
        //     width: 300, // Container의 너비 설정
        //     height: 150, // Container의 높이 설정
        //     decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(50), //모서리를 둥글게
        //     border: Border.all(color: Colors.black12, width: 3)), //테두리
        //     child: Column(
        //       // mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Text(
        //           '오늘의 단어',
        //           style: TextStyle(fontSize: 24),
        //         ),
        //         SizedBox(height: 8), // 한 줄 띄우기
        //         Text(
        //           //여기서 chatGPT한테 영어단어를 입력받고 영어단어와 한국어 뜻을 보여줌 
        //           '영어 단어',
        //           style: TextStyle(fontSize: 18),
        //         ),
        //     ],)
        //   ),

        // ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // Write 버튼 클릭 시 동작
                  //상현 오빠가 구현한 페이지로 넘어가도록 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GptPage()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.import_export),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Import()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
