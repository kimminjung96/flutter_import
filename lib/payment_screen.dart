// payment_screen.dart

import 'package:flutter/material.dart';
import 'package:iamport_flutter/iamport_payment.dart';
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:import_pay/product.dart';

// StatelessWidget을 상속받아 PaymentScreen 위젯을 정의합니다.
class PaymentScreen extends StatelessWidget {
  final Product product; // 선택된 제품을 저장하는 변수입니다.

  // 생성자: PaymentScreen 위젯이 생성될 때 선택된 제품을 받아옵니다.
  PaymentScreen({required this.product}); // 생성자를 통해 선택된 제품을 전달받습니다.
  void _test() {
    print('aklsdfjlkasdjflkajsdfl $product');
  }


  // 결제 결과에 따라 다음 화면으로 이동하거나 메시지를 표시하는 콜백 함수입니다.
  void _onPaymentResult(Map<String, String> result, BuildContext context) {
    // print("haha/////////////////$result");
    Navigator.pushReplacementNamed(
      context,
      '/result',
      arguments: result,
    );
  }

  // 구매 버튼이 눌렸을 때의 결제 로직을 처리하는 함수입니다.
  void _onPaymentButtonPressed( String pg, String payMethod, BuildContext context) async {
    // [필수입력] 결제 데이터 설정
    var paymentData = PaymentData(
      // pg: 'html5_inicis',
      pg: pg,  // 이 부분에 PG사 값을 지정합니다.
      // payMethod: 'card',
      payMethod: 'kakaopay', // 이 부분에 결제 방식을 지정합니다.
      name: product.name,
      merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',
      amount: product.price,
      buyerName: '홍길동',
      buyerTel: '01012345678',
      buyerEmail: 'example@naver.com',
      buyerAddr: '서울시 강남구 신사동 661-16',
      buyerPostcode: '06018',
      appScheme: 'example',
      cardQuota: [2, 3],
    );

    // 결제 요청 보내기 // 아임포트 결제 페이지를 열고, 결제 결과를 가져옵니다.
    Map<String, String>? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IamportPayment(
          appBar: AppBar(
            title: Text('아임포트 결제'),
          ),
          initialChild: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/iamport-logo.png'),
                  Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  Text(
                    '잠시만 기다려주세요...',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
          userCode: 'iamport',
          data: paymentData,
          callback: (Map<String, String> result) {
            print(result);
            _onPaymentResult(result, context); // 결제 완료 후 결과를 전달받아 화면을 전환
          },
        ),
      ),
    );

    // 결제 결과를 기반으로 로직을 처리합니다.
    if (result != null) {
      // 결제가 완료된 경우
      if (result['status'] == 'success') {
        // 결제 성공 처리 로직 추가
      } else {
        // 결제 실패 처리 로직 추가
      }
    } else {
      // 결제가 취소된 경우
      // 취소 처리 로직 추가
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: Padding(
        // <-- 전체 body에 패딩을 추가합니다.
        padding: EdgeInsets.all(20), // <-- 전체적으로 20픽셀의 패딩을 적용합니다.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // 가운데 정렬이 아닌 시작점으로 정렬
          children: [
            Container(
              height: 350, // <-- 높이를 350픽셀로 설정합니다.
              width: double.infinity, // <-- 가능한 최대 너비로 설정합니다.
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(product.imageAsset),
                fit: BoxFit.cover, // <-- 이미지가 컨테이너 크기에 꽉 차게 표시합니다.
              )),
            ),
            SizedBox(height: 20),
            Text(product.name, style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Text('\₩${product.price}',
                style: TextStyle(fontSize: 20, color: Colors.purple)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _onPaymentButtonPressed('inicis', 'kakao', context); // 이니시스 PG의 카카오페이로 결제
              },
              child: Text('카카오페이로 구매하기'),
            ),
            ElevatedButton(
              onPressed: () {
                _onPaymentButtonPressed('naverco', 'naver', context); // 네이버 PG의 네이버페이로 결제
              },
              child: Text('네이버페이로 구매하기'),
            ),
            ElevatedButton(
              onPressed: () {
                _test();
                // _onPaymentButtonPressed('inicis', 'card', context); // 이니시스 PG의 카드로 결제
              },
              child: Text('카드로 구매하기'),
            ),
          ],
        ),
      ),
    );
  }
}
