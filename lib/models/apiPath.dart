class BaseApi {
  static String baseApi = 'http://10.0.2.2:8000/MainApp';
  static String allProduct = '$baseApi/allproduct/';

  Map<String, String> header = {
    'Content-Type': 'Application/json; charset=UTF-0'
  };
}
