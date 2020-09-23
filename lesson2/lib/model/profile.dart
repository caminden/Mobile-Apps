enum Classification {
  Freshman,
  Sophomore,
  Junior,
  Senior,
  Graduate,
}

enum Major {
  CS,
  SE,
  Other,
}

enum Language { Dart, Java, Cpp}

class Profile {
  String name;
  int age;
  Classification classification;
  Major major;
  Map languages = {
    Language.Dart: false,
    Language.Java: false,
    Language.Cpp: false,
  };

Profile({
  this.name = '', 
  this.age = 0,
  this.classification = Classification.Freshman,
  this.major = Major.CS,
  });

Profile.clone(Profile p){
  this.name = p.name;
  this.age = p.age;
  this.classification = p.classification;
  this. major = p.major;
  this.languages = Map.from(p.languages);
}
}
