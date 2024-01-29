import 'package:capstone_flutter/components/define_color.dart';
import 'package:capstone_flutter/mvvm/token_view_model.dart';
import 'package:capstone_flutter/service/api_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isChecked = false;

  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ApiClient _apiClient = ApiClient();

  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    TokenViewModel tokenViewModel =
        Provider.of<TokenViewModel>(context, listen: false);

    Future<void> login() async {
      dynamic res = await _apiClient.login(
        idController.text,
        passwordController.text,
      );
      print(res);

      //id와 password를 입력하지 않은 경우 로그인 않되도록 함.
      if (idController.text.isEmpty || passwordController.text.isEmpty) {
        print('ID 또는 비밀번호가 비어있습니다.');
        return null;
      }

      if (res['isSuccess'] == true) {
        tokenViewModel.updateAccessToken(res['data']['accessToken']);
        tokenViewModel.updateRefreshToken(res['data']['refreshToken']);
        Navigator.pushNamed(context, '/access_my-location');
        //print(res);
        //print(tokenViewModel.accessToken);
        //accessLocationDialog()
      } else {
        print(res);
      }
    }

    return Scaffold(
        appBar: AppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 140,
            ),
            const Center(
              child: Text(
                'ㅈㄸㅇ',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: idTextFormField(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: passwordTextFormField(),
            ),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool) {
                    setState(() {
                      isChecked = !isChecked;
                    });
                  },
                ),
                const Text(
                  "아이디 저장",
                ),
                const SizedBox(
                  width: 100,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/find_id_password');
                    },
                    child: Text(
                      "아이디 비밀번호 찾기",
                      style: TextStyle(color: Color(0xFFBB0000)),
                    ))
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: login,
                child: Container(
                  width: 500,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(DefineColor.loginBtnColor),
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: const Center(
                    child: Text(
                      "로그인",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("새로운 계정이 필요하신가요?",
                    style: TextStyle(
                      fontSize: 14,
                      //fontWeight: FontWeight.wSymbol(figma.mixed),
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text("회원가입",
                      style: TextStyle(
                        color: Color(DefineColor.loginBtnColor),
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        decorationColor: Color(DefineColor.loginBtnColor),
                      )),
                ),
              ],
            )
          ],
        ));
  }

  Widget idTextFormField() {
    return TextFormField(
      controller: idController,
      decoration: InputDecoration(
        hintText: "아이디",
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget passwordTextFormField() {
    return TextFormField(
      obscureText: _showPassword,
      controller: passwordController,
      decoration: InputDecoration(
        hintText: "비밀번호",
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                () => _showPassword = !_showPassword;
              });
            },
            child: Icon(
              _showPassword ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            )),
      ),
    );
  }

  /* Future<void> accessLocationDialog(BuildContext context) async{
    showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
              backgroundColor: Colors.white,
              title: Text("위치 허용"),
              content: Text("현재 위치를 허용하겠습니까?"),
              actions: [
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          TextButton(
          onPressed: () {
            login;
          },
          child: Text(
          "예",
          style: TextStyle(
          color: const Color(0xFFBB0000),
          fontWeight: FontWeight.w500,
          ),
          )),
          TextButton(
          onPressed: () {
          Navigator.pushNamed(context, '/login_success');
          },
          child: Text("아니오",
          style: TextStyle(
          color: const Color(0xFFBB0000),
          fontWeight: FontWeight.w500,
          )))
          ],
          ),
          )
            ]
          );
        });
  }*/
}
