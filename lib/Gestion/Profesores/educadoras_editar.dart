import 'package:flutter/material.dart';
import 'package:trabajo/providers/educadoras_provider.dart';

import '../../providers/curso_provider.dart';

class EducadoraEditarPage extends StatefulWidget {
  String codTia;
  EducadoraEditarPage(this.codTia, {Key? key}) : super(key: key);

  @override
  State<EducadoraEditarPage> createState() => _EducadoraEditarPageState();
}

class _EducadoraEditarPageState extends State<EducadoraEditarPage> {
  TextEditingController codigoCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController nivelCtrl = TextEditingController();
  String newCurso = "";
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Educadora'),
        backgroundColor: Color.fromARGB(255, 186, 53, 97),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: FutureBuilder(
            future: EducadorasProvider().getEducadora(widget.codTia),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var data = snapshot.data;
              codigoCtrl.text = data['cod_tia'];
              nombreCtrl.text = data['nombre'];
              telefonoCtrl.text = data['telefono'].toString();
              nivelCtrl.text = data['cod_curso'];

              return Form(
                key: formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: codigoCtrl,
                      decoration: InputDecoration(labelText: 'Código'),
                    ),
                    TextFormField(
                      controller: nombreCtrl,
                      decoration: InputDecoration(labelText: 'Nombre'),
                    ),
                    TextFormField(
                      controller: telefonoCtrl,
                      decoration: InputDecoration(labelText: 'Telefono'),
                    ),
                    //Container(
                    //  padding: EdgeInsets.all(30),
                     // width: double.infinity,
                    //  child: Text(
                     //   'Curso actual: ${nivelCtrl.text}',
                     //   style: TextStyle(
                      //      fontSize: 19,
                      //      fontWeight: FontWeight.bold,
                       //     color: Color.fromARGB(255, 244, 40, 17)),
                      //),
                    //),
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
                          hint: Text(nivelCtrl.text),
                          items: cursos.map<DropdownMenuItem<String>>((curso) {
                            return DropdownMenuItem<String>(
                              child: Text(curso['curso']),
                              value: curso['curso'],
                            );
                          }).toList(),
                          //value: cursos.isEmpty ? null : cursos,
                          onChanged: (dropdownValueSelected) {
                            setState(() {
                              newCurso = dropdownValueSelected.toString();
                            });
                          },
                        );
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text('Editar'),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.pinkAccent)),
                        onPressed: () {
                          EducadorasProvider().educadorasEditar(
                            widget.codTia,
                            codigoCtrl.text.trim(),
                            nombreCtrl.text.trim(),
                            int.tryParse(telefonoCtrl.text.trim()) ?? 0,
                            newCurso.trim(), //change
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
