

class ErrorPojo {
  String message;
  Errors errors;

  ErrorPojo({this.message, this.errors});

  ErrorPojo.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors =
    json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.errors != null) {
      data['errors'] = this.errors;
    }
    return data;
  }
}

class Errors {
  List<String> error;

  Errors({this.error});

  Errors.fromJson(Map<String, dynamic> json) {
    error = json[json.keys.first].cast<String>();
  }


}
