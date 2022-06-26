import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:trabajo/Gestion/Profesores/educadoras_editar.dart';
import 'package:trabajo/Gestion/Profesores/educadoras_agregar.dart';
import 'package:trabajo/providers/educadoras_provider.dart';

class Profesores extends StatefulWidget {
  Profesores({Key? key}) : super(key: key);

  @override
  State<Profesores> createState() => _ProfesoresState();
}

class _ProfesoresState extends State<Profesores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de educadoras'),
        backgroundColor: Color.fromARGB(255, 186, 53, 97),
      ),
      body: Padding(
        padding: EdgeInsets.all(6),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: EducadorasProvider().getEducadoras(),
                builder: (context, AsyncSnapshot snap) {
                  if (!snap.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      var tia = snap.data[index];
                      return Slidable(
                        child: ListTile(
                          leading: Icon(Icons.favorite),
                          title: Text(
                            '${tia['nombre']}',
                            style:
                                TextStyle(fontSize: 18, color: Colors.indigo),
                          ),
                          subtitle: Text('Telefono: ${tia['telefono']}'),
                          trailing: Text(tia['cod_curso']),
                        ),
                        startActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) =>
                                      EducadoraEditarPage(tia['cod_tia']),
                                );
                                Navigator.push(context, route).then((value) {
                                  setState(() {});
                                });
                              },
                              backgroundColor:
                                  Color.fromARGB(255, 193, 113, 255),
                              icon: Icons.edit_note,
                              label: 'Editar',
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                String cod_tia = tia['cod_tia'];
                                String nombre = tia['nombre'];

                                confirmDialog(context, nombre).then((confirma) {
                                  if (confirma) {
                                    //borrar
                                    EducadorasProvider()
                                        .educadorasBorrar(cod_tia)
                                        .then((borradoOk) {
                                      if (borradoOk) {
                                        //pudo borrar
                                        snap.data.removeAt(index);
                                        setState(() {});
                                        showSnackbar(
                                            'Educadora $nombre borrado');
                                      } else {
                                        //no pudo borrar
                                        showSnackbar(
                                            'No se pudo borrar la funcionaria');
                                      }
                                    });
                                  }
                                });
                              },
                              backgroundColor: Colors.red,
                              icon: Icons.delete,
                              label: 'Borrar',
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            //boton agregar
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Agregar Educadora'),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.pinkAccent)),
                onPressed: () {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) {
                    return EducadorasAgregar();
                  });

                  Navigator.push(context, route).then((value) {
                    print('ACTUALIZAR PAGINA');
                    setState(() {});
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackbar(String mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(mensaje),
      ),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context, String nombre) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar borrado'),
          content: Text('¿Borrar la funcionaria $nombre?'),
          actions: [
            TextButton(
              child: Text('CANCELAR'),
              onPressed: () => Navigator.pop(context, false),
            ),
            ElevatedButton(
              child: Text('ACEPTAR'),
              onPressed: () => Navigator.pop(context, true),
            ),
          ],
        );
      },
    );
  }
}
