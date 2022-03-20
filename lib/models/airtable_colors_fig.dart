import 'package:colors/model/airtable_colors_fig.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:colors/utils/config.dart';

class AirtableDataColorModel {
  final Uri urlProfil = Uri.https(
    "api.airtable.com",
    "/v0/${Config.ProjectBase}/Colors",
    {"maxRecords": "10", "view": "Grid view"},
  );

  Future<List<AirtableDataColors>> getColors() async {
    final res = await http.get(
      urlProfil,
      headers: {"Authorization": "Bearer ${Config.apiKey}"},
    );

    if (res.statusCode == 200) {
      var convertDataToJson = jsonDecode(res.body);
      var data = convertDataToJson['records'];

      List<AirtableDataColors> values = [];
      data.forEach(
        (value) => {
          values.add(
            AirtableDataColors(
              id: value['id'],
              createdTime: value['createdTime'],
              name: value['fields']['name'],
              image: value['fields']['image'][0]['url'],
              related: value['fields']['related'],
            ),
          )
        },
      );
      return values;
    } else {
      throw "ERROR !!!!!";
    }
  }

  Future<List<AirtableDataColors>> getOneColor(id) async {
    final Uri urlOneFig =
        Uri.https("api.airtable.com", "/v0/${Config.ProjectBase}/Colors/$id");
    final res = await http.get(
      urlOneFig,
      headers: {"Authorization": "Bearer ${Config.apiKey}"},
    );

    if (res.statusCode == 200) {
      var convertDataToJson = jsonDecode(res.body);
      var data = convertDataToJson;

      List<AirtableDataColors> values = [];
      values.add(AirtableDataColors(
        id: data['id'],
        createdTime: data['createdTime'],
        name: data['fields']['name'],
        image: data['fields']['image'][0]['url'],
        related: data['fields']['related'],
      ));
      return values;
    } else {
      throw "ERROR !!!!!";
    }
  }
}
