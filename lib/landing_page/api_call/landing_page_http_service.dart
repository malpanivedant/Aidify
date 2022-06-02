import 'dart:convert';

import 'package:help_on_needs/landing_page/models/landing_page_model.dart';
import 'package:http/http.dart';

const String postURL =
    "http://lb-hackathon-disaster-management-35a50dbb394cccc0.elb.ap-south-1.amazonaws.com/api/v1/playlist/disaster";

class LandingHttpServiceApi {
  Future<LandingPageModel?> posts(String query) async {
    Uri uri = Uri.parse(postURL);

    var res = await post(uri, headers: header, body: query);

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      LandingPageModel landingPageModel = LandingPageModel.fromMap(body);

      return landingPageModel;
    } else {
      return null;
    }
  }
}

Map<String, String> header = {
  "x-customer-id": "38dac074-1966-49bc-8125-41db4a1ea0ae-vVvVNTX0",
  "Content-Type": "application/json",
};
