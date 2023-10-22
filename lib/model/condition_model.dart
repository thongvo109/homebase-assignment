class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({
    this.text,
    this.icon,
    this.code,
  });

  String get pathIcon => "https:$icon";

  Condition.fromJson(Map<String, dynamic> json)
      : text = json["text"],
        icon = json["icon"],
        code = json["code"];
}
