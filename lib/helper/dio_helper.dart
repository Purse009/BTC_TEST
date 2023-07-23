import 'package:btc_test/service/api_path.dart';
import 'package:dio/dio.dart';

class DioHelper {
  final Dio dio = Dio();
  final APIPath baseRepository = APIPath();

  Future<Dio> dioWithHeader() async {
    dio.interceptors.clear();

    dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      baseUrl: baseRepository.baseUrl,
    );

    return dio;
  }
}
