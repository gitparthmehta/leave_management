import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:flutter_app/Task/ViewTask/ViewTaskBloc.dart';
import 'package:flutter_app/Task/ViewTask/ViewTaskRequest.dart';
import 'package:flutter_app/utilities/TextView.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewTaskModel.dart';

class ViewTaskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ViewTaskScreen();
}

class _ViewTaskScreen extends State<ViewTaskScreen> {
  String token = "";
  String user_id = "";
  ViewTaskBloc _viewTaskBloc = ViewTaskBloc();
  bool isloading = true;
  bool showlist = false;
  List<ViewTask> _viewTaskdata = [];
  List<ViewTask> _firstviewTaskdata = [];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Text("View Task"),
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
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Visibility(
                          visible: showlist,
                          child: Expanded(
                              child: ListView.builder(
                            padding: EdgeInsets.all(5),
                            shrinkWrap: true,
                            itemCount: _viewTaskdata.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                  child: Card(
                                color: Colors.white,
                                // elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        SizedBox(height: 10.0),
                                        TextView(
                                          "Project Name",
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
                                          child: TextView(
                                            _viewTaskdata[index].project_name.toString(),
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 13,
                                            textAlign: TextAlign.left,
                                            textColor: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                        ),
                                        SizedBox(height: 10.0),
                                        TextView(
                                          "Title",
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
                                          child: TextView(
                                            _viewTaskdata[index].title,
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 13,
                                            textAlign: TextAlign.left,
                                            textColor: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                        ),
                                        SizedBox(height: 10.0),
                                        TextView(
                                          "Description",
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
                                          child: TextView(
                                            _viewTaskdata[index].description,
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 13,
                                            textAlign: TextAlign.left,
                                            textColor: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                        ),
                                        SizedBox(height: 10.0),
                                        TextView(
                                          "Subject",
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
                                          child: TextView(
                                            _viewTaskdata[index].subject,
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 13,
                                            textAlign: TextAlign.left,
                                            textColor: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                        ),
                                        SizedBox(height: 10.0),
                                        TextView(
                                          "Priority",
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
                                          child: TextView(
                                            _viewTaskdata[index].priority,
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 13,
                                            textAlign: TextAlign.left,
                                            textColor: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                        ),
                                        SizedBox(height: 10.0),
                                        TextView(
                                          "Task Status",
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
                                          child: TextView(
                                            _viewTaskdata[index].task_status,
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 13,
                                            textAlign: TextAlign.left,
                                            textColor: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                        ),
                                        SizedBox(height: 10.0),
                                        TextView(
                                          "Start Date",
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
                                          child: TextView(
                                            _viewTaskdata[index].start_date,
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 13,
                                            textAlign: TextAlign.left,
                                            textColor: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                        ),
                                        SizedBox(height: 10.0),
                                        TextView(
                                          "End Date",
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
                                          child: TextView(
                                            _viewTaskdata[index].end_date,
                                            fontFamily: 'Poppins-SemiBold',
                                            fontSize: 13,
                                            textAlign: TextAlign.left,
                                            textColor: Colors.black,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          height: 35,
                                          alignment: Alignment.centerLeft,
                                        ),
                                        SizedBox(height: 10.0),
                                        TextView(
                                          "Complete Percentage",
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
                                          child: TextView(
                                            _viewTaskdata[index].task_per.toString(),
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
                                ),
                              ));
                            },
                          ))),
                      Visibility(
                          visible: showlist == false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: TextView(
                                  "No Data Found",
                                  fontFamily: 'Poppins-SemiBold',
                                  fontSize: 18,
                                  textAlign: TextAlign.center,
                                  fontWeight: FontWeight.bold,
                                  textColor: Colors.cyan,
                                ),
                              )
                            ],
                          ))
                    ],
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

    _viewTaskBloc.executeLeaveList(ViewTaskRequest(user_id, token, user_id));
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
          _viewTaskdata = value.data.Result.viewtask;
        } else {
          showlist = true;
          if (_viewTaskdata.length > 0) {
            _viewTaskdata.clear();
          }
          _viewTaskdata = value.data.Result.viewtask;


          print("_viewTaskdata" + _viewTaskdata.toString());
        }
      }
      setState(() {
        isloading = false;
      });
    });
  }

  Future<bool> _onBackPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString(ApiConstants.rolename) == "employee" ||
        prefs.getString(ApiConstants.rolename) == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AdminHomePage()));
    }
    return true;
  }
}
