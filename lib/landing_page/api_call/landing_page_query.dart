class LandingPageQuery {
  static String getQuery(int type) {
    return type == 0 ? queryType0 : queryType1;
  }
}

const String queryType0 = '''
{
  "date": "2022-03-14",
  "limit": 20,
  "location": "string",
  "offset": 0,
  "type": "CRITICAL"
}
''';

const String queryType1 = '''
{
  "date": "2022-03-14",
  "limit": 20,
  "location": "Tamil Nadu",
  "offset": 0,
  "type": "NEARBY"
}
''';


//curl -X POST "http://lb-hackathon-disaster-management-35a50dbb394cccc0.elb.ap-south-1.amazonaws.com/api/v1/playlist/distaster" -H "accept: */*" -H "Content-Type: application/json" -d "{ \"date\": \"2022-04-13\", \"limit\": 20, \"location\": \"fafaf\", \"offset\": 0, \"type\": \"CRITICAL\"}"
