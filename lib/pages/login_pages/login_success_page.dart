import 'package:capstone_flutter/mvvm/token_view_model.dart';
import 'package:capstone_flutter/pages/home_pages/home_page.dart';
import 'package:capstone_flutter/pages/my_profile_pages/my_page.dart';
import 'package:capstone_flutter/pages/order_list_pages/order_list_page.dart';
import 'package:capstone_flutter/pages/search_pages/search_page.dart';
import 'package:capstone_flutter/pages/subscribe_pages/subscribe_page.dart';
import 'package:capstone_flutter/service/api_client.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginSuccessPage extends StatefulWidget {
  const LoginSuccessPage({super.key});

  @override
  State<LoginSuccessPage> createState() => _LoginSuccessPageState();
}

class _LoginSuccessPageState extends State<LoginSuccessPage> {
  late TokenViewModel _tokenViewModel;
  int selectIndex = 0;
  final List<Widget> widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    OrderListPage(),
    SubscribePage(),
    MyPage(),
  ];

  Future<void> logoutAction() async {
    final ApiClient _apiClient = ApiClient();

    try {
      dynamic res = await _apiClient.logout(_tokenViewModel.accessToken);

      if (res['isSuccess'] == true) {
        _tokenViewModel.updateAccessToken(''); //기존에 있는 토큰을 삭제한다.
        _tokenViewModel.updateRefreshToken('');
        Navigator.pushNamed(context, '/login');

        //print(res);
        //print(tokenViewModel.accessToken);
      } else {
        print('로그아웃 실패: $res');
      }
    } catch (e) {
      print('로그아웃 중 오류 발생: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tokenViewModel = Provider.of<TokenViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('오늘의 떨이')),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.account_circle_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.home_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: widgetOptions[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectIndex,
        onTap: (value) {
          setState(() {
            selectIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '홈',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined), label: '검색'),
          BottomNavigationBarItem(
              icon: Icon(Icons.receipt_long_rounded), label: '주문내역'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined), label: '구독'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: '마이떨이'),
        ],
      ),
    );
  }

  Future<void> showLogout(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            title: Text("로그아웃"),
            content: Text("로그아웃 하시겠습니까?"),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          logoutAction();
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
            ]);
      },
    );
  }
}
