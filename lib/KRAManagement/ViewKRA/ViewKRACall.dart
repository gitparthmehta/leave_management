import 'package:dio/dio.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/KRAManagement/ViewKRA/ViewKRAResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Login/DataFetchCall.dart';
import 'package:rxdart/subjects.dart';

import 'ViewKRAApiService.dart';


class ViewKRACall extends DataFetchCall<ViewKRAResponse> {
  CommonRequest  _request;
  ViewKRACall(CommonRequest  request,
      BehaviorSubject<ApiResponse<ViewKRAResponse>> responseSubject)
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
    return apiServiceInstance.ViewKRA(_request);
  }

  /// called when API Response is Success
  @override
  void onSuccess(ViewKRAResponse response) {}

  /// called when API Response is success and need to parse JsonData to Model
  @override
  ViewKRAResponse parseJson(Response response) {
    return ViewKRAResponse.fromJson(response.data);
  }
}
