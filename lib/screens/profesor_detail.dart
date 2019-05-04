import 'package:flutter/material.dart';
import 'package:upg_fisi/infrastructure/profesor_sqflite_repository.dart';
import 'package:upg_fisi/infrastructure/database_provider.dart';
import 'package:upg_fisi/model/profesor.dart';

ProfesorSqfliteRepository profesorRepository = ProfesorSqfliteRepository(DatabaseProvider.get);
final List<String> choices = const <String> [
  'Guardar Profesor & Volver',
  'Borrar Profesor',
  'Volver a la lista'
];

const mnuSave = 'Guardar Profesor & Volver';
const mnuDelete = 'Borrar Profesor';
const mnuBack = 'Volver a la lista';

class ProfesorDetail extends StatefulWidget {
  final Profesor profesor;
  ProfesorDetail(this.profesor);

  @override
  State<StatefulWidget> createState() => ProfesorDetailState(profesor);
}

class ProfesorDetailState extends State<ProfesorDetail> {
  Profesor profesor;
  ProfesorDetailState(this.profesor);
  final _nivelList = [1, 2, 3];  
  int _nivel = 1;

  TextEditingController nameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = profesor.name;
    lastnameController.text = profesor.lastname;
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(profesor.name+" "+profesor.lastname),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: select,
            itemBuilder: (BuildContext context) {
              return choices.map((String choice){
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Padding( 
        padding: EdgeInsets.only(top:35.0, left: 10.0, right: 10.0),
        child: ListView(children: <Widget>[Column(
        children: <Widget>[
          TextField(
            controller: nameController,
            style: textStyle,
            onChanged: (value) => this.updateName(),
            decoration: InputDecoration(
              labelText: "Nombre",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top:15.0, bottom: 15.0),
            child: TextField(
            controller: lastnameController,
            style: textStyle,
            onChanged: (value) => this.updateLastname(),
            decoration: InputDecoration(
              labelText: "Apellido",
              labelStyle: textStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
              )
            ),
          )),
          ListTile(title:DropdownButton<String>(
            items: _nivelList.map((int value) {
              return DropdownMenuItem<String> (
                value: value.toString(),
                child: Text(value.toString()),
              );
            }).toList(),
            style: textStyle,
            value: retrieveNivel(profesor.nivel).toString(),
            onChanged: (value) => updateNivel(value),
          ))
        ],
      )],)
      )
    );
  }

  void select (String value) async {
    int result;
    switch (value) {
      case mnuSave:
        save();
        break;
      case mnuDelete:
        Navigator.pop(context, true);
        if (profesor.id == null) {
          return;
        }
        result = await profesorRepository.delete(profesor);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: Text("Borrar Profesor"),
            content: Text("El profesor fue borrado"),
          );
          showDialog(
            context: context,
            builder: (_) => alertDialog);
          
        }
        break;
        case mnuBack:
          Navigator.pop(context, true);
          break;
      default:
    }
  }

  void save() {
    if (profesor.id != null) {
      debugPrint('update');
      profesorRepository.update(profesor);
    }
    else {
      debugPrint('insert');
      profesorRepository.insert(profesor);
    }
    Navigator.pop(context, true);
  }

  void updateNivel(String value) {
    switch (value) {
      case "1":
        profesor.nivel = 1;
        break;
      case "2":
        profesor.nivel = 2;
        break;
      case "3":
        profesor.nivel = 3;
        break;
    }
    setState(() {
     _nivel = int.parse(value);
    });
  }

  int retrieveNivel(int value) {
    return _nivelList[value];
  }

  void updateName(){
    profesor.name = nameController.text;
  }

  void updateLastname() {
    profesor.lastname = lastnameController.text;
  }
}
