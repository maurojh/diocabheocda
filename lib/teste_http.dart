import 'dart:convert';

import 'package:diocabheocda/viacep_model.dart';
import 'package:diocabheocda/viacep_repository.dart';
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
  ViacepModel objetoViacep =
      ViacepModel(cep: '', logradouro: '', localidade: '', bairro: '', uf: '');

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
                    objetoViacep = await ViacepRepository().consultarCEP(cep);
                    setState(() {
                      carregando = false;
                    });
                  } else {
                    setState(() {
                      carregando = false;
                    });
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Text('Rua: ${objetoViacep.logradouro ?? ''}'),
              const SizedBox(
                height: 50,
              ),
              Text('Cidade: ${objetoViacep.localidade ?? ''}'),
              const SizedBox(
                height: 50,
              ),
              Text('Estado: ${objetoViacep.uf ?? ''}'),
              Visibility(
                  visible: carregando,
                  child: const CircularProgressIndicator()),
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
