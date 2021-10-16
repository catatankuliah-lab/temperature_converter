import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Pineapple's Temprature Converter",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  TextEditingController dataSuhu = TextEditingController();
  TextEditingController dataC = TextEditingController();
  TextEditingController dataR = TextEditingController();
  TextEditingController dataF = TextEditingController();
  TextEditingController dataK = TextEditingController();

  String appBarTitle = "Pineapple's Temprature Converter";
  double source = 0;
  double C = 0;
  double R = 0;
  double F = 0;
  double K = 0;

  double bacaDataSource() {
    source = double.parse(dataSuhu.text);
    return source;
  }

  void konversiC() {
    setState(() {
      C = bacaDataSource();
      R = bacaDataSource() * 4 / 5;
      F = (9 / 5 * bacaDataSource()) + 32;
      K = bacaDataSource() + 273.15;
    });
  }

  void konversiR() {
    setState(() {
      C = 5 / 4 * bacaDataSource();
      R = bacaDataSource();
      F = (9 / 4 * bacaDataSource()) + 32;
      K = (5 / 4 * bacaDataSource()) + 273.15;
    });
  }

  void konversiF() {
    setState(() {
      C = 5 / 9 * (bacaDataSource() - 32);
      R = 4 / 9 * (bacaDataSource() - 32);
      F = bacaDataSource();
      K = 5 / 9 * (bacaDataSource() - 459.67);
    });
  }

  void konversiK() {
    setState(() {
      C = bacaDataSource() - 273.15;
      R = 4 / 5 * (bacaDataSource() - 273.15);
      F = (9 / 5 * bacaDataSource()) - 459.67;
      K = bacaDataSource();
    });
  }

  void setHasil() {
    dataC.text = C.toString();
    dataR.text = R.toString();
    dataF.text = F.toString();
    dataK.text = K.toString();
  }

  void clearHasil() {
    dataC.text = "";
    dataR.text = "";
    dataF.text = "";
    dataK.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: dataSuhu,
                onChanged: (clear) {
                  clearHasil();
                },
                keyboardType: const TextInputType.numberWithOptions(),
                decoration: const InputDecoration(
                  labelText: "Input Suhu",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownSearch<String>(
                mode: Mode.MENU,
                showSelectedItems: true,
                items: const ["Celcius", "Fahrenheit", "Kelvin", "Rearmur"],
                // ignore: deprecated_member_use
                label: "Satuan",
                onChanged: (val) {
                  if (val == "Celcius") {
                    konversiC();
                    setHasil();
                  } else if (val == "Fahrenheit") {
                    konversiF();
                    setHasil();
                  } else if (val == "Kelvin") {
                    konversiK();
                    setHasil();
                  } else if (val == "Rearmur") {
                    konversiR();
                    setHasil();
                  }
                },
                selectedItem: "Celcius",
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: dataC,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Celcius (°C)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: dataR,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Rearmur (°R)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: dataF,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Fahrenhite (°F)",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                controller: dataK,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Kelvin (°K)",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
