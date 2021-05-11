import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Login/NetworkUtil.dart';

import 'AllListRequest.dart';

class AllListApiService {
  NetworkUtil  networkUtil = NetworkUtil();

  Future<Response> alllist(AllListRequest ListRequest) {
    return networkUtil.post(ApiConstants.ALL_LIST, ListRequest.toMap());
  }

}

///Single final Object of API Service
final apiServiceInstance =  AllListApiService();
