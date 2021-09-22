import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const request =
    "https://api.hgbrasil.com/finance?format=json-cors&key=eddb874c";
void main() async {
  http.Response response = await http.get(Uri.parse(request));
  //print(json.decode(response.body)["results"]["currencies"] ["USD"]);
  //print(await getData());

  runApp(MaterialApp(
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}

Future<Map<dynamic, dynamic>> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final double dolar;
  late final double euro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "\$ Conversor \$",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando Dados",
                  style: TextStyle(color: Colors.amber, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Erro ao carregar os Dados",
                    style: TextStyle(color: Colors.amber, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                );
              } else {
                dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.monetization_on,
                        size: 150,
                        color: Colors.amber,
                      ),
                      Divider(),
                      TextField(
                        style: TextStyle(color: Colors.amber, fontSize: 25),
                        decoration: InputDecoration(
                            labelText: "Reais",
                            labelStyle:
                                TextStyle(color: Colors.amber, fontSize: 25),
                            border: OutlineInputBorder(),
                            prefixText: "R\$"),
                      ),
                      Divider(),
                      TextField(
                        style: TextStyle(color: Colors.amber, fontSize: 25),
                        decoration: InputDecoration(
                            labelText: "Dólares",
                            labelStyle:
                                TextStyle(color: Colors.amber, fontSize: 25),
                            border: OutlineInputBorder(),
                            prefixText: "US\$"),
                      ),
                      Divider(),
                      TextField(
                        style: TextStyle(color: Colors.amber, fontSize: 25),
                        decoration: InputDecoration(
                            labelText: "Euros",
                            labelStyle:
                                TextStyle(color: Colors.amber, fontSize: 25),
                            border: OutlineInputBorder(),
                            prefixText: "£"),
                      ),
                      Divider(),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}
