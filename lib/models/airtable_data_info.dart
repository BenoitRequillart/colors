
import 'package:colors/model/airtable_data_info.dart';
import 'package:colors/utils/config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class AirtableData {
  final Uri urlProfil = Uri.https(
    "api.airtable.com",
    "/v0/${Config.ProjectBase}/Infos",
    {"maxRecords": "10", "view": "Grid view"},
  );

  Future<List<AirtableDataInfo>> getInfo() async {
    final res = await http.get(
      urlProfil,
      headers: {"Authorization": "Bearer ${Config.apiKey}"},
    );

    if (res.statusCode == 200) {
      var convertDataToJson = jsonDecode(res.body);
      var data = convertDataToJson['records'];

      print(data);

      List<AirtableDataInfo> values = [];
      data.forEach(
        (value) => {
          values.add(
            AirtableDataInfo(
                id: value['id'],
                createdTime: value['createdTime'],
                title: value['fields']['title'],
                content: value['fields']['content']),
          )
        },
      );
      return values;
    } else {
      throw "ERROR !!!!!";
    }
  }
}
