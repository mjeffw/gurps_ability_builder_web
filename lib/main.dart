import 'package:flutter_web/material.dart';
import 'package:gurps_ability_builder_web/screens/ability_builder.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == AbilityBuilder.routeName) {
          return MaterialPageRoute(builder: (context) {
            return AbilityBuilder();
          });
        }
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Hello, World!'),
            RaisedButton(
              child: Text('Ability Builder'),
              onPressed: () {
                Navigator.pushNamed(context, AbilityBuilder.routeName);
              },
            )
          ],
        ),
      ),
    );
  }
}
