import 'package:flutter/material.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/KRAManagement/ViewKRA/ViewKRABloc.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:flutter_app/utilities/TextView.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewKRA/ViewKRAModel.dart';

class ViewKRAScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ViewKRAScreen();
}

class _ViewKRAScreen extends State<ViewKRAScreen> {
  String token = "";
  String user_id = "";
  String employee_name = "";
  ViewKRABloc _viewTaskBloc = ViewKRABloc();
  bool isloading = true;
  bool showlist = false;
  List<ViewKRA> _viewTaskdata = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: Text("View KRA"),
            backgroundColor: Colors.grey[300],
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
              ),
              onPressed: () {
                _onBackPressed();
              },
            ),
          ),
            body: isloading
                ? Center(child: CircularProgressIndicator())
                : Scaffold(
              body: Form(
                child: Stack(
                  children: <Widget>[
                    Container(
                      padding:
                      new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(height: 10.0),
                            TextView(
                              "EMPLOYEE NAME",
                              fontFamily: 'Poppins-SemiBold',
                              fontSize: 14,
                              textAlign: TextAlign.left,
                              textColor: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                            SizedBox(height: 5.0),
                        Container(

                          padding: new EdgeInsets.fromLTRB(
                              5.0, 0.0, 5.0, 0.0),
                          decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: new Border.all(
                              width: 0.5,
                            ),
                          ),
                          child:  TextView(
                            _viewTaskdata[0].employee_name,
                            fontFamily: 'Poppins-SemiBold',
                            fontSize: 13,
                            textAlign: TextAlign.left,
                            textColor: Colors.black,
                            fontWeight: FontWeight.normal,

                          ),
                          height: 35,
                          alignment: Alignment.centerLeft,
                        ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),

        onWillPop: _onBackPressed);
  }

  @override
  void initState() {
    _getPrefValue();
  }
  Future<void> _getPrefValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(ApiConstants.token);
    user_id = prefs.getString(ApiConstants.user_id);

    print("token  :" + token);
    print("userid  :" + user_id);

    _viewTaskBloc
        .executeLeaveList(CommonRequest(user_id, token));
    _viewTaskBloc.subject.listen((value) {
      if (value.data.Result != null) {
        String message = value.data.Result.message;
        if (value.data.Result.status == "0") {
          Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          isloading = false;
          showlist = false;
          _viewTaskdata = value.data.Result.viewkra;
        } else {
          showlist = true;
          _viewTaskdata = value.data.Result.viewkra;

          print("viewkra" + _viewTaskdata.toString());
        }
      }
      setState(() {
        isloading = false;
      });
    });
  }

  Future<bool> _onBackPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString(ApiConstants.rolename) == "employee" || prefs.getString(ApiConstants.rolename) == null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHomePage()));
    }
    return true;
  }
}
