import 'package:dio/dio.dart';
import 'package:inventory_managment/core/network/api_exceptions.dart';
import 'package:inventory_managment/core/network/dio_client.dart';

class ApiService {
  final DioClient _dioClient;
  ApiService(this._dioClient);

  //get
  Future<dynamic> get(String endPoint) async {
    try {
      final response = await _dioClient.dio.get(endPoint);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handlerError(e);
    }
  }

  //post
  Future<dynamic> post(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.post(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handlerError(e);
    }
  }

  //put
  Future<dynamic> put(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.put(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handlerError(e);
    }
  }

  //patch
  Future<dynamic> patch(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.patch(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handlerError(e);
    }
  }

  //delete
  Future<dynamic> delete(String endPoint, Map<String, dynamic> body) async {
    try {
      final response = await _dioClient.dio.delete(endPoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handlerError(e);
    }
  }
}
