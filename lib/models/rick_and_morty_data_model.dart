class RickAndMortyDataModel {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  String? origin;
  String? location;
  String? image;
  String? url;
  String? created;

  RickAndMortyDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    origin = json['origin']["name"];
    location = json['location']["name"];
    image = json['image'];
    url = json['url'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['species'] = species;
    data['type'] = type;
    data['gender'] = gender;
    data['origin'] = {'name': origin};
    data['location'] = {'name': location};
    data['image'] = image;
    data['url'] = url;
    data['created'] = created;
    return data;
  }
}
