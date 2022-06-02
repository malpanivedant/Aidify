import 'dart:convert';

import 'package:help_on_needs/disaster_detail/models/details_page_model.dart';
import 'package:http/http.dart';

const String getUrl =
    "http://lb-hackathon-disaster-management-35a50dbb394cccc0.elb.ap-south-1.amazonaws.com/api/v1/details/disaster";

class DetailsHttpServiceApi {
  Future<DetailsPageModel?> gets(String id) async {
    Uri uri = Uri.parse("$getUrl/$id");
    var res = await get(uri, headers: header);

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);

      DetailsPageModel detailsPageModel = DetailsPageModel.fromMap(body);

      return detailsPageModel;
    } else {
      return null;
    }
  }
}

Map<String, String> header = {
  "x-customer-id": "38dac074-1966-49bc-8125-41db4a1ea0ae-vVvVNTX0",
  "Content-Type": "application/json",
};
