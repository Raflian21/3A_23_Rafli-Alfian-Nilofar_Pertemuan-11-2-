import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class Suhu extends StatelessWidget {
  const Suhu({
    Key? key,
    required this.selctDropdown,
    required this.listSuhu,
    required this.onDropChange,
  }) : super(key: key);

  final String selctDropdown;
  final List<String> listSuhu;
  final Function onDropChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: DropdownButton(
          value: selctDropdown,
          isExpanded: true,
          items: listSuhu.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            onDropChange(value);
          }),
    );
  }
}

class HistorySuhu extends StatelessWidget {
  const HistorySuhu({
    Key? key,
    required this.riwayat,
  }) : super(key: key);

  final List<String> riwayat;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            itemCount: riwayat.length,
            itemBuilder: (context, index) {
              return Text(riwayat[index]);
            }));
  }
}

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.Kversi,
  }) : super(key: key);

  final Function Kversi;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                Kversi();
              },
              child: Text(
                "Konversi",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // TextEditingController text1 = TextEditingController();
  double kelvin = 0, reamor = 0, input = 0;
  double hasil = 0;
  double valueSuhu = 50;

  TextEditingController suhu = TextEditingController();

  String selctDropdown = "Reamur";
  List<String> listSuhu = ["Kelvin", "Reamur", "Fahrenheit"];
  List<String> History = [];

  void onDropChange(Object? value) {
    return setState(() {
      selctDropdown = value.toString();
      //Jika Click SelectDropDown akan langsung menampilkan hasilnya di Daftar History
      if (suhu.text.isNotEmpty) {
        switch (selctDropdown) {
          case "Kelvin":
            hasil = int.parse(suhu.text) + 273;

            break;

          case "Reamur":
            hasil = int.parse(suhu.text) * 4 / 5;
            break;

          case "Fahrenheit":
            hasil = int.parse(suhu.text) * 9 / 5 + 32;
            break;
          default:
        }
        History.add("Konversi suhu dari " +
            suhu.text +
            " derajat Celcius Ke " +
            selctDropdown +
            " dengan hasil konversi " +
            hasil.toString());
      }
    });
  }

  void Konversi() {
    return setState(() {
      if (suhu.text.isNotEmpty) {
        switch (selctDropdown) {
          case "Kelvin":
            hasil = int.parse(suhu.text) + 273;

            break;

          case "Reamur":
            hasil = int.parse(suhu.text) * 4 / 5;
            break;

          case "Fahrenheit":
            hasil = int.parse(suhu.text) * 9 / 5 + 32;
            break;
          default:
        }
        History.add("Konversi suhu Dari " +
            suhu.text +
            " derajat Celcius Ke " +
            selctDropdown +
            " dengan hasil konversi " +
            hasil.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Konversi Suhu')),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 10, top: 10),
          child: Column(
            children: [
              Slider(
                value: valueSuhu,
                max: 100,
                divisions: 100,
                label: valueSuhu.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    valueSuhu = value;
                    suhu.text = valueSuhu.toString();
                  });
                },
              ),
              // Inputan(text1: text1),
              Suhu(
                selctDropdown: selctDropdown,
                listSuhu: listSuhu,
                onDropChange: onDropChange,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Hasil Konversi',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              ),
              Text(
                "$hasil",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 30,
              ),
              Button(
                Kversi: Konversi,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Riwayat Konversi ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              HistorySuhu(riwayat: History)
            ],
          ),
        ),
      ),
    );
  }
}
