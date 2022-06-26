import 'package:flutter/material.dart';
import 'package:trabajo/Listar/ListadoCursos/infoCurso.dart';
import 'package:trabajo/providers/Curso_provider.dart';

class ListCursos extends StatefulWidget {
  ListCursos({Key? key}) : super(key: key);

  @override
  State<ListCursos> createState() => _ListCursosState();
}

class _ListCursosState extends State<ListCursos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Lista de Cursos'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: CursoProvider().getCurso(),
                builder: (context, AsyncSnapshot snap){
                  if(!snap.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (_,__) => Divider(),
                    itemCount: snap.data.length,
                    itemBuilder: (context, index){
                      var cur = snap.data[index];
                        return ListTile(
                          onTap: () {
                          MaterialPageRoute route = MaterialPageRoute(builder: (context) {
                          return infcurso();
                          });
                           Navigator.push(context, route);
                          },
                          leading: CircleAvatar(
                            child: Image.network('https://thumbs.dreamstime.com/b/para-hacer-el-icono-de-la-lista-122371373.jpg')
                          ),
                          title: Container(
                            child: Row(
                              children: [
                                Text('${cur['curso']}', style: TextStyle(fontSize: 18, color: Colors.indigo),),
                                Spacer(),
                                Text('Nivel: ${cur['cod_curso']}', style: TextStyle(fontSize: 18, color: Colors.indigo),)                        
                              ],
                            ),
                          ),
                          subtitle: Text('Cantidad de alumnos:${cur['cantidad']}'),
                        );
                    },
                  );
                },
              ),
          )
        ],
      ),
    );
  }
}