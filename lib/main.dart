//main.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:import_pay/payment_screen.dart' as ps;
import 'package:import_pay/payment_screen.dart';
import 'package:import_pay/product.dart' as prod;
import 'package:import_pay/product.dart';
import 'package:import_pay/result_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '사랑둥이',
      initialRoute: '/', // 앱 시작 시 로드할 첫 번째 라우트를 지정합니다.
      routes: {
        '/': (context) => MainScreen(), // 메인 화면 라우트입니다.
        '/result': (context) => ResultScreen(), // 결제 결과 화면 라우트입니다.
      },
    );
  }
}

List<Product> products = [
  Product(name: '1', imageAsset: 'assets/images/product_0.jpg', price: 10000),
  Product(name: '2', imageAsset: 'assets/images/product_1.jpg', price: 20000),
  Product(name: '3', imageAsset: 'assets/images/product_2.jpg', price: 30000),
  Product(name: '4', imageAsset: 'assets/images/product_3.jpg', price: 40000),
  Product(name: '5', imageAsset: 'assets/images/product_4.jpg', price: 50000),
  Product(name: '6', imageAsset: 'assets/images/product_5.jpg', price: 60000),
];

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('사랑둥이'),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2개씩 배치
          crossAxisSpacing: 10, // 가로 간격
          mainAxisSpacing: 10, // 세로 간격
          childAspectRatio: 0.6, // 아이템의 가로/세로 비율
        ),
        itemCount: products.length, // 제품의 수만큼 아이템을 생성합니다.
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(product: products[index]),
                ),
              );
            },// 제품을 탭하면 결제 화면으로 이동합니다.
            child: Column(
              //제품의 이미지와 이름을 보여줍니다.
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/product_$index.jpg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(height: 5), // 간격
                Text('둥이 $index'),
                Text('${(index + 1) * 100}배 귀여움'),
              ],
            ),
          );
        },
      ),
    );
  }
}
