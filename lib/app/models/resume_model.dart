class Profile {
  final String name;
  final String designation;
  final String imagePath;
  final String currentCityAndCountry;

  Profile({
    required this.name,
    required this.designation,
    required this.imagePath,
    required this.currentCityAndCountry,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        name: json["name"] ?? '',
        designation: json["designation"] ?? '',
        imagePath: json["imagePath"] ?? '',
        currentCityAndCountry: json["currentCityAndCountry"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "designation": designation,
        "imagePath": imagePath,
        "currentCityAndCountry": currentCityAndCountry,
      };
}

class Contact {
  final String email;
  final String phone;
  final String countryCode;
  final String linkedin;

  Contact({
    required this.email,
    required this.phone,
    required this.linkedin,
    required this.countryCode,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        email: json["email"] ?? '',
        phone: json["phone"] ?? '',
        linkedin: json["linkedin"] ?? '',
        countryCode: json["countryCode"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phone": phone,
        "linkedin": linkedin,
        "countryCode": countryCode,
      };
}

class Experience {
  final String companyName;
  final String designation;
  final DateTime startDate;
  final DateTime endDate;
  final String summary;
  final String companyLink;

  Experience({
    required this.companyName,
    required this.designation,
    required this.startDate,
    required this.endDate,
    required this.summary,
    required this.companyLink,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        companyName: json["companyName"] ?? '',
        designation: json["designation"] ?? '',
        startDate: json["startDate"],
        endDate: json["endDate"],
        summary: json["summary"] ?? '',
        companyLink: json["companyLink"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "designation": designation,
        "startDate": startDate,
        "endDate": endDate,
        "summary": summary,
        "companyLink": companyLink,
      };
}

class Project {
  final String projectName;
  final DateTime startDate;
  final DateTime endDate;
  final String projectSummary;
  final String projectLink;

  Project({
    required this.projectName,
    required this.startDate,
    required this.endDate,
    required this.projectSummary,
    required this.projectLink,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        projectName: json["projectName"] ?? '',
        startDate: json["startDate"],
        endDate: json["endDate"],
        projectSummary: json["projectSummary"] ?? '',
        projectLink: json["projectLink"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "projectName": projectName,
        "startDate": startDate,
        "endDate": endDate,
        "projectSummary": projectSummary,
        "projectLink": projectLink,
      };
}

class Course {
  final String courseName;
  final DateTime startDate;
  final DateTime endDate;
  final String courseSummary;
  final String courseLink;
  final bool status;

  Course({
    required this.courseName,
    required this.startDate,
    required this.endDate,
    required this.courseSummary,
    required this.courseLink,
    required this.status,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        courseName: json["courseName"] ?? '',
        startDate: json["startDate"],
        endDate: json["endDate"],
        courseSummary: json["courseSummary"] ?? '',
        courseLink: json["courseLink"] ?? '',
        status: json["status"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "courseName": courseName,
        "startDate": startDate,
        "endDate": endDate,
        "courseSummary": courseSummary,
        "courseLink": courseLink,
        "status": status,
      };
}

class Education {
  final String universityName;
  final DateTime startDate;
  final DateTime endDate;
  final String courseTaken;
  final String collegeLink;

  Education({
    required this.universityName,
    required this.startDate,
    required this.endDate,
    required this.courseTaken,
    required this.collegeLink,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        universityName: json["universityName"] ?? '',
        startDate: json["startDate"],
        endDate: json["endDate"],
        courseTaken: json["courseTaken"] ?? '',
        collegeLink: json["collegeLink"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "universityName": universityName,
        "startDate": startDate,
        "endDate": endDate,
        "courseTaken": courseTaken,
        "collegeLink": collegeLink,
      };
}

class Reference {
  final String name;
  final String designation;
  final String company;
  final String email;

  Reference({
    required this.name,
    required this.designation,
    required this.company,
    required this.email,
  });

  factory Reference.fromJson(Map<String, dynamic> json) => Reference(
        name: json["name"] ?? '',
        designation: json["designation"] ?? '',
        company: json["company"] ?? '',
        email: json["email"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "designation": designation,
        "company": company,
        "email": email,
      };
}

class Language {
  final String name;
  final String level;

  Language({
    required this.name,
    required this.level,
  });

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        name: json["name"] ?? '',
        level: json["level"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "level": level,
      };
}

class Resume {
  final Profile profile;
  final Contact contact;
  final List<Experience> experiences;
  final List<Project> projects;
  final List<Education> educations;
  final List<String> skills;
  final List<Language> languages;
  final List<Reference> references;
  final List<Course> courses;
  final String profileSummary;

  Resume({
    required this.profile,
    required this.contact,
    required this.experiences,
    required this.projects,
    required this.educations,
    required this.skills,
    required this.languages,
    required this.references,
    required this.courses,
    required this.profileSummary,
  });

  factory Resume.fromJson(Map<String, dynamic> json) {
    var experiencesList = json['experiences'] as List;
    List<Experience> experiences = experiencesList.map((i) => Experience.fromJson(i)).toList();

    var projectsList = json['projects'] as List;
    List<Project> projects = projectsList.map((i) => Project.fromJson(i)).toList();

    var educationsList = json['educations'] as List;
    List<Education> educations = educationsList.map((i) => Education.fromJson(i)).toList();

    var referencesList = json['references'] as List;
    List<Reference> references = referencesList.map((i) => Reference.fromJson(i)).toList();

    var coursesList = json['courses'] as List;
    List<Course> courses = coursesList.map((i) => Course.fromJson(i)).toList();

    var languagesList = json['languages'] as List;
    List<Language> languages = languagesList.map((i) => Language.fromJson(i)).toList();

    return Resume(
      profile: Profile.fromJson(json["profile"]),
      contact: Contact.fromJson(json["contact"]),
      experiences: experiences,
      projects: projects,
      educations: educations,
      skills: json["companyLink"],
      languages: languages,
      references: references,
      courses: courses,
      profileSummary: json["profileSummary"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "profile": profile,
        "contact": contact,
        "experiences": experiences,
        "projects": projects,
        "educations": educations,
        "skills": skills,
        "languages": languages,
        "references": references,
        "courses": courses,
        "profileSummary": profileSummary,
      };
}
