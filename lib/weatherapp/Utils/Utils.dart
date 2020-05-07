import 'package:intl/intl.dart';

class Utils{
  static String APPID = "bc3a34c4287db30897a40b9a3837ba20";
  static String getDate(DateTime dateTime){
    return new DateFormat("EEEE, MMM d, y").format(dateTime);
  }
}