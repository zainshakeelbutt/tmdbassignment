class VideosModel {
  int? id;
  List<Results>? results;

  VideosModel({this.id, this.results});

  VideosModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {

  String? name;
  String? key;
  String? type;
  String? id;

  Results(
      {
        this.name,
        this.key,
        this.type,
        this.id});

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    key = json['key'];
    type = json['type'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['key'] = key;
    data['type'] = type;
    data['id'] = id;
    return data;
  }
}
