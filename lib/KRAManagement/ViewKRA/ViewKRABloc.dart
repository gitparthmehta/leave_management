import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

import 'ViewKRARepository.dart';
import 'ViewKRAResponse.dart';


class ViewKRABloc {
  final ViewKRARepository _repository = ViewKRARepository();
  final BehaviorSubject<ApiResponse<ViewKRAResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<ViewKRAResponse>>();

  executeLeaveList(CommonRequest request) {
    _repository.executeViewKRA(request, _subjectLogin);
  }

  BehaviorSubject<ApiResponse<ViewKRAResponse>> get subject => _subjectLogin;

  disposeLoginSubject() {
    _subjectLogin.close();
  }
}

