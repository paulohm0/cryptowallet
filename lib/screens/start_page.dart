import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _MyStartPageState();
}

class _MyStartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Image.asset(
                  'assets/titlehomepage.png',
                  width: 200,
                  height: 100,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Image.asset(
                'assets/imagehomepage.png',
                width: 400,
                height: 400,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.only(left: 16.0, right: 16),
              child: const Column(
                children: [
                  Text(
                    'Seu portfólio de Criptomoedas',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Leve seu portfólio de investimentos para o proximo nível',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.amberAccent),
              ),
              onPressed: () {
                Navigator.pushNamed(context, 'homepage');
              },
              child: const SizedBox(
                width: 330,
                height: 50,
                child: Center(
                  child: Text(
                    'Vamos lá !',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
