import 'package:colors/model/airtable_colors_fig.dart';
import 'package:colors/models/airtable_colors_fig.dart';
import 'package:flutter/material.dart';

import 'detail_color.dart';

class ColorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AirtableDataColorModel airtableData = AirtableDataColorModel();
    return SingleChildScrollView(
      padding: EdgeInsets.all(5),

      ///
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: FutureBuilder(
                future: airtableData.getColors(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AirtableDataColors>> snapshot) {
                  if (snapshot.hasData) {
                    List<AirtableDataColors>? values = snapshot.data;

                    return ListView(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: values!
                          .map<Widget>(
                            (AirtableDataColors value) => Column(
                              children: [
                                ListTile(
                                  leading: SizedBox(
                                    height: 36,
                                    width: 36,
                                    child: Image.network(value.image),
                                  ),
                                  title: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(value.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24,
                                          )),
                                    ],
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10.0),
                                  onTap: () async {
                                    await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => DetailColorScreen(
                                        colorId: value.id,
                                        colorName: value.name,
                                      ),
                                    ));
                                  },
                                ),
                                 Container(
                                  height: 5,
                                  color: Colors.green[100],
                                ),
                              ],
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
