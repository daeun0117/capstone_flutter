import 'package:capstone_flutter/mvvm/token_view_model.dart';
import 'package:capstone_flutter/pages/home_pages/store_list_page.dart';
import 'package:capstone_flutter/pages/login_pages/access_my_location.dart';
import 'package:capstone_flutter/pages/login_pages/find_id_password.dart';
import 'package:capstone_flutter/pages/login_pages/login_page.dart';
import 'package:capstone_flutter/pages/login_pages/login_success_page.dart';
import 'package:capstone_flutter/pages/login_pages/start_page.dart';
import 'package:capstone_flutter/pages/register_pages/register_page.dart';
import 'package:capstone_flutter/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(
    clientId: 's6ona84wxe',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => TokenViewModel()),
        ChangeNotifierProvider(create: (BuildContext context) => MapProvider())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFBB0000)),
            useMaterial3: true,
          ),
          home: const StartPage(),
          initialRoute: '/',
          routes: {
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
            '/login_success': (context) => const LoginSuccessPage(),
            '/find_id_password': (context) => const FindIdPassword(),
            '/access_my-location': (context) => const AccessMyLocation(),
            '/store_list': (context) => const StoreListPage(),
          }),
    );
  }
}
