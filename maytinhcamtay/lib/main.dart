import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  // hàm chính để chạy 1 ứng dụng flutter
}

class MyApp extends StatelessWidget { //k thừ 1 lớp không duy trì trạng thái nào
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp( // trả về 1 widget đóng vai trò là gốc cây
      title: 'BTL Flutter của Sơn',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  HomePage(), //đóng vai trò là màn hình chính
      debugShowCheckedModeBanner: false,
    );
  }
}

// thuật toán để làm ứng dụng
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  late int first,second;
  late String opp;
  late String result,text ="";
  void btnClicked(String btnText){ //xử lí khi được nhấn

    if(btnText == "AC"){
      result = "0";
      text = "";
      first = 0;
      second = 0;
    }else if(btnText == "+" || btnText == "-" || btnText == "*" || btnText == "/"){
      first = int.parse(text);
      result = "";
      opp = btnText;
    }else if(btnText == "="){
      second = int.parse(text);
      if(opp == "+"){
        result = (first + second).toString();
      }else if(opp == "-"){
        result = (first - second).toString();
      }else if(opp == "*"){
        result = (first * second).toString();
      }else if(opp == "/"){
        result = (first / second).toString();
      }
    }else{
      result = int.parse(text + btnText).toString();
    }

      setState(() { //thay đổi trang thái và cập nhật lại giao diện người dùng
      text=result;
    });

  }

//làm giao diện
  Widget customOutlineButton(String value) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () => btnClicked(value), //gọi lại hàm khi được nhấn
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          // backgroundColor: Colors.white ,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0)
          ),
            padding: EdgeInsets.all(15)
        ) ,
        child: Text(
          value,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( //1wg cơ bản gồm app3 và body
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container( //hiển thị kết quả của máy tính
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
                child: Container(
                  color: Colors.black,
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.w700,
                      color: Colors.white
                    ),
                  ),
                ),
            ),
            // hiển thị các nút số của máy tính
            Row(
              children: [
                customOutlineButton("AC"),
                customOutlineButton("-/+"),
                customOutlineButton("%"),
                customOutlineButton("/"),
              ],
            ),
            // const SizedBox(height: 10),
            Row(
              children: [
                customOutlineButton("7"),
                customOutlineButton("8"),
                customOutlineButton("9"),
                customOutlineButton("*"),
              ],
            ),
            // const SizedBox(height: 10),
            Row(
              children: [
                customOutlineButton("4"),
                customOutlineButton("5"),
                customOutlineButton("6"),
                customOutlineButton("-"),
              ],
            ),
            // const SizedBox(height: 10),
            Row(
              children: [
                customOutlineButton("1"),
                customOutlineButton("2"),
                customOutlineButton("3"),
                customOutlineButton("+"),
              ],
            ),
            // const SizedBox(height: 10),
            Row(
              children: [
                customOutlineButton("0"),
                customOutlineButton("000"),
                customOutlineButton(","),
                customOutlineButton("="),
              ],
            )
          ]
        ),
      ),
    );
  }

}
