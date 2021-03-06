import 'package:dio/dio.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:flutter_app/Task/AllList/AllListResponse.dart';
import 'package:rxdart/subjects.dart';

import 'AllListApiService.dart';
import 'AllListRequest.dart';


class AllListCall extends DataFetchCall<AllListResponse> {
  AllListRequest  _request;
  AllListCall(AllListRequest  request,
      BehaviorSubject<ApiResponse<AllListResponse>> responseSubject)
      : super(responseSubject) {
    this._request = request;
  }

  /// if return false then createApiAsyc is called
  /// if return true then loadFromDB Function  is called
  @override
  bool shouldFetchFromDB() {
    return false;
  }

  /// called when shouldFetchfromDB() is returning true
  @override
  void loadFromDB() {
    ///  get data from DB todo post/sinc on behaviourSubject after
  }

  /// called when shouldFetchfromDB() is returning false

  @override
  Future<Response> createApiAsync() {
    /// need to return APIService async task for API request
    return apiServiceInstance.alllist(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(AllListResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  AllListResponse parseJson(Response response) {
    return AllListResponse.fromJson(response.data);
  }
}
