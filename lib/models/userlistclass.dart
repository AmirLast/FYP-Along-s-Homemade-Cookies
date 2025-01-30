class UserList {
  String name;
  String uid;
  String type;
  String shop = "";
  bool ban;
  List<UserList> users = [];
  UserList({
    required this.name,
    required this.uid,
    required this.type,
    required this.ban,
  });
  static UserList user = UserList(name: "", uid: "", type: "", ban: false);
  void empty() {
    UserList.user = UserList(name: "", uid: "", type: "", ban: false);
    UserList.user.shop = "";
    UserList.user.users.clear();
  }
}
