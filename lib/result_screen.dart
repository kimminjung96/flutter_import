//result_screen.dart

import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ModalRoute를 사용하여 이전 화면에서 전달된 결과 데이터(arguments)를 받아옵니다.
    final Map<String, String> result =
    ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    // 초기 메시지 값을 설정합니다. 이 후 조건문을 통해 변경될 수 있습니다.
    String message;
    // 결제 결과에 따라 표시할 메시지를 결정합니다.
    // 결과 데이터의 'status' 값이 'success'인 경우와 아닌 경우에 따라 메시지를 설정합니다.
    if (result['status'] == 'success') {
      message = '구매가 성공적으로 완료되었습니다.';
    } else {
      message = '구매에 실패했습니다.';
    }

    // Scaffold 위젯을 반환하여 UI를 구성합니다.
    return Scaffold(
      appBar: AppBar(
        title: Text('결제 결과'),
      ),
      body: Center(
        child: Text(
          message,// 위에서 설정한 메시지를 표시합니다.
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
