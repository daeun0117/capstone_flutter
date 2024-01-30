import 'package:capstone_flutter/components/define_color.dart';
import 'package:capstone_flutter/service/api_client.dart';
import 'package:flutter/material.dart';

class FindIdPassword extends StatefulWidget {
  const FindIdPassword({super.key});

  @override
  State<FindIdPassword> createState() => _FindIdPasswordState();
}

class _FindIdPasswordState extends State<FindIdPassword> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  final ApiClient _apiClient = ApiClient();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("아이디_비밀번호 찾기"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              '아이디 찾기',
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            emailTextFormField(),
            TextButton(
                onPressed: () {
                  pressedFindId();
                },
                child: Text("아이디 찾기")),
            SizedBox(
              height: 70,
            ),
            Text(
              '비밀번호 변경',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            newEmailTextFormField(),
            SizedBox(
              height: 10,
            ),
            newPasswordTextFormField(),
            TextButton(
                onPressed: () {
                  resetNewPassword();
                },
                child: Text("비밀번호 재설정")),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/login');
                },
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
                      "로그인 하러 가기",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> resetNewPassword() async {
    if (newPasswordController.text != '') {
      dynamic response = await _apiClient.resetPassword(
        newEmailController.text,
        newPasswordController.text,
      );
      print(response);

      if (response['isSuccess'] == true) {
        newPasswordDialog("비밀번호 재설정 완료!");
      } else {
        newPasswordDialog("이메일이 존재하지 않습니다.");
      }
    } else {
      print('값을 넣으세요!');
    }
  }

  Future<void> pressedFindId() async {
    String email = emailController.text;
    /*if (email == null || email.isEmpty) {
      return;
    }*/

    try {
      dynamic response = await _apiClient.findId(email);

      if (response['isSuccess'] == true) {
        String foundId = response['data']['foundLoginId'];
        //print("1번 $foundId");
        findIdDialog("아이디 찾기 성공", "아이디는 $foundId 입니다.");
        //print("4번 $email");
        //print(response);
      } else {
        findIdDialog("아이디 찾기 실패", "존재하지 않는 이메일입니다.");
      }
    } catch (e) {
      print(e);
      findIdDialog("오류", "오류가 발생했습니다.");
    }
  }

  void newPasswordDialog(String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/find_id_password');
                },
                child: Text("확인"),
              ),
            ],
          );
        });
  }

  void findIdDialog(String title, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/find_id_password');
                },
                child: Text("확인"),
              ),
            ],
          );
        });
  }

  Widget emailTextFormField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: "이메일을 입력하시오",
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget newEmailTextFormField() {
    return TextFormField(
      controller: newEmailController,
      decoration: InputDecoration(
        hintText: "이메일을 입력하시오",
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  Widget newPasswordTextFormField() {
    return TextFormField(
      controller: newPasswordController,
      decoration: InputDecoration(
        hintText: "비밀번호 재설정",
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
