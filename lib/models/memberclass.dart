class Member {
  int memPoint;
  bool firstPurchase;
  Member({
    required this.memPoint,
    required this.firstPurchase,
  });
  static Member member = Member(memPoint: 0, firstPurchase: true);
}
