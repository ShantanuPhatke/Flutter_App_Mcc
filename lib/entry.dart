class Entry {
  final String entryId;
  final String mobile;
  final String name;
  final String message;

  Entry({this.entryId, this.mobile, this.name, this.message});

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      entryId: json['entryId'],
      mobile: json['mobile'],
      name: json['name'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "entryId": entryId,
      "mobile": mobile,
      "name": name,
      "message": message
    };
  }
}
