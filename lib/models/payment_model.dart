class PaymentModel {
  final String name;
  final String code;
  final String image;

  PaymentModel({
    required this.name,
    required this.code,
    required this.image,
  });
}

List<PaymentModel> payments = [
  PaymentModel(
    name: "Bank BCA",
    code: 'bca',
    image: "assets/images/logo_bca.png",
  ),
  PaymentModel(
    name: "Bank Mandiri",
    code: 'mandiri',
    image: "assets/images/logo_mandiri.png",
  ),
  PaymentModel(
    name: "Gopay",
    code: 'gopay',
    image: "assets/images/logo_gopay.png",
  ),
];
