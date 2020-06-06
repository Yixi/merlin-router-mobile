import 'package:dio/dio.dart';

var options = BaseOptions(
  baseUrl: "http://192.168.50.7:4000/",
//  connectTimeout: 5000
);

var dio = Dio(options);