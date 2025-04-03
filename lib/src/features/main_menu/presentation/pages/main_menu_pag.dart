import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  @override
  MainMenuState createState() => MainMenuState();
}

class MainMenuState extends State<MainMenuPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [

      ],
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text('Data'),
            Text("test")
          ],
        ),
      ),
    );
  }

}