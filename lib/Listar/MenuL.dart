import 'package:flutter/material.dart';
import 'package:trabajo/Listar/ListadoCursos/ListCursos.dart';
import 'package:trabajo/providers/Curso_provider.dart';

class MenuL extends StatefulWidget {
  MenuL({Key? key}) : super(key: key);

  @override
  State<MenuL> createState() => _MenuLState();
}

class _MenuLState extends State<MenuL> {
  final double iconHeight = 144;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.android),
        title: Text('Menu de gestión'),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: [
          /*Container(
            height: 40,
            width: double.infinity,
            color: Colors.indigo,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Pinches Juegos',style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold),)
              ]),
          ),*/
          Expanded(
            child: ListView(
              children: [
                curso(),
                Divider(),
                /*profesores(),
                Divider(),
                kids()*/
              ],
            ))
        ],
      ),
    );
  }



  ListTile curso (){
    return ListTile(
      onTap: () {
      MaterialPageRoute route = MaterialPageRoute(builder: (context) {
        return ListCursos();
      });
      Navigator.push(context, route);
      },
      leading:CircleAvatar(
        child: Image.network('https://www.netacad.com/sites/default/files/images/educator/icon-download-250.png'),
        radius: iconHeight / 4,
      ),
      title: Text('Listado de cursos', style: TextStyle(fontSize: 20),),
    );

  }


  /*ListTile profesores (){
    return ListTile(
      onTap: () {
      MaterialPageRoute route = MaterialPageRoute(builder: (context) {
        return Profesores();
      });
      Navigator.push(context, route);
      },
      leading:CircleAvatar(
        child: Image.network('https://png.pngtree.com/png-vector/20190712/ourlarge/pngtree-user-management-icon-trendy-style-isolated-background-png-image_1542354.jpg'),
        radius: iconHeight / 4,
      ),
      title: Text('Profesores', style: TextStyle(fontSize: 20),),
    );

  }

  ListTile kids (){
    return ListTile(
      onTap: () {
      MaterialPageRoute route = MaterialPageRoute(builder: (context) {
        return Kids();
      });
      Navigator.push(context, route);
      },
      leading:CircleAvatar(
        child: Image.network('https://png.pngtree.com/png-vector/20190712/ourlarge/pngtree-user-management-icon-trendy-style-isolated-background-png-image_1542354.jpg'),
        radius: iconHeight / 4,
      ),
      title: Text('Niños', style: TextStyle(fontSize: 20),),
    );
  }*/
}