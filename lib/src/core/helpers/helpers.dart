
class Helper {

  static String getValidation(){
    return '';
  }

  static String capitalize(String text, [bool lower = true]) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() +
        (lower ? text.substring(1).toLowerCase() : text.substring(1));
  }

  static String upper(String text, [bool lower = true]) {
    if (text.isEmpty) return text;
    return text.toUpperCase();
  }

}