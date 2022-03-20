import 'package:colors/model/airtable_colors_fig.dart';
import 'package:colors/model/airtable_data_fig.dart';
import 'package:colors/models/airtable_colors_fig.dart';
import 'package:colors/models/airtable_data_fig.dart';
import 'package:flutter/material.dart';

class DetailColorScreen extends StatelessWidget {
  final String colorId;
  final String colorName;
  const DetailColorScreen(
      {Key? key, required this.colorId, required this.colorName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AirtableDataColorModel airtableData = AirtableDataColorModel();
    return Scaffold(
        appBar: AppBar(
          title: Text(colorName,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
              )),
        ),

        ///
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: FutureBuilder(
                    future: airtableData.getOneColor(colorId),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<AirtableDataColors>> snapshot) {
                      if (snapshot.hasData) {
                        List<AirtableDataColors>? values = snapshot.data;
                        return Column(
                            children: values!
                                .map<Widget>((AirtableDataColors value) =>
                                    Column(
                                      children: [
                                        SizedBox(height: 40),
                                        Center(
                                            child: Image.network(value.image)),
                                        SizedBox(height: 10),
                                        Center(
                                          child: Text(value.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24,
                                              )),
                                        ),
                                        SizedBox(height: 40),
                                        Container(
                                          height: 20,
                                          color: Colors.green[100],
                                        ),
                                        SizedBox(height: 40),
                                        Row(
                                          children: [
                                            Center(
                                              child: Text("Couleur Associé",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                  )),
                                            )
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                        ),
                                        Wrap(
                                            children:
                                                // for (var skill in value.skills) {
                                                //  Image.network(skill['url']),
                                                // }
                                                value.related
                                                    .map<Widget>((e) =>
                                                        Container(
                                                            child:
                                                                FutureBuilder(
                                                          future: airtableData
                                                              .getOneColor(e),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      List<
                                                                          AirtableDataColors>>
                                                                  snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              List<AirtableDataColors>?
                                                                  colors =
                                                                  snapshot.data;
                                                              return Column(
                                                                  children: colors!
                                                                      .map<Widget>((AirtableDataColors color) => InkWell(
                                                                        child: Column(
                                                                              children: [
                                                                                Center(child: Container(height: 120, width: 120, child: Image.network(color.image))),
                                                                                Center(
                                                                                  child: Text(color.name),
                                                                                ),
                                                                              ],
                                                                              
                                                                            ),
                                                                            onTap:
                                                                                () async {
                                                                              await Navigator.of(context).push(MaterialPageRoute(
                                                                                builder: (context) => DetailColorScreen(
                                                                                  colorId: color.id,
                                                                                  colorName: color.name,
                                                                                ),
                                                                              ));
                                                                            },
                                                                      ),
                                                                      )
                                                                      .toList());
                                                            } else {
                                                              return Center(
                                                                  child:
                                                                      CircularProgressIndicator());
                                                            }
                                                          },
                                                        )))
                                                    .toList()),
                                        SizedBox(height: 20),
                                      ],
                                    ))
                                .toList());
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              )
            ],
          ),
        ));
  }
}
