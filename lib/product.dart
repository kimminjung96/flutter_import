//product.dart

class Product {
  final String name;
  final String imageAsset;
  final int price;

  Product({required this.name, required this.imageAsset, required this.price});
}

//Product 클래스에는 생성자가 포함되어 있으며,
// 이 생성자를 통해 각 필드(즉, name, imageAsset, price)의 값을 초기화합니다.
// 생성자에서 required 키워드는 해당 인자가 필수적으로 전달되어야 함을 나타냅니다.