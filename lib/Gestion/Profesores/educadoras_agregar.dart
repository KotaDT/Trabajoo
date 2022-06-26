import 'package:flutter/material.dart';
import 'package:trabajo/providers/curso_provider.dart';
import 'package:trabajo/providers/educadoras_provider.dart';

class EducadorasAgregar extends StatefulWidget {
  EducadorasAgregar({Key? key}) : super(key: key);

  @override
  State<EducadorasAgregar> createState() => _EducadorasAgregarState();
}

//todo  combobox curso
//editar

class _EducadorasAgregarState extends State<EducadorasAgregar> {
  final formKey = GlobalKey<FormState>();
  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController nivelCtrl = TextEditingController();

  String errCodigo = '';
  String errNombre = '';
  String errTelefono = '';
  String errNivel = '';
  String selectedCurso = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Educadoras'),
        backgroundColor: Color.fromARGB(255, 186, 53, 97),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextFormField(
                controller: codigoCtrl,
                decoration: InputDecoration(labelText: 'Código'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errCodigo,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: nombreCtrl,
                decoration:
                    InputDecoration(labelText: 'Nombre de la educadora'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errNombre,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: telefonoCtrl,
                decoration: InputDecoration(labelText: 'Telefono'),
                keyboardType: TextInputType.number,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errTelefono,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              FutureBuilder(
                future: CursoProvider().getCurso(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (!snapshot.hasData) {
                    return DropdownButtonFormField<String>(
                      hint: Text('Cargando Cursos...'),
                      items: [],
                      onChanged: (valor) {},
                    );
                  }
                  var cursos = snapshot.data;
                  return DropdownButtonFormField<String>(
                    hint: Text('Seleccionar curso'),
                    items: cursos.map<DropdownMenuItem<String>>((curso) {
                      return DropdownMenuItem<String>(
                        child: Text(curso['curso']),
                        value: curso['curso'],
                      );
                    }).toList(),
                    //value: cursos.isEmpty ? null : cursos,
                    onChanged: (nuevoCurso) {
                      setState(() {
                        cursos = nuevoCurso.toString();
                        selectedCurso = nuevoCurso.toString();
                        print(selectedCurso);
                      });
                    },
                  );
                },
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errNivel,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('Agregar Educadora'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.pinkAccent)),
                  onPressed: () async {
                    int telefono = int.tryParse(telefonoCtrl.text) ?? 0;

                    var respuesta =
                        await EducadorasProvider().educadorasAgregar(
                      codigoCtrl.text.trim(),
                      nombreCtrl.text.trim(),
                      telefono,
                      selectedCurso.trim(),
                    );

                    /*if (respuesta['message'] != null) {
                   
                    if (respuesta['errors']['cod_tia'] != null) {
                      errCodigo = respuesta['errors']['cod_tia'][0];
                    } else {
                      errCodigo = '';
                    }
                  }
                  if (respuesta['message'] != null) {
                    if (respuesta['errors']['nombre'] != null) {
                      errNombre = respuesta['errors']['nombre'][0];
                    } else {
                      errNombre = '';
                    }
                  }
                  if (respuesta['message'] != null) {
                    if (respuesta['errors']['telefono'] != null) {
                      errTelefono = respuesta['errors']['telefono'][0];
                    } else {
                      errTelefono = '';
                    }
                  }
                  if (respuesta['message'] != null) {
                    if (respuesta['errors']['cod_curso'] != null) {
                      errNivel = respuesta['errors']['cod_curso'][0];
                    } else {
                      errNivel = '';
                    }
                      setState(() {});
                      return;
                    }*/
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
