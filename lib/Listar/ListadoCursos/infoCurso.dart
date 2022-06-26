import 'package:flutter/material.dart';

class infcurso extends StatefulWidget {
  infcurso({Key? key}) : super(key: key);

  @override
  State<infcurso> createState() => _infcursoState();
}

class _infcursoState extends State<infcurso> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informacion del curso'),
      ),
    );
  }
}