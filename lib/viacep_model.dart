class ViacepModel {
  String cep = '';
  String logradouro = '';
  String bairro = '';
  String localidade = '';
  String uf = '';

  ViacepModel(
      {required this.cep,
      required this.logradouro,
      required this.bairro,
      required this.localidade,
      required this.uf});

  ViacepModel.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
    logradouro = json['logradouro'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    return data;
  }
}
