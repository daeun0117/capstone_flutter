import 'package:capstone_flutter/pages/login_pages/login_success_page.dart';
import 'package:flutter/material.dart';

class StoreListPage extends StatelessWidget {
  const StoreListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.black,
          ),
          const LoginSuccessPage()
        ],
      ),
    );
  }
}
