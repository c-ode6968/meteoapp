import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // Action du menu
          },
        ),
      ),
      backgroundColor: const Color(0xff5842A9),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 7.0), // Espacement du haut de la page
            const Text( 'Nom de Ville', style: TextStyle(fontSize: 20.0 , color: Colors.white),
            ),
            const Text('donné meteo', style: TextStyle(fontSize: 10.0 , color: Colors.white)),
            const SizedBox(height: 10.0),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView(
                // Utilisation d'une ListView pour le défilement vertical
                children: [
                  SizedBox(
                    height: 300.0,
                    child: Card(
                      color: Colors.cyan,
                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15.0),),
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.only(top: 20.0, left: 30.0),
                        title: const Text(
                          'Vendredi',
                          style: TextStyle(color: Colors.black),
                        ),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text( '50 °C',  style: TextStyle(
                                        fontSize: 50.0, color: Colors.amber),
                                  ),
                                  const SizedBox( width: 70), // Espacement entre le texte et la première image
                                  Image.asset(
                                    'assets/icons/fog.png',
                                    width: 90, // Ajustez la taille de la première image
                                    height: 90,
                                  ),
                                ],
                              ),
                              const Row(
                                children: [
                                  Text('Fell like: 10 °C'),
                                ],
                              ),
                              const SizedBox(height: 30),
                              const SizedBox(
                                  height: 20), // Espacement entre les éléments
                              Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        'assets/icons/fog.png',
                                        width:  50, // Ajustez la taille de la première image
                                        height: 50,
                                      ),
                                      const SizedBox(
                                          height:
                                              5), // Espace entre l'image et le texte
                                      const Text('100 %'),
                                      const Text('Pioggia'),
                                    ],
                                  ),
                                  const SizedBox(
                                      width: 35), // Espacement entre les images
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/icons/fog.png',
                                        width:  50, // Ajustez la taille de la deuxième image
                                        height: 50,
                                      ),
                                      const SizedBox(
                                          height:  5), // Espace entre l'image et le texte
                                      const Text('4 km/h'),
                                      const Text('Velocità del vento'),
                                    ],
                                  ),
                                  const SizedBox( width: 35), // Espacement entre les images
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/icons/fog.png',
                                        width: 50, // Ajustez la taille de la troisième image
                                        height: 50,
                                      ),
                                      const SizedBox(
                                          height: 5), // Espace entre l'image et le texte
                                      const Text('100 %'),
                                      const Text('Humidità'),
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                        onTap: () {
                          // Action lors du tap sur la carte 1
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  // ignore: prefer_const_constructors
                  Center(child: const Text('Durante le giornata', style: TextStyle(fontSize: 20.0, color: Colors.white ),),),
                  const SizedBox(height: 20.0),

                  // Deuxieme card
                  SizedBox(
                  height: 200.0,
                  child: Card(
                    color: Colors.cyan,
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Centre verticalement
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200.0, 
                          // Hauteur pour les images
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 20, // Nombre total d'images à afficher
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center, // Centre verticalement
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    
                                    const Text('20:00', style: TextStyle(fontSize: 18),), 
                                    const SizedBox(height: 20.0),
                                    Image.asset(
                                      'assets/icons/fog.png',
                                      width: 80.0, // largeur des images
                                      height: 80.0, //  hauteur des images
                                    ),
                                    const SizedBox(height: 20.0),
                                    const Text('10 °C', style: TextStyle(fontSize: 18),),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                  const SizedBox(height: 10.0,),
                  // ignore: prefer_const_constructors
                  Center(child: const Text('Previsioni 5 giorni', style: TextStyle(fontSize: 20.0, color: Colors.white ),),),
                  const SizedBox(height: 20.0),

                  // Troisieme card
                  SizedBox(
                    height: 300.0,
                    child: Card(
                      color: Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0), // Ajustez la valeur du rayon pour changer l'arrondi
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: ListTile(
                        title: const Text('Card 3'),
                        subtitle: const Text('Description 3'),
                        onTap: () {
                          // Action lors du tap sur la carte 3
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0,),
                  // ignore: prefer_const_constructors
                  Center(child: const Text('Magiori informazioni sulla giornata', style: TextStyle(fontSize: 20.0, color: Colors.white ),),),
                  const SizedBox(height: 20.0),

                  // quatrieme card
                  SizedBox(
                    height: 300.0,
                    width: 120.0,
                    child: Card(
                      color: Colors.cyan,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0), // Ajustez la valeur du rayon pour changer l'arrondi
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 30.0,),
                      child: ListTile(
                        title: const Text('Card 4'),
                        subtitle: const Text('Description 4'),
                        onTap: () {
                          // Action lors du tap sur la carte 4
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 150.0), // Ajoutez l'espacement vertical ici
                  const Text('Autre contenu en dessous de la carte'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
