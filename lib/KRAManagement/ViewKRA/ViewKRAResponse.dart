import 'package:flutter_app/KRAManagement/ViewKRA/ViewKRAModel.dart';
import 'package:flutter_app/Login/GeneralResponse.dart';

class   ViewKRAResponse extends GeneralResponse {
  ViewKRAModel Result;

  ViewKRAResponse.fromJson(Map<String, dynamic> json)
      : Result = ViewKRAModel.fromJson(json),
        super.fromJson(json);
}
