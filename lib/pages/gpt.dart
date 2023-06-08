import "dart:convert";
import "package:flutter/material.dart";
import "package:http/http.dart" as http;

class GptPage extends StatefulWidget {
  String txt;

  GptPage(
    {
      Key? key,
      this.txt = ''
    }
  ) : super(key : key);

  @override
  State<GptPage> createState() => _GptPageState();
}

String inputValue = "";
String outputValue = "";
String result = "";
String _generatedText = "";

bool _isWaiting = false;

class _GptPageState extends State<GptPage> {

  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.txt);
  }

  Future<void> ChatResponse(String message) async {
    
    setState(() {
      _isWaiting = true;
    });

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
        'prompt': 'If you find something wrong in my sentence, please return right answer. If it is right answer, please return \'you are right!\' If sentence has error, please return just correct message Don\' put anything else. Here is my sentence. $message',
        // 'prompt': '내가 어떤 문장을 넣어줄거야. 너는 이 문장에 오류가 있는지 파악해줘. 만약 문제가 없다면 문제가 없다고 알려주고, 문제가 있다면 문제를 수정해서 다시 나에게 반환해줘. 다음은 내 문장이야. $message',
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
      });
    }
    else {
      setState(() {
        _generatedText = "Error: ${response.reasonPhrase}";
      });
    }

    setState(() {
      _isWaiting = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input text"),
        actions: [],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Input',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              maxLines: 10,
              onChanged: (text) {
                setState(() {
                  inputValue = text;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              outputValue = inputValue;
              ChatResponse(outputValue);
            },
            child: Text("upload"),
          ),
          if(_isWaiting)
            CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(_generatedText),
          ),
        ],
      )
    );
  }
}



