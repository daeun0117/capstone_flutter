import 'package:capstone_flutter/provider/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: Stack(
          children: [
            Consumer<MapProvider>(
              builder: (context, mapProvider, child) {
                return NaverMap(
                  options: NaverMapViewOptions(
                    initialCameraPosition: NCameraPosition(
                      target: NLatLng(mapProvider.lat!, mapProvider.lng!),
                      zoom: 17,
                      bearing: 0,
                      tilt: 0,
                    ),
                  ),
                  onMapReady: (controller) {
                    print("네이버 맵 로딩됨!");
                  },
                );
              },
            ),
            Positioned(
              bottom: 20,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                        width: 2, color: Colors.black.withOpacity(0.3))),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/store_list');
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.list,
                        color: Color(0xFFBB0000),
                      ),
                      Text(
                        "목록보기",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 20,
                right: 10,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: 2, color: Colors.black.withOpacity(0.3))),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: (Icon(
                      Icons.my_location_outlined,
                      size: 30,
                      color: Colors.black.withOpacity(0.6),
                    )),
                  ),
                )),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                width: 360,
                height: 44,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      width: 2,
                      color: Colors.black.withOpacity(0.3),
                    )),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFFBB0000),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("남구 무거동 578-20")
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
