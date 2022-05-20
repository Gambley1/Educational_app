import 'package:http/http.dart' as http;

class StaticValues {
  const StaticValues._();

  //http client
  static var client = http.Client();

  //host
  static String host = "http://ec2-54-160-132-38.compute-1.amazonaws.com:5000";
}
