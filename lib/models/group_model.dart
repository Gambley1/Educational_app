class GroupResponse {
  final List<Group>? groups;
  GroupResponse({
    this.groups,
  });

  factory GroupResponse.fromJson(Map<String, dynamic> json) => GroupResponse(
        groups: List<Group>.from(json["groups"].map((x) => Group.fromJson(x))),
      );
}

class Group {
  final String? name;
  final String? id;
  Group({
    this.name,
    this.id,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        name: json["name"],
        id: json["id"],
      );
}
