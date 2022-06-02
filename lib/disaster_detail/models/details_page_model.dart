class DetailsPageModel {
  DetailsPageModel({
    this.id,
    this.name,
    this.location,
    this.lattitude,
    this.longitude,
    this.organizationCount,
    this.peopleImpacted,
    this.financialLoss,
    this.accepts,
    this.imageurl,
    this.description,
    this.organizations,
    this.eventStartDate,
  });

  final String? id;
  final String? name;
  final String? location;
  final String? lattitude;
  final String? longitude;
  final int? organizationCount;
  final int? peopleImpacted;
  final String? financialLoss;
  final List<String>? accepts;
  final String? imageurl;
  final String? eventStartDate;
  final String? description;
  final List<Organization>? organizations;

  factory DetailsPageModel.fromMap(Map<String, dynamic> json) =>
      DetailsPageModel(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        lattitude: json["lattitude"],
        longitude: json["longitude"],
        organizationCount: json["organizationCount"],
        peopleImpacted: json["peopleImpacted"],
        financialLoss: json["financialLoss"],
        eventStartDate: json["eventStartDate"],
        accepts: json["accepts"] == null
            ? null
            : List<String>.from(json["accepts"].map((x) => x)),
        imageurl: json["imageurl"],
        description: json["description"],
        organizations: json["organizations"] == null
            ? null
            : List<Organization>.from(
                json["organizations"].map((x) => Organization.fromMap(x))),
      );
}

class Organization {
  Organization({
    this.id,
    this.name,
    this.accepts,
    this.about,
    this.founded,
    this.founder,
    this.type,
    this.registrationNo,
    this.areaServed,
    this.website,
    this.verified,
    this.volunteerCount,
    this.contact,
  });

  final String? id;
  final String? name;
  final List<String>? accepts;
  final String? about;
  final String? founded;
  final String? founder;
  final String? type;
  final String? registrationNo;
  final String? areaServed;
  final String? website;
  final bool? verified;
  final int? volunteerCount;
  final String? contact;

  factory Organization.fromMap(Map<String, dynamic> json) => Organization(
        id: json["id"],
        name: json["name"],
        accepts: json["accepts"] == null
            ? null
            : List<String>.from(json["accepts"].map((x) => x)),
        about: json["about"],
        founded: json["founded"],
        founder: json["founder"],
        type: json["type"],
        registrationNo: json["registrationNo"],
        areaServed: json["areaServed"],
        website: json["website"],
        verified: json["verified"],
        volunteerCount: json["volunteerCount"],
        contact: json["contact"],
      );
}
