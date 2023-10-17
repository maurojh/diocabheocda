import 'dart:convert';

import 'package:diocabheocda/viacep_model.dart';
import 'package:http/http.dart' as http;

class ViacepRepository {
  Future<ViacepModel> consultarCEP(String cep) async {
    var response =
        await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return ViacepModel.fromJson(json);
    } else {
      return ViacepModel(
          cep: '', logradouro: '', localidade: '', bairro: '', uf: '');
    }
  }
}
