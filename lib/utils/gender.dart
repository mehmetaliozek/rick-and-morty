enum Gender {
  male("male"),
  female("female"),
  genderless("genderless"),
  unknown("unkkown");

  final String gender;

  const Gender(this.gender);
}

extension GenderExtention on List<Gender> {
  bool containStatus(String element) {
    bool isContain = false;
    for (var item in this) {
      if (item.gender == element.toLowerCase()) {
        isContain = true;
      }
    }

    return isContain;
  }
}
