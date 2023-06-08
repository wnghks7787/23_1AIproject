import 'package:ai_final/pages/gpt.dart';
import 'package:ai_final/pages/import.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import "dart:convert";

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

String _generatedText = "";

class _HomeState extends State<Home> {
  final wordPair = WordPair.random();

  Future<String> ChatResponse(String message) async {
    
    // setState(() {
    //   _isWaiting = true;
    // });

    String apiKey = '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';
    String model = 'text-davinci-003';

    // String model = 'gpt-3.5-turbo';
    // String prompt = "If you find something wrong in my sentence, please return right answer";

    var response = await http.post(
      Uri.parse('https://api.openai.com/v1/engines/$model/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'prompt': '이 단어의 한국어 뜻을 알려줘. 단어장에 적을 거니까 사전처럼 품사를 포함해 한 단어, 혹은 두 단어 정도로 알려줘. $message',
        'max_tokens': 1000,
        'temperature': 0.5,
        'n': 1,
        // 'stop': '.'
      })
    );

    if(response.statusCode == 200) {
      // var data = jsonDecode(response.body);
      var data = jsonDecode(utf8.decode(response.bodyBytes));
      setState(() {
        _generatedText = data['choices'][0]['text'];
        _generatedText = _generatedText.replaceAll('\n', '');
      });
    }
    else {
      setState(() {
        _generatedText = "Error: ${response.reasonPhrase}";
      });
    }

    // setState(() {
    //   _isWaiting = false;
    // });
    print(_generatedText);
    return _generatedText;
  }

  @override
  void initState() {
    super.initState();
    ChatResponse(wordPair.first);
  }

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
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 74,
          ),
          Container(
            padding: EdgeInsets.only(top: 16, bottom: 16),
            width: 300, // Container의 너비 설정
            height: 220, // Container의 높이 설정
            decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), //모서리를 둥글게
            border: Border.all(color: Colors.black12, width: 1)), //테두리
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    '오늘의 단어',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Divider(
                  color: Color(0xFFCFD2D9),
                ),
                SizedBox(
                  height: 15
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      wordPair.first,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 13),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      _generatedText,
                      style: TextStyle(fontSize: 18, color: Color(0xFF8F8F8F)),
                    )
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 55
              ),
              Expanded(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xFFF3F4F5))
                  ),
                  onPressed: () {
                    // 한국어 버튼을 눌렀을 때의 동작
                    // 여기에 원하는 동작을 추가하세요.
                  },
                  child: Text('한국어', style: TextStyle(color: Color(0xFF9FA5B2)),),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    // 영어 버튼을 눌렀을 때의 동작
                    // 여기에 원하는 동작을 추가하세요.
                  },
                  child: Text('English'),
                ),
              ),
              SizedBox(
                width: 55
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
