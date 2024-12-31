class Member {
  int memPoint;
  bool firstPurch;
  bool rm30Purch;
  int rm10x5Purch;
  Member({
    required this.memPoint,
    required this.firstPurch,
    required this.rm30Purch,
    required this.rm10x5Purch,
  });
  static Member member = Member(memPoint: 0, firstPurch: false, rm30Purch: false, rm10x5Purch: 0);
  void empty() {
    Member.member = Member(memPoint: 0, firstPurch: false, rm30Purch: false, rm10x5Purch: 0);
  }
}
