import 'package:dio/dio.dart';

var options = BaseOptions(
  baseUrl: "http://192.168.50.1/"
);

var dio = Dio(options);