import 'dart:convert';

import 'package:diocabheocda/viacep_model.dart';
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
  bool carregando = false;

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
                    setState(() {
                      carregando = true;
                    });
                    print(value);
                    var response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));
                    var json = jsonDecode(response.body);
                    var objetoViacep = ViacepModel.fromJson(json);
                    setState(() {
                      carregando = false;
                      rua = objetoViacep.logradouro ?? '';
                      cidade = objetoViacep.localidade ?? '';
                      estado = objetoViacep.uf ?? '';
                    }); 
                  } else {
                    setState(() {
                      rua = '';
                      cidade = '';
                      estado = '';
                      carregando = false;
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
              Visibility(
                visible: carregando,
                child: CircularProgressIndicator()
              ),
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
