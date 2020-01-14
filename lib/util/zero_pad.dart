class ZeroPad {
  static String parse(int val) {
    if (val < 10) {
      return "0$val";
    }
    return val.toString();
  }
}