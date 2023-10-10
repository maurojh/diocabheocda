import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TesteHttp extends StatefulWidget {
  const TesteHttp({super.key});

  @override
  State<TesteHttp> createState() => _TesteHttpState();
}

class _TesteHttpState extends State<TesteHttp> {
  TextEditingController controlaCEP = TextEditingController();
  String rua = '';
  String cidade = '';
  String estado = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              const Text(
                'Consulta de CEP',
                style: TextStyle(fontSize: 22),
              ),
              TextField(
                controller: controlaCEP,
                onChanged: (String value) async {
                  var cep = value.trim().replaceAll('-', '');
                  if (cep.length == 8) {
                    print(value);
                    var response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
                    print(response.body);
                    print(response.statusCode);
                  } else {
                    setState(() {
                      rua = '';
                      cidade = '';
                      estado = '';
                    });
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Text('Rua: $rua'),
              const SizedBox(
                height: 50,
              ),
              Text('Cidade: $cidade'),
              const SizedBox(
                height: 50,
              ),
              Text('Estado: $estado'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {},
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
