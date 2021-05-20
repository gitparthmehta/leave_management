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
  ViewKRABloc _viewTaskBloc = ViewKRABloc();
  bool isloading = true;
  bool showlist = false;
  List<ViewKRA> _viewTaskdata =[];
  ViewKRA viewkra;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            title: Text("View KRA"),
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
                  child: Expanded(child: ListView.builder(
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
                                child:  Column(
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
                                        _viewTaskdata[index].employee_name,
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
                                      "Finacial Year",
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
                                        _viewTaskdata[index].finacial_year,
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
                                      "KRA Salary",
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
                                        _viewTaskdata[index].kra_salary,
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
                                      "Work Responsibility",
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
                                        _viewTaskdata[index].work_responsibility,
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
                                      "Work Responsibility Feedback",
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
                                        _viewTaskdata[index].work_responsibility_feedback,
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
                                      "Company Behaviour",
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
                                        _viewTaskdata[index].com_behaviour,
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
                                      "Company Behaviour Feedback",
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
                                        _viewTaskdata[index].comp_feedback,
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
                                      "Team Player",
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
                                        _viewTaskdata[index].team_player,
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
                                      "Team Player Feedback",
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
                                        _viewTaskdata[index].team_player_feed_back,
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
                                      "Task Delivery",
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
                                        _viewTaskdata[index].task_delivery,
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
                                      "Task Delivery Feedback",
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
                                        _viewTaskdata[index].task_delivery_feedback,
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
                                      "KRA Percentage",
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
                                        _viewTaskdata[index].kra_per,
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
                                      "KRA Salary with Performance",
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
                                        _viewTaskdata[index].kra_salary_with_performance,
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
                                      "Total",
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
                                        _viewTaskdata[index].total,
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
                                      "Final KRA Salary",
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
                                        _viewTaskdata[index].final_kra_salary,
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
          )
      ),
    );
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
          _viewTaskdata = value.data.Result.viewkra;
          showlist = false;

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
