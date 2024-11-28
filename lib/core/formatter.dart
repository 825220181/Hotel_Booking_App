import 'package:intl/intl.dart';

String formatCurrencyFlexible(double amount) {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: amount % 1 == 0 ? 0 : 2,
  );
  return formatter.format(amount);
}
