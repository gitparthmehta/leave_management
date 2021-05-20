import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';


class ViewKRAApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response>ViewKRA(CommonRequest ListRequest) {
    return networkUtil.post(ApiConstants.VIEW_KRA, ListRequest.toMap());
  }
}
///Single final Object of API Service
final apiServiceInstance = ViewKRAApiService();
