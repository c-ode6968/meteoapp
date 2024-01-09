import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:meteoapp/model/costanti.dart';

class AboutPage extends StatelessWidget {
  static final Costanti constants = Costanti();

  const AboutPage({Key? key});

  //Gestione  degli URL .
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url); //Conversione degli URL in Uri.
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('A Proposito'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: const EdgeInsets.only(top: 5.0),
                  child:  Image.asset(
                    'assets/icons/fog.png',
                    width: 110.0,
                    height: 110.0,
                  ),
                ),

                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  constants.presentationText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                InkWell(
                  onTap: () {
                    _launchUrl('https://github.com/toyemryan/MeteoApp');
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10.0,
                        height: 8,
                      ),
                      Text(
                        'Pagina Githup Toyem',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.none,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    _launchUrl('https://github.com/c-ode6968');
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(
                        width: 15.0,
                        height: 8,
                      ),
                      Text(
                        'Pagina Githup Lionel',
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}