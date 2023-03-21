import 'package:flutter/material.dart';
import 'package:random_password_generator/random_password_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isWithLetters = true;
  bool _isWithUppercase = false;
  bool _isWithNumbers = false;
  bool _isWithSpecial = false;
  double _numberCharPassword = 8;
  String newPassword = '';
  Color _color = Colors.blue;
  String isOk = '';
  TextEditingController _passwordLength = TextEditingController();
  final password = RandomPasswordGenerator();
  @override
  void initState() {
    super.initState();
  }

  checkBox(String name, Function onTap, bool value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(name), 

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Generador de Contraseñas Aleatorias'),
        ),
        body: Center(
            child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                checkBox('Mayusculas', (bool value) {
                  _isWithUppercase = value;
                  setState(() {});
                }, _isWithUppercase),
                checkBox('Minusculas', (bool value) {
                  _isWithLetters = value;
                  setState(() {});
                }, _isWithLetters)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                checkBox('Caracteres Especiales', (bool value) {
                  _isWithSpecial = value;
                  setState(() {});
                }, _isWithSpecial),
                checkBox('Numeros', (bool value) {
                  _isWithNumbers = value;
                  setState(() {});
                }, _isWithNumbers)
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _passwordLength,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  ),
                  filled: true,
                  fillColor: Colors.grey[300],
                  labelText: 'Introduzca la longitud de la contraseña',
                  labelStyle: TextStyle(color: Colors.blue),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FlatButton(
                onPressed: () {
                  if (_passwordLength.text.trim().isNotEmpty)
                    _numberCharPassword =
                        double.parse(_passwordLength.text.trim());

                  newPassword = password.randomPassword(
                      letters: _isWithLetters,
                      numbers: _isWithNumbers,
                      passwordLength: _numberCharPassword,
                      specialChar: _isWithSpecial,
                      uppercase: _isWithUppercase);

                  print(newPassword);
                  double passwordstrength =
                      password.checkPassword(password: newPassword);
                  if (passwordstrength < 0.3) {
                    _color = Colors.red;
                    isOk = 'Esta contraseña es debil';
                  } else if (passwordstrength < 0.7) {
                    _color = Colors.blue;
                    isOk = 'Esta contraseña esta bien';
                  } else {
                    _color = Colors.green;
                    isOk = 'Esta contraseña es fuerte';
                  }

                  setState(() {});
                },
                child: Container(
                  color: Colors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Generar',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            if (newPassword.isNotEmpty && newPassword != null)
              Center(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isOk,
                    style: TextStyle(color: _color, fontSize: 25),
                  ),
                ),
              )),
            if (newPassword.isNotEmpty && newPassword != null)
              Center(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    newPassword,
                    style: TextStyle(color: _color, fontSize: 25),
                  ),
                ),
              ))
          ],
        )),
      ),
    );
  }
}