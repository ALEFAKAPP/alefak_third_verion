const heightInputFiled = 50.0;
const kDefaultPaddin = 8.0;
stringOrInt(var1) {
  return var1 is String ? int.parse(var1) : var1;
}

stringOrDouble(var1) {
  return var1 is String ? double.parse(var1) : doubleOrInt(var1);
}

doubleOrInt(var1) {
  if (var1 is int) {
    return double.parse('$var1');
  }
  if (var1 is String) {
    return double.parse(var1);
  } else {
    return var1;
  }
}

String getLocation(String strVal, String subVal, endstr) {
  final startIndex = strVal.indexOf(subVal);
  final endIndex = strVal.indexOf(endstr, startIndex + subVal.length);

  return strVal.substring(startIndex + subVal.length, endIndex);
}
