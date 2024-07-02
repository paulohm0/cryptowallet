import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Perfil',
      ),
      body: Center(
        child: Text(
          'Informações do Perfil',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
