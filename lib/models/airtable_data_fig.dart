import 'package:colors/model/airtable_data_fig.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:colors/utils/config.dart';

class AirtableData {
  final Uri urlProfil = Uri.https(
    "api.airtable.com",
    "/v0/${Config.ProjectBase}/Figurinne",
    {"maxRecords": "10", "view": "Grid view"},
  );

  Future<List<AirtableDataFig>> getFig() async {
    final res = await http.get(
      urlProfil,
      headers: {"Authorization": "Bearer ${Config.apiKey}"},
    );

    if (res.statusCode == 200) {
      var convertDataToJson = jsonDecode(res.body);
      var data = convertDataToJson['records'];
      List<AirtableDataFig> values = [];
      data.forEach(
        (value) => {
          values.add(
            AirtableDataFig(
                id: value['id'],
                createdTime: value['createdTime'],
                name: value['fields']['name'],
                image: value['fields']['image'][0]['url'],
                colors: value['fields']['Colors']),
          )
        },
      );
      return values;
    } else {
      throw "ERROR !!!!!";
    }
  }

  Future<List<AirtableDataFig>> getOneFig(id) async {
    final Uri urlOneFig = Uri.https(
        "api.airtable.com", "/v0/${Config.ProjectBase}/Figurinne/$id");
    final res = await http.get(
      urlOneFig,
      headers: {"Authorization": "Bearer ${Config.apiKey}"},
    );

    if (res.statusCode == 200) {
      var convertDataToJson = jsonDecode(res.body);
      var data = convertDataToJson;

      List<AirtableDataFig> values = [];
      values.add(AirtableDataFig(
          id: data['id'],
          createdTime: data['createdTime'],
          name: data['fields']['name'],
          image: data['fields']['image'][0]['url'],
          colors: data['fields']['Colors']));

      return values;
    } else {
      throw "ERROR !!!!!";
    }
  }
}
