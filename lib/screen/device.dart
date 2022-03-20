import 'package:carousel_slider/carousel_slider.dart';
import 'package:colors/screen/atelier.dart';
import 'package:colors/screen/colors.dart';
import 'package:colors/screen/fig.dart';
import 'package:flutter/material.dart';
import 'infos.dart';

class DeviceScreen extends StatefulWidget {
  @override
  _DeviceScreenState createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  int _currentScreen = 0;
  final List<dynamic> _screenList = [
    "home",
    FigScreen(),
    ColorScreen(),
    AtelierScreen(),
    InfoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Colors")),
      body: screen(),
      drawer: drawer(context),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting, // Shifting
        selectedItemColor: Colors.blue.shade100,
        unselectedItemColor: Colors.green.shade100,
        onTap: (onTabTapped),
        currentIndex: _currentScreen,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Fig',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.color_lens),
              label: 'Couleur',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Atelier',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_sharp),
              label: 'Infos',
              backgroundColor: Colors.green),
        ],
      ),
    );
  }

  screen() {
    final urlImages = [
      "https://www.wargamer.com/wp-content/uploads/2021/01/painting-miniatures-guide-black-templar-lieutenant.jpg",
      "https://tabletoporder.com/wp-content/uploads/2020/05/Goblin-1.jpg",
      "https://qph.fs.quoracdn.net/main-qimg-96933c977599e05cf91d21daaa73e51b-lq"
    ];
    if (_currentScreen == 0) {
      return SingleChildScrollView(
        padding: EdgeInsets.all(5),

        ///
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              child: Stack(
                children: [
                  Container(
                      width: double.infinity,
                      child: Image.network(
                          "https://www.games-workshop.com/resources/touts/2022-02-05/GW-Chaos-2022-02-05-LPMulticol-All-bm.jpg")),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green.shade100.withOpacity(0.75)),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Schéma de couleur pour figurines",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ))
                ],
              ),
              onTap: () async {
                onTabTapped(1);
              },
            ),
            Padding(padding: EdgeInsets.all(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Stack(
                    children: [
                      Container(
                          height: 120,
                          width: 170,
                          child: Image.network(
                              "https://langagevisuel.unistra.fr/fileadmin/Contenu/1.6.Couleurs/images_couleurv2_16-retina.png")),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green.shade100.withOpacity(0.75)),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Gamme de couleur",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ))
                    ],
                  ),
                  onTap: () async {
                    onTabTapped(2);
                  },
                ),
                InkWell(
                  child: Stack(
                    children: [
                      Container(
                          height: 120,
                          width: 170,
                          child: Image.network(
                              "https://www.codeur.com/blog/wp-content/uploads/2018/06/google-maps-payant.jpg")),
                      Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green.shade100.withOpacity(0.75)),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "Nos Ateliers",
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ))
                    ],
                  ),
                  onTap: () async {
                    onTabTapped(3);
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Center(
                  child: Text("Quelque réalisation maison",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      )),
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            SizedBox(
              height: 20,
            ),
            CarouselSlider.builder(
                itemCount: urlImages.length,
                itemBuilder: (context, index, realIndex) {
                  final urlImage = urlImages[index];
                  return buildImage(urlImage, index);
                },
                options: CarouselOptions(height: 200, autoPlay: true, autoPlayAnimationDuration: Duration(seconds: 2), autoPlayInterval: Duration(seconds: 2)))
          ],
        ),
      );
    } else {
      return _screenList[_currentScreen];
    }
  }

  Drawer drawer(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            child: Text('Colors'),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              onTabTapped(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text('Figurines'),
            onTap: () {
              onTabTapped(1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.table_chart),
            title: const Text('Couleurs'),
            onTap: () {
              onTabTapped(2);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: const Text('Nos Ateliers'),
            onTap: () {
              onTabTapped(3);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: const Text('Informations'),
            onTap: () {
              onTabTapped(4);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentScreen = index;
    });
  }

  buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        color: Colors.green.shade100,
        child: Image.network(
          urlImage,
        ),
      );
}
