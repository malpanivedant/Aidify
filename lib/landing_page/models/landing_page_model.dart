import 'dart:convert';

class LandingPageModel {
  LandingPageModel({
    this.disasterList,
  });

  final List<DisasterList>? disasterList;

  factory LandingPageModel.fromJson(String str) =>
      LandingPageModel.fromMap(json.decode(str));

  factory LandingPageModel.fromMap(Map<String, dynamic> json) =>
      LandingPageModel(
        disasterList: json["disasterList"] == null
            ? null
            : List<DisasterList>.from(
                json["disasterList"].map((x) => DisasterList.fromMap(x))),
      );
}

class DisasterList {
  DisasterList({
    this.id,
    this.title,
    this.eventStartDate,
    this.city,
    this.state,
    this.country,
    this.type,
    this.severity,
    this.criticalityRating,
    this.requires,
    this.imageUrl,
  });

  final String? id;
  final String? title;
  final String? eventStartDate;
  final String? city;
  final String? state;
  final String? country;
  final String? type;
  final String? severity;
  final int? criticalityRating;
  final List<String>? requires;
  final String? imageUrl;

  factory DisasterList.fromMap(Map<String, dynamic> json) => DisasterList(
        id: json["id"],
        title: json["title"],
        eventStartDate: json["eventStartDate"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        type: json["type"],
        severity: json["severity"],
        criticalityRating: json["criticalityRating"],
        requires: json["requires"] == null
            ? null
            : List<String>.from(json["requires"].map((x) => x)),
        imageUrl: json["imageUrl"],
      );
}
