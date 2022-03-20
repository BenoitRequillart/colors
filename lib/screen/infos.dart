
import 'package:colors/model/airtable_data_info.dart';
import 'package:colors/models/airtable_data_info.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AirtableData airtableData = AirtableData();
    return SingleChildScrollView(
      padding: EdgeInsets.all(5),

      ///
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: FutureBuilder(
                future: airtableData.getInfo(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AirtableDataInfo>> snapshot) {
                  print(airtableData.getInfo());
                  if (snapshot.hasData) {
                    List<AirtableDataInfo>? values = snapshot.data;

                    return ListView(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: values!
                          .map<Widget>(
                            (AirtableDataInfo value) => ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(value.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                      )),
                                  Text(value.content)
                                ],
                              ),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10.0),
                            ),
                          )
                          .toList(),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          )
        ],
      ),
    );
  }
}
