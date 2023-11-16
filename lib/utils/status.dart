enum Status {
  alive("alive"),
  dead("dead"),
  unknown("unknown");

  final String status;

  const Status(this.status);
}

extension StatusExtention on List<Status> {
  bool containStatus(String element) {
    bool isContain = false;
    for (var item in this) {
      if (item.status == element.toLowerCase()) {
        isContain = true;
      }
    }

    return isContain;
  }
}
