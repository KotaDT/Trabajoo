import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

class EducadorasProvider {
  final String apiURL = 'http://10.0.2.2:8000/api';

  Future<List<dynamic>> getEducadoras() async {
    var uri = Uri.parse('$apiURL/educadoras');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<LinkedHashMap<String, dynamic>> getEducadora(String codTia) async {
    var uri = Uri.parse('$apiURL/educadoras/$codTia');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  Future<LinkedHashMap<String, dynamic>> educadorasEditar(String cod_tia,
      String cod_tia_nuevo, String nombre, int telefono, String nivel) async {
    var uri = Uri.parse('$apiURL/educadoras/$cod_tia');
    var respuesta = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'cod_tia': cod_tia,
          'cod_tia_nuevo': cod_tia_nuevo,
          'nombre': nombre,
          'telefono': telefono,
          'cod_curso': nivel
        }));

    return json.decode(respuesta.body);
  }

  Future<LinkedHashMap<String, dynamic>> educadorasAgregar(
      String cod_tia, String nombre, int telefono, String nivel) async {
    var uri = Uri.parse('$apiURL/educadoras');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'cod_tia': cod_tia,
          'nombre': nombre,
          'telefono': telefono,
          'cod_curso': nivel
        }));

    return json.decode(respuesta.body);
  }

  Future<bool> educadorasBorrar(String cod_tia) async {
    var uri = Uri.parse('$apiURL/educadoras/$cod_tia');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }
}
