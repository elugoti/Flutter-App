import 'package:intl/intl.dart';

class Utils{
  static String APPID = "bc3a34c4287db30897a40b9a3837ba20";
  static String API_KEY = "8369603d4b53191d591fd1fbea4d6a13";
  static String BASE_URL = "https://developers.zomato.com/api/v2.1/";

  static String getDate(DateTime dateTime){
    return new DateFormat("EEEE, MMM d, y").format(dateTime);
  }
}