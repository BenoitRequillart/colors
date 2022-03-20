import 'package:colors/model/airtable_data_fig.dart';
import 'package:colors/models/airtable_data_fig.dart';
import 'package:colors/screen/detail_fig.dart';
import 'package:flutter/material.dart';

class FigScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AirtableData airtableData = AirtableData();
    return SingleChildScrollView(
      ///
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: FutureBuilder(
                future: airtableData.getFig(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<AirtableDataFig>> snapshot) {
                  if (snapshot.hasData) {
                    List<AirtableDataFig>? values = snapshot.data;

                    return ListView(
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: values!
                          .map<Widget>(
                            (AirtableDataFig value) => Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ListTile(
                                  leading: SizedBox(
                                    height: 36,
                                    width: 36,
                                    child: Image.network(value.image),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: Text(value.name,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 24,
                                            )),
                                      ),
                                    ],
                                  ),
                                  onTap: () async {
                                    await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => DetailFigScreen(
                                        figId: value.id,
                                        figName: value.name,
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
