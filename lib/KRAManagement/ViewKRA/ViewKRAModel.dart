class ViewKRAModel {
  String status;
  String message;
  List<ViewKRA> viewkra;

  ViewKRAModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    viewkra = new List<ViewKRA>();

    if (json.containsKey("show_all_kra")) {
      json['show_all_kra'].forEach((v) {
        viewkra.add(new ViewKRA.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['status'] = this.status;
    if (this.viewkra != null) {
      data['show_all_kra'] = this.viewkra.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ViewKRA {
  String employee_name;
  String employee_id;
  String finacial_year;
  String kra_salary;
  String work_responsibility;
  String work_responsibility_feedback;
  String com_behaviour;
  String comp_feedback;
  String team_player;
  String team_player_feed_back;
  String task_delivery;
  String task_delivery_feedback;
  String kra_per;
  String kra_salary_with_performance;
  String total;
  String final_kra_salary;
  String kra_id;

  ViewKRA(this.employee_name, this.employee_id);

  ViewKRA.fromJson(Map<String, dynamic> json) {
    employee_name = json['employee_name'];
    employee_id = json['employee_id'];
    finacial_year = json['finacial_year'];
    kra_salary = json['kra_salary'];
    work_responsibility = json['work_responsibility'];
    work_responsibility_feedback = json['work_responsibility_feedback'];
    com_behaviour = json['com_behaviour'];
    comp_feedback = json['comp_feedback'];
    team_player = json['team_player'];
    team_player_feed_back = json['team_player_feed_back'];
    task_delivery = json['task_delivery'];
    task_delivery_feedback = json['task_delivery_feedback'];
    kra_per = json['kra_per'];
    kra_salary_with_performance = json['kra_salary_with_performance'];
    total = json['total'];
    final_kra_salary = json['final_kra_salary'];
    kra_id = json['kra_id'];
  }

  Map<String, dynamic> toJson() =>
      {
        "employee_name": employee_name,
        "employee_id": employee_id,
        "finacial_year": finacial_year,
        "kra_salary": kra_salary,
        "work_responsibility": work_responsibility,
        "work_responsibility_feedback": work_responsibility_feedback,
        "com_behaviour": com_behaviour,
        "comp_feedback": comp_feedback,
        "team_player": team_player,
        "team_player_feed_back": team_player_feed_back,
        "task_delivery": task_delivery,
        "task_delivery_feedback": task_delivery_feedback,
        "kra_per": kra_per,
        "kra_salary_with_performance": kra_salary_with_performance,
        "total": total,
        "final_kra_salary": final_kra_salary,
        "kra_id": kra_id,
      };

}
