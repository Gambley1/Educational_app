
import 'dart:convert';

List<UserGroup> userGroupFromJson(String str) =>
    List<UserGroup>.from(json.decode(str).map((x) => UserGroup.fromJson(x)));

class UserGroup {
  UserGroup({
    required this.id,
    required this.userId,
    required this.groupId,
    required this.createdDate,
  });

  String id;
  String userId;
  String groupId;
  String createdDate;

  factory UserGroup.fromJson(Map<String, dynamic> json) => UserGroup(
        id: json["id"],
        userId: json["user_id"],
        groupId: json["group_id"],
        createdDate: json["created_date"],
      );
}
