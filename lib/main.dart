import "package:flutter/material.dart";

void main() {
  runApp(MaterialApp(title: "Calculadora de IMC", home: Home()));
}

//Criar stateful

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _title = "Calculadora de IMC";

  //Controllers
  //(we can add those classes like functions, there's no necessity on using new before)
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  //Form validation
  //Declare new class GlobalKey
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //Strings

  String _infoText = "Informe seus dados";

  //resetar campos

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if (imc < 18.6) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 18.6 && imc < 24.9) {
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText = "Levemente Acima do Peso (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if (imc >= 40) {
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$_title"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(Icons.person_outline_sharp,
                    size: 120, color: Colors.lightGreen),
                TextFormField(
                  // ignore: missing_return
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira seu Peso!";
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  controller: weightController,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
                TextFormField(
                  // ignore: missing_return
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira sua Altura!";
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green, fontSize: 25),
                  ),
                  controller: heightController,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 25),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      height: 50,
                      child: RaisedButton(
                          child: Text("Calcular",
                              style:
                                  TextStyle(fontSize: 25, color: Colors.white)),
                          onPressed: (){
                            if(_formKey.currentState.validate()){
                              _calculate();
                            }
                          },
                          color: Colors.green),
                    )),
                Text(_infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25))
              ],
            ),
          )),
    );
  }
}
