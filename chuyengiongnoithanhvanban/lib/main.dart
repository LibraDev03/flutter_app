import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart'as stt ;
import 'package:avatar_glow/avatar_glow.dart';
//import 2 thư viện

void main() { //hàm chính để chạy ứng dụng
  runApp(MyApp());
}
class MyApp extends StatelessWidget { //widget k trạng thái
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BTL3 Flutter của sơn',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home:SpeechScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SpeechScreen extends StatefulWidget { //định nghĩa lớp có trạng thái
  @override
  _SpeechScreenState createState() => _SpeechScreenState(); //tạo trạng thái
}

class _SpeechScreenState extends State<SpeechScreen> {
  late stt.SpeechToText _speech ; //khởi tọa đối tượng
  bool _isListening = false; //biến này kiểm tra trạng thái lắng nghe
  String _textSpeech = 'Press the microphone'; //văn bản hiển thị khi chưa có giọng nói

  void onListen() async { // hàm không đồng bộ bắt dầu hoặc dừng nghe giọng nói
    if(!_isListening) {    // bắt đầu kiểm tra trạng thai lắng nghe
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) =>('onError : $val')
      );
      if(available) { // bắt đầu lắng nghe
        setState(() {
          _isListening= true;
        });
        _speech.listen( //bắt đầu nghe giọng nói
          onResult: (val) => setState(() { //khi có kết quả thì nhận dạng và cập nhật văn bản
            _textSpeech = val.recognizedWords;
          })
        );
      }
    }else{
      setState(() { //dừng lại việc lắng nghe
        _isListening = false;
        _speech.stop();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speech =stt.SpeechToText() ;
  }
  // xây dựng giao diện
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Center(child:
      Container(
          child: Text('SPEECH TO TEXT' , style: TextStyle(fontSize: 30,color: Colors.deepPurpleAccent),)))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked, //vị trí của nút chuyển đổi
      floatingActionButton: AvatarGlow( //hiệu ứng của nút chuyển đổi
        animate: _isListening, //sáng khi nghe
        glowColor: Theme.of(context).primaryColor, //màu khi nghe
        duration: Duration(milliseconds: 2000), //thời gian khi nghe
        repeat: true, //lặp lại hiệu ứng
        child:FloatingActionButton( //nút hành dộng
          onPressed:() => onListen(), //ấn nút
          child:Icon(_isListening ? Icons.mic : Icons.mic_none), //icon
        ),
      ),
      body: SingleChildScrollView( // cuộn lại nội dung
        reverse: true ,
        child: Container(
          padding: EdgeInsets.fromLTRB(30, 30, 30, 150),
          child: Text(
              _textSpeech, //nhận văn abnr từ giọng nói
            style: TextStyle(
              fontSize: 32,
              color: Colors.deepPurpleAccent,
              fontWeight : FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}