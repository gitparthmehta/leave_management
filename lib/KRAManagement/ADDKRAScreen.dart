import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/KRAManagement/AddKRAApi/AddKRARequest.dart';
import 'package:flutter_app/KRAManagement/KRAEmployeeList/KRAEmployeeListBloc.dart';
import 'package:flutter_app/Screens/AdminHomePage.dart';
import 'package:flutter_app/Screens/HomePage.dart';
import 'package:flutter_app/utilities/TextView.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../SearchPage.dart';
import 'AddKRAApi/AddKRABloc.dart';
import 'KRAEmployeeList/KRAEmployeeListModel.dart';

class ADDKRAScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ADDKRAScreen();
}

class _ADDKRAScreen extends State<ADDKRAScreen> {
  String token = "";
  String user_id = "";
  AddKRABloc _addKRABloc = AddKRABloc();
  bool isloading = true;
  bool showlist = false;
  KRAEmployeeListBloc _kraEmployeeListBloc = KRAEmployeeListBloc();
  List<KRAEmployeeList> _kraemployeelist;
  KRAEmployeeList _nameList;
  String selected_Id = "";
  TextEditingController _krasalarycontroller = new TextEditingController();
  TextEditingController _workresponsibility = new TextEditingController();
  TextEditingController _workresponsibilityfeedback =
      new TextEditingController();
  TextEditingController _companybehaviours = new TextEditingController();
  TextEditingController _companybehavioursfeedback =
      new TextEditingController();
  TextEditingController _teamplayer = new TextEditingController();
  TextEditingController _teamplayerfeedback = new TextEditingController();
  TextEditingController _taskdelivery = new TextEditingController();
  TextEditingController _taskdeliveryfeedback = new TextEditingController();
  TextEditingController _krapercentage = new TextEditingController();
  TextEditingController _krasalarywithperformance = new TextEditingController();
  int _totalcount = 0;
  double _totalkrasalarycount = 0;

  DateTime _selectedDate;
  TextEditingController _enddatecontroller = new TextEditingController();

  String _date;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Add KRA"),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(height: 10.0),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Container(
                                          height: 40,
                                          padding: new EdgeInsets.fromLTRB(
                                              10.0, 0.0, 10.0, 0.0),
                                          decoration: new BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: new Border.all(
                                              width: 0.5,
                                            ),
                                          ),
                                          child: getDropDown(),
                                        )
                                      ]),
                                  SizedBox(height: 10.0),
                                  InkWell(
                                    onTap: () {

                                      Navigator.pushReplacement(
                                          context, MaterialPageRoute(builder: (context) => SearchPage()));
                                    },
                                    child: IgnorePointer(
                                      child: new TextField(
                                        controller: _enddatecontroller,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.black)),
                                          hintText: "Select Finaceial Year and Month",
                                          hintStyle: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextFormField(
                                          controller: _krasalarycontroller,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.black)),
                                            hintText: 'Enter KRA Salary(INR) ',
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            // LengthLimitingTextInputFormatter(10),
                                          ],
                                          onChanged: (content) {
                                            setState(() {
                                              // _totalkrasalarycount=(int.tryParse(content)?? 0);
                                              gettotal();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextFormField(
                                          controller: _workresponsibility,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.black)),
                                            hintText: 'Work Responsibility',
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            // LengthLimitingTextInputFormatter(10),
                                          ],
                                          onChanged: (content) {
                                            setState(() {
                                              gettotal();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextFormField(
                                          controller:
                                              _workresponsibilityfeedback,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.black)),
                                            hintText:
                                                'Work Responsibility Feedback',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextFormField(
                                          controller: _companybehaviours,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.black)),
                                            hintText: 'Company Behaviours*',
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            // LengthLimitingTextInputFormatter(10),
                                          ],
                                          onChanged: (content) {
                                            setState(() {
                                              gettotal();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextFormField(
                                          controller:
                                              _companybehavioursfeedback,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.black)),
                                            hintText:
                                                'Company Behaviours Feedback',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextFormField(
                                          controller: _teamplayer,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.black)),
                                            hintText: 'Team Player*',
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            // LengthLimitingTextInputFormatter(10),
                                          ],
                                          onChanged: (content) {
                                            setState(() {
                                              gettotal();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextFormField(
                                          controller: _teamplayerfeedback,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.black)),
                                            hintText: 'Team Player Feedback*',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextFormField(
                                          controller: _taskdelivery,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.black)),
                                            hintText: 'Task Delivery',
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            // LengthLimitingTextInputFormatter(10),
                                          ],
                                          onChanged: (content) {
                                            setState(() {
                                              gettotal();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextFormField(
                                          controller: _taskdeliveryfeedback,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.black)),
                                            hintText: 'Task Delivery Feedback',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextFormField(
                                          controller: _krapercentage,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.black)),
                                            hintText: 'KRA Percentage*',
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            // LengthLimitingTextInputFormatter(10),
                                          ],
                                          onChanged: (content) {
                                            setState(() {
                                              gettotal();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: 5.0),
                                        TextFormField(
                                          controller: _krasalarywithperformance,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'OpenSans',
                                            fontSize: 13,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            border: new OutlineInputBorder(
                                                borderSide: new BorderSide(
                                                    color: Colors.black)),
                                            hintText:
                                                'KRA salary with performance*',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      SizedBox(height: 5.0),
                                      Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black54)),
                                          child: _totalcount == 0
                                              ? Totaltitle()
                                              : Totaltext())
                                    ],
                                  ), SizedBox(height: 10.0),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      SizedBox(height: 5.0),
                                      Container(
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black54)),
                                          child: _totalcount == 0
                                              ? Totalkrasalarytitle()
                                              : TotalKRASalarytext())
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Center(
                                          child: SizedBox(
                                        width: 200.0,
                                        height: 40.0,
                                        child: ElevatedButton(
                                          onPressed: () => addKRA(context),
                                          child: const Text("Submit"),
                                        ),
                                      ))
                                    ],
                                  )
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

  Future<void> _getPrefValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString(ApiConstants.token);
    user_id = prefs.getString(ApiConstants.user_id);

    print("token  :" + token);
    print("userid  :" + user_id);

    _kraEmployeeListBloc.executeLeaveList(CommonRequest(user_id, token));
    _kraEmployeeListBloc.subject.listen((value) {
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
          _kraemployeelist = value.data.Result.kraemployeelist;
        } else {
          showlist = true;
          _kraemployeelist = value.data.Result.kraemployeelist;

          print("kraemployeelist" + _kraemployeelist.toString());
        }
      }
      setState(() {
        isloading = false;
      });
    });
  }

  Widget getDropDown() {
    var items = _kraemployeelist.map((projectshowlist) {
      return new DropdownMenuItem<KRAEmployeeList>(
        value: projectshowlist,
        child: new TextView(
          projectshowlist.username,
          fontFamily: 'Poppins-SemiBold',
          fontSize: 13,
          textColor: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      );
    }).toList();

    return DropdownButton<KRAEmployeeList>(
      hint: new Text("Select Employee"),
      isExpanded: true,
      value: this._nameList,
      onChanged: (KRAEmployeeList list) {
        setState(() {
          this._nameList = list;
          selected_Id = list.userid;
          print("select id : " + selected_Id);
        });
      },
      items: items,
    );
  }

  Widget Totaltext() {
    return Text(
      "$_totalcount",
      style: TextStyle(fontSize: 16),
    );
  }  Widget TotalKRASalarytext() {
    return Text(
      "$_totalkrasalarycount",
      style: TextStyle(fontSize: 16),
    );
  }

  Widget Totaltitle() {
    return Text(
      "Total",
      style: TextStyle(fontSize: 16),
    );
  }
 Widget Totalkrasalarytitle() {
    return Text(
      "Final KRA Salary",
      style: TextStyle(fontSize: 16),
    );
  }

  void gettotal() {
    setState(() {
      _totalcount = (int.tryParse(_workresponsibility.text) ?? 0) +
          (int.tryParse(_companybehaviours.text) ?? 0) +
          (int.tryParse(_teamplayer.text) ?? 0) +
          (int.tryParse(_taskdelivery.text) ?? 0) +
          (int.tryParse(_krapercentage.text) ?? 0);

      if(_totalcount!=0){
        int val=int.parse(_krasalarycontroller.text);
        _totalkrasalarycount=((_totalcount.toDouble()*val.toDouble())/100);
      }
      print(_totalcount);
    });
  }

  showDialog(BuildContext context) {
    (context) {
      return AlertDialog(
        title: Text("Select Year"),
        content: Container(
          // Need to use container to add size constraint.
          width: 300,
          height: 300,
          child: YearPicker(
            firstDate: DateTime(DateTime.now().year - 100, 1),
            lastDate: DateTime(DateTime.now().year + 100, 1),
            initialDate: DateTime.now(),
            // save the selected date to _selectedDate DateTime variable.
            // It's used to set the previous selected date when
            // re-showing the dialog.
            selectedDate: _selectedDate,
            onChanged: (DateTime dateTime) {
              // close the dialog when year is selected.
              Navigator.pop(context);

              // Do something with the dateTime selected.
              // Remember that you need to use dateTime.year to get the year
            },
          ),
        ),
      );
    };
  }
  Future<void> addKRA(BuildContext context) async {
    try {
      final result =
      await InternetAddress.lookup('google.com');
      if (result.isNotEmpty &&
          result[0].rawAddress.isNotEmpty) {
        _addKRABloc.executeAttendanceList(
            AddKRARequest(
                user_id,
                token,
                selected_Id,
                "2021",
                _krasalarycontroller.text,
                _workresponsibility.text,
                _workresponsibilityfeedback.text,
                _companybehaviours.text,
            _companybehavioursfeedback.text,
            _teamplayer.text,
            _teamplayerfeedback.text,
            _taskdelivery.text,
            _taskdeliveryfeedback.text,
            _krapercentage.text,
            _krasalarywithperformance.text,
            _totalcount.toString(),
            _totalkrasalarycount.toString()));
        // getAddLeaveResponse(context);
        print('connected');
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
          msg:
          "Please Check Internet Connection",
          toastLength:
          Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      print('not connected');
    }
      setState(() {
        isloading = false;
      });

  }

}
