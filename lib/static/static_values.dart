class StaticValues {
  const StaticValues._();

  static Uri apiUriGroup = Uri.http("192.168.1.166:5000", "/group");
  static Uri apiUriLogin = Uri.http("192.168.1.166:5000", "/auth/login");
  static Uri apiUriRegister = Uri.http("192.168.1.166:5000", "/auth.register");
  static Uri apiUriSubjects = Uri.http("192.168.1.166:5000", "/subjects");
  static Uri apiUriTeacherSubjects =
      Uri.http("192.168.1.166:5000", "/teacherSubject");
}
