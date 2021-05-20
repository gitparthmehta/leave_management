import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/KRAManagement/ViewKRA/ViewKRAResponse.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'ViewKRACall.dart';



class ViewKRARepository{
  executeViewKRA(CommonRequest request,
      BehaviorSubject<ApiResponse<ViewKRAResponse>> responseSubject) {
    new ViewKRACall(request, responseSubject).execute();
  }

}
