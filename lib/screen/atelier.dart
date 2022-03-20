import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';

class AtelierScreen extends StatefulWidget {
  @override
  State<AtelierScreen> createState() => _AtelierScreenState();
}

class _AtelierScreenState extends State<AtelierScreen> {
  final PopupController _popupController = PopupController();
  final MapController _mapController = MapController();
  final double _zoom = 12;
  final List<List> _latLngList = [
    [LatLng(48.872536, 2.331355), const Key("1 rue random")],
    [LatLng(48.886452, 2.343121), const Key("21 rue Aléatoire")],
    [LatLng(48.85720129616661, 2.281173537722867), const Key("10 rue Lyautey")]
  ];
  List<Marker> _markers = [];

  @override
  void initState() {
    _markers = _latLngList
        .map((point) => Marker(
              key: point[1],
              point: point[0],
              width: 40,
              height: 40,
              builder: (context) => const Icon(
                Icons.pin_drop,
                size: 40,
                color: Colors.blueAccent,
              ),
            
            ))
        .toList();
    print(_markers.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: SingleChildScrollView(
        ///
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              child: Stack(children: [
                Image.network(
                    "https://global-img.gamergen.com/warhammer-age-of-sigmar-head-2_0900951535.jpg"),
                Center(
                  child: Row(
                    children: [
                      Center(
                        child: Text("Nos Ateliers de peinture",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: Colors.white)),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ]),
            ),
            Container(
              color: Colors.green,
              height: 450,
              child: FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  zoom: _zoom,
                  center: LatLng(48.866667, 2.333333),
                  plugins: [
                    MarkerClusterPlugin(),
                  ],
                  onTap: (lat, long) => _popupController.hideAllPopups(),
                ),
                layers: [
                  TileLayerOptions(
                    minZoom: 2,
                    maxZoom: 18,
                    backgroundColor: Colors.black,
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerClusterLayerOptions(
                    maxClusterRadius: 190,
                    disableClusteringAtZoom: 16,
                    size: const Size(50, 50),
                    fitBoundsOptions: const FitBoundsOptions(
                      padding: EdgeInsets.all(50),
                    ),
                    markers: _markers,
                    polygonOptions: const PolygonOptions(
                        borderColor: Colors.blueAccent,
                        color: Colors.black12,
                        borderStrokeWidth: 3),
                    popupOptions: PopupOptions(
                        popupSnap: PopupSnap.markerTop,
                        popupController: _popupController,
                        popupBuilder: (_, marker) => Container(
                              color: Colors.amberAccent,
                              child: Text(marker.key.toString().replaceAll("[<'", "").replaceAll("'>]", ""),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  )),
                            )),
                    builder: (context, markers) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            color: Colors.orange, shape: BoxShape.circle),
                        child: Text('${markers.length}'),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
