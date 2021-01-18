import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final MoneyMaskedTextController alturaController =
  MoneyMaskedTextController( decimalSeparator: '.',thousandSeparator: ',',initialValue: 0,precision: 2);

  final MoneyMaskedTextController pesoController =
  MoneyMaskedTextController( decimalSeparator: '.',thousandSeparator: ',',initialValue: 0,precision: 2);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _info = 'Informe seus dados';

  void _resetFields() {
    alturaController.text = '';
    pesoController.text = '';
    setState(() {
      _info = 'Informe seus dados';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    double peso = double.parse(pesoController.text);
    double altura = double.parse(alturaController.text);
    double imc = peso / (altura * altura);
    setState(() {
      if (imc < 18.6) {
        _info = 'Abaixo do Peso (IMC ${imc.toStringAsPrecision(4)})';
      } else if (imc >= 18.6 && imc < 24.9) {
        _info = 'Peso Ideal (IMC = ${imc.toStringAsPrecision(4)})';
      } else if (imc >= 24.9 && imc < 29.9) {
        _info = 'Acima do Peso (IMC = ${imc.toStringAsPrecision(4)})';
      } else if (imc >= 29.9 && imc < 34.9) {
        _info = 'Obesidade Grau I (IMC = ${imc.toStringAsPrecision(4)})';
      } else if (imc >= 34.9 && imc < 39.9) {
        _info = 'Obesidade Grau II (IMC = ${imc.toStringAsPrecision(4)})';
      } else if (imc >= 40) {
        _info = 'Obesidade Grau III (IMC = ${imc.toStringAsPrecision(4)})';
      }
    });
  }
  @override
  void initState() {
    _resetFields();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
        centerTitle: true,
        title: Text('Calculadora de IMC'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person_outline,
                size: 120,
                color: Colors.teal,
              ),
              TextFormField(
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty||double.parse(value)<=0) {
                    // ignore: missing_return
                    return "Insira seu Peso";
                  }
                },
                controller: pesoController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 25,
                ),
                decoration: InputDecoration(
                  labelText: "Peso (kg))",
                  labelStyle: TextStyle(
                    color: Colors.teal,
                  ),
                ),
              ),
              TextFormField(
                // ignore: missing_return
                validator: (value) {
                  if (value.isEmpty||double.parse(value)<=0) {
                    // ignore: missing_return
                    return "Insira sua Altura";
                  }
                },
                controller: alturaController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 25,
                ),
                decoration: InputDecoration(
                  labelText: "Altura (m))",
                  labelStyle: TextStyle(
                    color: Colors.teal,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text(
                      'Calcular',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    color: Colors.teal,
                  ),
                ),
              ),
              Text(
                _info,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.teal, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
