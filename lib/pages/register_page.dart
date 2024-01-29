import 'package:capstone_flutter/service/api_client.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();

  final ApiClient _apiClient = ApiClient();

  bool _showPassword = true;

  Future<void> registerUsers() async {
    Map<String, dynamic> userData = {
      "loginId": idController.text,
      "password": passwordController.text,
      "email": emailController.text,
      "nickname": nicknameController.text,
    };

    dynamic res = await _apiClient.registerUser(userData);

    if (res['isSuccess'] == true) {
      print(res);
      Navigator.pushNamed(context, '/login');
    } else {
      print(res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입 페이지'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "회원가입",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            emailFormField(),
            const SizedBox(
              height: 20,
            ),
            idFormField(),
            const SizedBox(
              height: 20,
            ),
            nicknameFormField(),
            const SizedBox(
              height: 20,
            ),
            passwordFormField(),
            const SizedBox(
              height: 20,
            ),
            registerButton(),
          ],
        ),
      ),
    );
  }

  Widget emailFormField() {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Email",
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget idFormField() {
    return TextFormField(
      controller: idController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: "id",
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget nicknameFormField() {
    return TextFormField(
      controller: nicknameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'nickname',
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget passwordFormField() {
    return TextFormField(
      obscureText: _showPassword, // 비밀번호를 가릴지 말지
      controller: passwordController,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        hintText: "Password",
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
          child: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
        ),
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget registerButton() {
    return ElevatedButton(
      onPressed: registerUsers,
      child: const Text(
        "Register",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
