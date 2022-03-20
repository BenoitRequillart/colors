import 'package:colors/model/airtable_colors_fig.dart';
import 'package:colors/model/airtable_data_fig.dart';
import 'package:colors/models/airtable_colors_fig.dart';
import 'package:colors/models/airtable_data_fig.dart';
import 'package:flutter/material.dart';

import 'detail_color.dart';

class DetailFigScreen extends StatelessWidget {
  final String figId;
  final String figName;
  const DetailFigScreen({Key? key, required this.figId, required this.figName})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final AirtableData airtableData = AirtableData();
    final AirtableDataColorModel airtableColor = AirtableDataColorModel();
    return Scaffold(
        appBar: AppBar(
          title: Text(figName,
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
                    future: airtableData.getOneFig(figId),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<AirtableDataFig>> snapshot) {
                      if (snapshot.hasData) {
                        List<AirtableDataFig>? values = snapshot.data;
                        return Column(
                            children: values!
                                .map<Widget>((AirtableDataFig value) => Column(
                                      children: [
                                        Center(
                                            child: Image.network(value.image)),
                                        SizedBox(height: 40),
                                        Center(
                                          child: Text(value.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24,
                                              )),
                                        ),
                                        Wrap(
                                            children:
                                                // for (var skill in value.skills) {
                                                //  Image.network(skill['url']),
                                                // }
                                                value.colors
                                                    .map<Widget>((e) =>
                                                        Container(
                                                            child:
                                                                FutureBuilder(
                                                          future: airtableColor
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
                                                                                SizedBox(height: 20),
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
                                                                      ))
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
