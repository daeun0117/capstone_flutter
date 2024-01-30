import 'package:capstone_flutter/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccessMyLocation extends StatelessWidget {
  const AccessMyLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertDialog(
        backgroundColor: Colors.white.withOpacity(0.7),
        title: Text('사용자의 위치를 사용하도록 허용하겠습니까?'),
        content: Text('지도를 사용해서 주변에 있는 식당 장소를 볼 수 있어요!'),
        actions: [
          TextButton(
              onPressed: () {},
              child: Text(
                '한 번 허용',
                style: TextStyle(
                  color: const Color(0xFF007AFF),
                  fontWeight: FontWeight.w400,
                ),
              )),
          Consumer<MapProvider>(
            builder: (context, mapProvider, child) {
              return TextButton(
                onPressed: () {
                  mapProvider.getLocation();
                  Navigator.pushNamed(context, '/login_success');
                },
                child: Text(
                  '앱을 사용하는 동안 허용',
                  style: TextStyle(
                    color: const Color(0xFF007AFF),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            },
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                '허용 안 함',
                style: TextStyle(
                  color: const Color(0xFF007AFF),
                  fontWeight: FontWeight.w400,
                ),
              ))
        ],
      ),
    );
  }
}
