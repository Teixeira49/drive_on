
class Helper {

  static String getValidation(){
    return '';
  }

  static String capitalize(String text, [bool lower = true]) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() +
        (lower ? text.substring(1).toLowerCase() : text.substring(1));
  }

  static String upper(String text) {
    if (text.isEmpty) return text;
    return text.toUpperCase();
  }

  static double checkDouble(var data) {
    if (data is int) return double.parse('$data');
    return data;
  }

  static List<String> extractDate(String date) {
    return date.split(', ');
  }

  static String fixMoney(double amount) {
    if (amount < 0){
      return '-\$${amount.toStringAsFixed(2).substring(1)}';
    }
    return '\$${amount.toStringAsFixed(2)}';
  }
}